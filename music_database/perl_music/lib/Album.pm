package Album;

use Moose;
use Method::Signatures;
use Function::Parameters qw/:strict/;
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
        'all_songs'    =>  'elements',
        'add_songs_in_album'    =>  'push',
        'total_songs_in_album'  =>  'count',
        'has_no_song'           =>  'is_empty',
    }
);

method add_band($band) {
    if (!$self->has_a_band)
    {
        $self->band($band);
    }
    else
    {
        say "Sorry, band cannot be added";    
    }
}

method add_song($song) {    
    $self->add_songs_in_album($song);
}

method get_song() {
    return $self->all_songs;
}

method total_song() {
    return $self->total_songs_in_album;
}


1;