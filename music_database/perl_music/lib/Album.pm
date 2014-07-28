package Album;

use Moose;
use Method::Signatures;
use feature qw/say/;

has 'album_name' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    predicate => 'has_album_name',
);

has 'album_year' => (
    is      => 'rw',
    isa     => 'Int',
    default => "NULL",
    predicate => 'has_album_year',
);

has 'band' => (
    is          =>  'rw',
    isa         =>  'Object',
    predicate   =>  'has_a_band',
);

has '_song_list' => (
    is      =>  'rw',
    isa     =>  'ArrayRef',
    traits  =>  [qw/Array/],
    lazy    =>  1,
    default =>  sub { return[] },
    handles => {
        'all_songs_in_album'    =>  'elements',
        'add_songs_in_album'    =>  'push',
        'total_songs_in_album'  =>  'count',
        'has_no_song'           =>  'is_empty',
    }
);

method add_band($band) {
    $self->band($band);
}

method add_song($song) {    
    $self->add_songs_in_album($song);
}

method get_song() {
    return $self->all_songs_in_album;
}

method total_song() {
    return $self->total_songs_in_album;
}

func album_duration() {
    #Get all the songs in the album and calculate the sum of duration
}

1;