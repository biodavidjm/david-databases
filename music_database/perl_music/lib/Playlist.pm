package Playlist;

use Moose;
use Method::Signatures;
use feature qw/say/;

use POSIX; # For mathematical functions like ceil and floor

has 'playlist_name' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    predicate => 'has_playlist_name',
);

has 'created_by' => (
    is      => 'rw',
    isa     => 'Str',
    predicate => 'has_created_by',
);

has '_song_list' => (
    is      =>  'rw',
    isa     =>  'ArrayRef',
    traits  =>  [qw/Array/],
    lazy    =>  1,
    default =>  sub { return[] },
    handles => {
        'all_songs_in_playlist'    =>  'elements',
        'add_songs_in_playlist'    =>  'push',
        'total_songs_in_playlist'  =>  'count',
        'has_no_song'           =>  'is_empty',
    }
);

method add_song ($song) {
	$self->add_songs_in_playlist($song);
}

method get_song () {
	return $self->all_songs_in_playlist;	
}

method total_song () {
	return $self->total_songs_in_playlist;
}

method playlist_duration () {
	my @allsongs = $self->get_song;
	my $totaltime  = 0;
	foreach my $song (@allsongs)
	{
		$totaltime+=$song->duration;
	}
	my $nice = get_duration_seconds($totaltime);
	return $nice;
}

sub get_duration_seconds{
    my ($millisec) = @_;
        
    # CONVERT TO HH:MM:SS
    my $sec = ($millisec * 0.001);

    my $hours = floor($sec/3600);
    my $remainder_1 = ($sec % 3600);
    my $minutes = floor($remainder_1 / 60);
    my $seconds = ($remainder_1 % 60);

    # PREP THE VALUES
    if(length($hours) == 1) {
        $hours = "0".$hours;
    }

    if(length($minutes) == 1) {
        $minutes = "0".$minutes;
    }

    if(length($seconds) == 1) {
        $seconds = "0".$seconds;
    }

    my $here = $hours.":".$minutes.":".$seconds;

    return $here;

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