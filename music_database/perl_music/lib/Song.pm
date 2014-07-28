package Song;

use Moose;
use Method::Signatures;
use feature qw/say/;

use POSIX; # For mathematical functions like ceil and floor


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
    $self->band($band);
}

method add_album($album) {
    $self->album($album);
}


1;