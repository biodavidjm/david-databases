package Band;

use Moose;
use Method::Signatures;
use feature qw/say/;

# Attributes
has 'band_name' => (
	is => 'rw',
	isa => 'Str',
	required => 1,
	predicate => 'has_fan_name',
	# The reader and writer are not necessary to write!
	# reader => 'get_band_name',
	# writer => 'set_band_name'
);

has 'country' => (
	is => 'rw',
	isa => 'Str',
	default => 'NULL',
	predicate => 'has_country',
	# reader => 'get_country',
	# writer => 'set_country'
);

has '_album_list' => (
	is		=>	'rw',
	isa		=>	'ArrayRef',
	traits	=>	[qw/Array/],
	lazy	=>	1,
	default	=>	sub { return[] },
	handles	=> {
		'all_albums_in_band'	=>	'elements',
		'add_albums_in_band'	=>	'push',
		'total_albums_in_band'	=>	'count',
		'has_no_album' 			=>  'is_empty',
	}
);

# has '_album_list' => (
# 	is		=>	'rw',
# 	isa		=>	'ArrayRef',
# 	auto_deref	=>	1,
# 	lazy	=>	1,
# 	default	=>	sub { return[] },
# );


has '_song_list' => (
	is		=>	'rw',
	isa		=>	'ArrayRef',
	traits	=>	[qw/Array/],
	lazy	=>	1,
	default	=>	sub { return[] },
	handles	=> {
		'all_songs_in_band'		=>	'elements',
		'add_songs_in_band'		=>	'push',
		'total_songs_in_band'	=>	'count',
		'has_no_song' 			=> 'is_empty',
	}
);

has '_fan_list' => (
	is		=>	'rw',
	isa		=>	'ArrayRef',
	traits	=>	[qw/Array/],
	lazy	=>	1,
	default	=>	sub { return[] },
	handles	=> {
		'all_fan_in_band'	=>	'elements',
		'add_fan_in_band'	=>	'push',
		'total_fan_in_band'	=>	'count',
		'has_no_fan' 		=> 'is_empty',
	}
);

has '_show_list' => (
	is		=>	'rw',
	isa		=>	'ArrayRef',
	traits	=>	[qw/Array/],
	lazy	=>	1,
	default	=>	sub { return[] },
	handles	=> {
		'all_show_in_band'	=>	'elements',
		'add_show_in_band'	=>	'push',
		'total_show_in_band'	=>	'count',
		'has_no_show' 		=> 'is_empty',
	}
);

# sub BUILD () {
# 	say  "\tyes? someone has create an object with the Band class?";
# 	say "\tok, the band is ";
# 	# my $whatever = $self->band_name();
# }

method add_album($album) {
	# my $all_albums = $self->_album_list;
	# push @$all_albums, $album;
	# $self->_album_list($all_albums);
	$self->add_albums_in_band($album);
}

method get_album() {
	return $self->all_albums_in_band;
}

method total_album() {
	return $self->total_albums_in_band;
}

method add_song($song) {
	$self->add_songs_in_band($song);
}

method get_song() {
	return $self->all_songs_in_band;
}

method total_song() {
	return $self->total_songs_in_band;
}


method add_fan($fan){
	$self->add_fan_in_band($fan);
}

method get_fan() {
	return $self->all_fans_in_band;
}

method total_fan() {
	return $self->total_fans_in_band;
}

method add_show($show){
	$self->add_show_in_band($show);
}

method get_show() {
	return $self->all_shows_in_band;
}

method total_show() {
	return $self->total_shows_in_band;
}

1;