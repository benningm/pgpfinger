package PGP::Finger::App;

use Moose;

# VERSION
# ABSTRACT: commandline interface to PGP::Finger

extends 'PGP::Finger';
with 'MooseX::Getopt';

use PGP::Finger::DNS;
use PGP::Finger::Keyserver;

has '+sources' => (
	traits => [ 'NoGetopt' ],
	default => sub {
		my $self = shift;
		my @srcs;
		foreach my $q ( @{$self->_query} ) {
			my $src;
			$q = lc($q);
			if( $q eq 'dns' ) {
				$src = PGP::Finger::DNS->new();
			} elsif( $q eq 'keyserver' ) {
				$src = PGP::Finger::Keyserver->new();
			} else {
				die('unknown query type: '.$q);
			}
			push( @srcs, $src );
		}
		return( \@srcs );
	},
);

has 'query' => ( is => 'ro', isa => 'Str', default => 'dns,keyserver',
	traits => ['Getopt'],
	cmd_aliases => 'q',
	documentation => 'sources to query (default: dns,keyserver)',
);

has '_query' => ( is => 'ro', isa => 'ArrayRef[Str]', lazy => 1,
	default => sub {
		my $self = shift;
		return [ split(/\s*,\s*/, $self->query) ];
	},
);

sub _usage_format {
	return "usage: %c %o <uid> <more uids ...>";
}

sub run {
	my $self = shift;
	my @uids = @{$self->extra_argv};

	if( ! @uids ) {
		print $self->usage;
		exit 1;
	}

	foreach my $uid ( @uids ) {
		my $resultset = $self->fetch( $uid );
		print $resultset->as_string;
	}

	return;
}

1;

