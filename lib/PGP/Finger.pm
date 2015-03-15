package PGP::Finger;

use Moose;

# ABSTRACT: retrieve PGP keys from different sources
# VERSION

use PGP::Finger::DNS;
use PGP::Finger::Keyserver;
use PGP::Finger::ResultSet;

has 'sources' => ( is => 'ro', isa => 'ArrayRef[PGP::Finger::Source]', lazy => 1,
	default => sub { [
		PGP::Finger::DNS->new,
		PGP::Finger::Keyserver->new,
	] },
);

sub fetch {
	my ( $self, $addr ) = @_;
	my $resultset = PGP::Finger::ResultSet->new;

	foreach my $source ( @{$self->sources} ) {
		my $result = $source->fetch( $addr );
		if( ! defined $result ) { next; }
		$resultset->add_result( $result );
	}
	return $resultset;
}

1;


