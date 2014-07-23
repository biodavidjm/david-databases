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


method add_band() {

}

method delete_band() {

}

method add_song() {

}

method delete_song(){

}

method add_cover() {

}

method delete_cover() {

}

method add_to_playlist () {

}

method delete_from_playlist () {
    
}

func album_duration() {

}

1;

