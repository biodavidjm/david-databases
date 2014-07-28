package Artist;

use Moose;
use Method::Signatures;
use Function::Parameters qw/:strict/;
use feature qw/say/;

# Inheritance
extends 'Band';

has 'singer_name' => (
	is => 'rw',
	isa => 'Str',
	required => 1,
	predicate => 'has_singer_name',
);

1;