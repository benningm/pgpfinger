package PGP::Finger::GPG;

use Moose;

extends 'PGP::Finger::Source';

# ABSTRACT: gpgfinger source to query local gnupg
# VERSION

use PGP::Finger::Result;
use PGP::Finger::Key;

use IPC::Run qw(run);

has 'cmd' => ( is => 'ro', isa => 'ArrayRef', lazy => 1,
	default => sub { [ '/usr/bin/gpg', '--export' ] },
);

sub fetch {
	my ( $self, $addr ) = @_;
	my @cmd = ( @{$self->cmd}, $addr );
	my ( $in, $out, $err );
	run( \@cmd, \$in, \$out, \$err )
		or die('error running gpg: '.$err.' ('.$!.')');

	my $result = PGP::Finger::Result->new;
	my $key = PGP::Finger::Key->new(
		mail => $addr,
		data => $out,
	);
	$key->set_attr( source => 'local GnuPG' );

	$result->add_key( $key );
	return $result;
}

1;

