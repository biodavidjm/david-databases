package Song;

=pod

=head1 Song

Song -- A package class about a SONG of music

=cut

use Moose;
use Method::Signatures;
use Function::Parameters qw/:strict/;
use feature qw/say/;
use POSIX; # For mathematical functions like ceil and floor

=pod

=head1 ATTRIBUTES

=head2 Required

- I<song_name>,

- I<itunes_id>,

=head2 Not Required

- I<duration>

- I<track_number>

- I<style>

- I<band> object, only one.

- I<album> objects, only one.

=cut

has 'song_name' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    predicate => 'has_song_name',
);

has 'itunes_id' => (

    is       => "rw",
    isa      => 'Int',
    required => 1,
    predicate => 'has_itunes_id',
);

has 'duration' => (
    is       => 'rw',
    isa      => 'Int',
    predicate => 'has_duration',
);

has 'track_number' => (
    is     => 'rw',
    isa    => 'Int',
    predicate => 'has_track_number',
);

has 'style' => (
	is => 'rw',
	isa => 'Str',
    predicate => 'has_style',
);

has 'band' => (
    is          =>  'rw',
    isa         =>  'Object',
    predicate   =>  'has_a_band',
);

has 'album' => (
    is          =>  'rw',
    isa         =>  'Object',
    predicate   =>  'has_an_album',
);

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


method get_duration_seconds{
    my $millisec = $self->duration();
    
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

# before 'get_duration_seconds' => sub { print "\t\tAbout to call get_duration_seconds\n"; };
# after 'get_duration_seconds'  => sub { print "\t\tjust called get_duration_seconds\n"; };

method add_band($band) {
    if (!$self->has_a_band)
    {
        $self->band($band);
    }
    else
    {
        say "\n\tSorry, band cannot be added. The song '".$self->song_name."' already has a band (".$self->band->band_name.")";    
    }
}

method delete_band() {
    # This method is not needed at the moment
}

method replace_band() {
    # This method is not needed at the moment
}

method add_album($album) {
    if (!$self->has_an_album)
    {
        $self->album($album);
    }
    else
    {
        say "\n\tSorry, band cannot be added. The song '".$self->song_name."' already has an album (".$self->band->band_name.")";    
    }
}

method delete_album() {
    # This method is not needed at the moment
}

method replace_album() {
    # This method is not needed at the moment
}


1;

__END__