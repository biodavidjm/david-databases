package Playlist;

=pod

=head1 Playlist

Playlist -- A package class about a PLAYLIST of music

=cut

use Moose;
use Method::Signatures;
use Function::Parameters qw/:strict/;
use feature qw/say/;
use POSIX; # For mathematical functions like ceil and floor

=pod

=head1 ATTRIBUTES

=head2 Required

- I<playlist_name>,

=head2 Not Required

- I<created_by>

- I<track_number>

- I<style>

=cut


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
        'all_songs'    =>  'elements',
        'add_songs_in_playlist'    =>  'push',
        'total_songs_in_playlist'  =>  'count',
        'has_no_song'           =>  'is_empty',
    }
);

with 'TotalDuration';

=pod

=head1 METHODS

B<add_song()>, add a Song object,

B<get_song()>, get a list of Song objects,

B<total_song()>, total number of songs,

B<playlist_duration()>, get the total duration of songs for this Playlist (using TotalDuration role),

B<search_song()>, Search for a song in the list

=cut

method add_song ($song) {
    if( $self->search_song($song->song_name) )
    {
        $self->add_songs_in_playlist($song);
    }
    else
    {
        say "\n\tThis song is already here\n";
    }
}

method delele_song () {
    # This method is not needed at the moment
}

method get_song () {
	return $self->all_songs;	
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
	my $nice = get_duration_in_seconds($totaltime);
	return $nice;
}

method search_song ($song_name) {
    my @allsongs = $self->get_song;
    my $flag = 0;
    foreach my $song (@allsongs)
    {
        if ($song_name eq $song->song_name) 
        {
            $flag = 1;
            last;
        }
    }
    if ($flag == 1)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

# sub get_duration_seconds{
#     my ($millisec) = @_;
        
#     # CONVERT TO HH:MM:SS
#     my $sec = ($millisec * 0.001);

#     my $hours = floor($sec/3600);
#     my $remainder_1 = ($sec % 3600);
#     my $minutes = floor($remainder_1 / 60);
#     my $seconds = ($remainder_1 % 60);

#     # PREP THE VALUES
#     if(length($hours) == 1) {
#         $hours = "0".$hours;
#     }

#     if(length($minutes) == 1) {
#         $minutes = "0".$minutes;
#     }

#     if(length($seconds) == 1) {
#         $seconds = "0".$seconds;
#     }

#     my $here = $hours.":".$minutes.":".$seconds;

#     return $here;
# }


1;

__END__