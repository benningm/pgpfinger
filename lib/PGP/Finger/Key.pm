package PGP::Finger::Key;

use Moose;

# ABSTRACT: class for holding and parsing pgp keys
# VERSION

use Digest::SHA qw(sha256_hex);
use MIME::Base64;

use overload
    q{""}    => sub { $_[0]->pem },
    fallback => 1;


has 'data' => ( is => 'ro' );

has 'attributes' => ( is => 'ro', isa => 'HashRef[Str]', lazy => 1,
	traits => [ 'Hash' ],
	default => sub { {
		my $version;
		{
			no strict 'vars'; # is only declared in build
			$version = defined $VERSION ? $VERSION : 'head';
		}
		return { 'Version' => 'gpgfinger ('.$version.')'};
	} },
	handles => {
		set_attr => 'set',
		get_attr => 'get',
		has_attr => 'exists',
		has_attrs => 'count',
	},
);

sub merge_key {
	my ( $self, @keys ) = @_;

	foreach my $key ( @keys ) {
		$self->merge_attributes( $key->attributes );
	}
	return;
}

sub merge_attributes {
	my ( $self, $attr ) = @_;

	foreach my $name ( keys %$attr ) {
		if( ! $self->has_attr( $name ) ) {
			$self->set_attr( $name => $attr->{$name} );
		} else {
			$self->set_attr( $name => $self->get_attr($name).', '.$attr->{$name} );
		}
	}
	return;
}

around BUILDARGS => sub {
        my $orig  = shift;
        my $class = shift;

        if ( @_ == 1 && !ref $_[0] ) {
                return $class->$orig( data => $_[0] );
        } else {
                return $class->$orig(@_);
        }
};

sub new_pem {
	my $class = shift;
	my $pem = shift;
	
	my $b64 = '';
	my @lines = split( /\r?\n/, $pem );
	my $line;
	while( $line = shift @lines ) {
		if( $line =~ /^\s*$/ ) { next; }
		if( $line =~ /^-----BEGIN /) { last; } # here we start
		die('data before BEGIN line in PEM input');
	}
	if( ! @lines ) {
		die('end of PEM before -----BEGIN line has been found');
	}
	while( $line = shift @lines ) { # get headers if present
		if( $line =~ /:/ ) { next; }
		if( $line =~ /^\s*$/ ) { next; }
		last;
	}
	if( ! @lines ) {
		die('end of PEM before -----END line has been found');
	}
	$b64 .= $line;
	while( $line = shift @lines ) {
		if( $line =~ /^-----END /) { last; } # END
		$b64 .= $line;
	}
	if( $b64 eq '') {
		die('failed parsing PEM encoded key');
	}
	my $key = decode_base64( $b64 );

	return $class->new( $key );
}

has 'fingerprint' => ( is => 'ro', isa => 'Str', lazy_build => 1);

sub _build_fingerprint {
	my $self = shift;
	return sha256_hex( $self->data );
}

has 'pem' => ( is => 'ro', isa => 'Str', lazy_build => 1);

sub _build_pem {
	my $self = shift;
	my $pem = '';
	if( $self->has_attrs ) {
		$pem .= join( "\n",
			map {
				'# '.$_.': '.$self->get_attr($_)
			} keys %{$self->attributes} );
		$pem .= "\n";
	}
	$pem .= "-----BEGIN PGP PUBLIC KEY BLOCK-----\n";
	$pem .= encode_base64( $self->data );
	$pem .= "-----END PGP PUBLIC KEY BLOCK-----\n";
	return $pem;
}

sub clone {
	my $self = shift;
	my $class = ref( $self );
	return $class->new(
		data => $self->data,
		attributes => $self->attributes,
	);
}

1;

