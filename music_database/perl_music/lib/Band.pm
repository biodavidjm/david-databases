package Band;

=pod

=head1 Band

Band -- A package class about a BAND of music

=cut

use Moose;
use Method::Signatures;
use Function::Parameters qw/:strict/;
use feature qw/say/;

=pod

=head1 ATTRIBUTES

=head2 Required

I<band_name>

=head2 Not required

- I<country>

- I<album> objects

- I<song> objects

- I<fan> objects

- I<show> objects

=cut

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
		'total_fan_in_band'	=> 	'count',
		'has_no_fan' 		=>  'is_empty',
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

with 'TotalDuration';

# sub BUILD () {
# 	say  "\tyes? someone has create an object with the Band class?";
# 	say "\tok, the band is ";
# 	# my $whatever = $self->band_name();
# }

=pod

=head1 METHODS

B<add_album()>, A Band can have multiple Albums. This method adds a "Album" objects,

B<get_album()>, get a list of album' objects

B<total_album()>, get the total number of albums,

B<add_song()>, add a Song object,

B<get_song()>, get a list of Song objects,

B<total_song()>, total number of songs,

B<add_fan()>, add a Fan object,

B<get_fan()>, get a fan list object,

B<total_fan()>, get the total number of fan objects,

B<add_show()>, add a show object,

B<get_show()>, get list of show objects,

B<total_show()>, get total number of shows,

B<band_song_duration()>, get the total duration of songs for this Band (using TotalDuration role),


=cut

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

method delete_album() {
	# This method is not needed at the moment
}

method add_song($song) {
	$self->add_songs_in_band($song);
}

method delete_song() {
	# This method is not needed at the moment
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

method delete_fan() {
	# This method is not needed at the moment
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

method delete_show()
{
	# This method is not needed at the moment
}

method total_show() {
	return $self->total_shows_in_band;
}

# the method requiring the role TotalDuration
method band_song_duration () {
	my @allsongs = $self->get_song;
	my $totaltime  = 0;
	foreach my $song (@allsongs)
	{
		$totaltime+=$song->duration;
	}
	my $nice = get_duration_in_seconds($totaltime);
	return $nice;
}



1;

__END__