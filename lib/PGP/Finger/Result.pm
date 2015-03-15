package PGP::Finger::Result;

use Moose;

# ABSTRACT: a gpgfinger result object
# VERSION

has 'keys' => (
	is => 'ro', isa => 'ArrayRef[PGP::Finger::Key]', lazy => 1,
	traits => [ 'Array' ],
	default => sub { [] },
	handles => {
		add_key => 'push',
		count => 'count',
	},
);

1;

