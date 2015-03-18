package PGP::Finger::ResultSet;

use Moose;

# ABSTRACT: object to hold and merge Result objects
# VERSION

has 'results' => (
	is => 'ro', isa => 'ArrayRef[PGP::Finger::Result]', lazy => 1,
	traits => [ 'Array' ],
	default => sub { [] },
	handles => {
		add_result => 'push',
		count => 'count',
	},
);

sub merged_keys {
	my $self = shift;
	my %keys;

	foreach my $result ( @{$self->results} ) {
		foreach my $key ( @{$result->keys} ) {
			my $fp = $key->fingerprint;
			if( defined $keys{$fp} ) {
				$keys{$fp}->merge_key( $key );
			} else {
				$keys{$fp} = $key->clone;
			}
		}
	}

	return( values %keys );
}

sub as_string {
	my ( $self, $type ) = @_;
	$type = lc $type;
	my @keys = $self->merged_keys;
	my $result = '';

	foreach my $key ( @keys ) {
		if( $type eq 'armored' ) {
			$result .= $key->armored;
		} elsif ( $type eq 'binary' ){
			$result .= $key->data;
		} elsif ( $type eq 'generic' ){
			$result .= $key->dns_record_generic;
		} elsif ( $type eq 'rfc' ){
			$result .= $key->dns_record_rfc;
		} else {
			die('invalid output format: '.$type);
		}
	}

	return $result;
}

1;

