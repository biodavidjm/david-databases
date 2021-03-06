package Show;

use Moose;
use Method::Signatures;
use Moose::Util::TypeConstraints;
use Function::Parameters qw/:strict/;

use feature qw/say/;

# Attributes

has 'show_city' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    predicate => 'has_show_city',
);

has 'show_country' => (
	is 		=> 'rw',
	isa		=> 'Str',
	required => 1,
	predicate => 'has_show_country',
);

subtype 'modern_time',
      as 'Int',
      where { my $currentyear = (localtime)[5] + 1900; $currentyear>= $_ && $_ >= 1990 },
      message { "The date $_ you provided is not modern enough" };

has 'show_year' => (
	is 		=>	'ro',
	isa		=>	'modern_time',
	predicate => 'has_modern_time',
);

subtype 'Between0and5',
      as 'Int',
      where { 0 <= $_ && $_ <= 5},
      message { "Ratings are between 0 and 5 (yoou provide $_)" };

has 'rating' => (
	is => 'rw',
	isa=> 'Between0and5',
);


has 'show_name' => (
	is 		=> 'rw',
	isa 	=> 'Str',
	default => 'Live',
    lazy    => 1,
);

has '_band_list' => (
    is      =>  'rw',
    isa     =>  'ArrayRef',
    traits  =>  [qw/Array/],
    lazy    =>  1,
    default =>  sub { return[] },
    handles => {
        'all_bands_in_show'    =>  'elements',
        'add_bands_in_show'    =>  'push',
        'total_bands_in_show'  =>  'count',
        'has_no_band'         =>  'is_empty',
    }
);

method add_band( $band ) {
	$self->add_bands_in_show($band);
}

method get_band() {
	return $self->all_bands_in_show;
}

method total_band() {
	return $self->total_bands_in_show;
}

method current_year {
	my $currentyear = (localtime)[5] + 1900;
	return $currentyear;
}


# method set_song_name (Str $key){

# 	return $self->song_name($key);

# }

# method set_itunes_id (Int $key){

# 	return $self->itunes_id($key);

# }

# method set_duration (Int $key){

# 	return $self->duration($key);

# }

# method set_track_number (Int $key){

# 	return $self->track_number($key);

# }

# method set_song_style (Str $key){

# 	return $self->style($key);

# }

1;