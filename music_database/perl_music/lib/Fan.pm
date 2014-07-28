package Fan;

use Moose;
use Method::Signatures;
use feature qw/say/;

has 'fan_name' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    predicate => 'has_fan_name',
);

has '_band_list' => (
    is      =>  'rw',
    isa     =>  'ArrayRef',
    traits  =>  [qw/Array/],
    lazy    =>  1,
    default =>  sub { return[] },
    handles => {
        'all_bands_in_fan'    =>  'elements',
        'add_bands_in_fan'    =>  'push',
        'total_bands_in_fan'  =>  'count',
        'has_no_band'         =>  'is_empty',
    }
);

method add_band( $band ) {
	$self->add_bands_in_fan($band);
}

method get_band() {
	return $self->all_bands_in_fan;
}

method total_band() {
	return $self->total_bands_in_fan;
}


1;