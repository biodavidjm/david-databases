package Playlist;

use Moose;
use Method::Signatures;
use feature qw/say/;


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

method add_song () {

}

method delete_song () {
    
}

func playlist_duration () {
    
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