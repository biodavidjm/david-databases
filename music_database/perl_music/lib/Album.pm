package Album;

=pod

=head1 Album

Album -- A package class about an album of music

=cut


use Moose;
use Method::Signatures;
use Function::Parameters qw/:strict/;
use feature qw/say/;

=pod

=head1 ATTRIBUTES

=head2 Required

I<album_name>

=head2 Not required

- I<album_year>

- I<band> object

- I<song> objects

=cut


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

with 'TotalDuration';

=pod

=head1 METHODS

B<add_band()>

An Album only can have one band. This method added a "Band" object

=cut

method add_band($band) {
    if (!$self->has_a_band)
    {
        $self->band($band);
    }
    else
    {
        say "\n\tSorry, band cannot be added. The album '".$self->album_name."' already has a band (".$self->band->band_name.")";    
    }
}

method add_song($song) {    

    $self->add_songs_in_album($song);
}

method add_song ($song) {
    if( $self->search_song($song->song_name) )
    {
        $self->add_songs_in_album($song);
    }
    else
    {
        say "\n\tThis song is already in this album\n";
    }
}

=pod

B<get_song()>

Gets the songs for the package. Returns a list of songs as B<Song> objects. 

=cut

method get_song() {
    return $self->all_songs;
}


=pod

B<total_song()>

Total number of songs

=cut

method total_song() {
    return $self->total_songs_in_album;
}

=pod

B<album_song_duration()>

Calculate the duration of all the songs stored in album

=cut

method album_song_duration () {
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


1;

__END__

