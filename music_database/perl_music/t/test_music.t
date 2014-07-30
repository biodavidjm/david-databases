use strict;
use Test::More qw/no_plan/; 
# The no_plan option allows you not to pass the number of test that you are expecting to pass.
# Basically traduces in that it is not needed to add at the end of the script the option 
# done_testing();

=pod
 
=head1 NAME
 
test_music.t -- Unit test for all the music classes
 
=cut

use Modern::Perl;

use_ok 'Band';
use_ok 'Album';
use_ok 'Fan';
use_ok 'Playlist';
use_ok 'Show';
use_ok 'Song';

 
=head1 OBJECTS

=over

=item Band 

=item Album

=item Song

=item Playlist 

=back

=cut

# The list of classes that it tests
my @classes = qw(Band Album Song Playlist);

# Band object examples
my $band_test1 = Band->new(
    band_name => 'Radiohead',
    country   => 'England',
);

my $band_test2 = Band->new(
    band_name => 'Vicente Amigo',
    country   => 'Spain',
);

# Test band object is a band object and nothing else
ok( defined($band_test1) && ref $band_test1 eq 'Band', 'The new() works for Band' );
foreach my $class (@classes)
{
    if ($class eq 'Band') {
        isa_ok($band_test1, $class, '   The BAND object');
    }
    else {
        isnt($band_test1, $class, '   Right, it is NOT a <'.$class.'> object');
    }
}
my @methods_band = qw(add_album get_album get_album total_album add_song get_song total_song add_fan get_fan total_fan add_show get_show total_show);
can_ok($band_test1, @methods_band);

# Checking the Class attributes
ok( $band_test1->band_name  eq 'Radiohead', 'band_name() works');
ok( $band_test1->country   eq 'England', 'country() works' );


# Album examples
my $album_test1 = Album->new(
    album_name => 'Ok Computer',
    album_year => '1997',
);

my $album_test2 = Album->new(
    album_name => 'Kid A',
    album_year => '2000',
);

# Test album object is a album object and nothing else
ok( defined($album_test1) && ref $album_test1 eq 'Album', 'The new() works for Album' );
foreach my $class (@classes)
{
    if ($class eq 'Album') {
        isa_ok($album_test1, $class,'   The ALBUM object');
    }
    else {
        isnt($album_test1, $class,'   Right, it is NOT a <'.$class.'> object');
    }
}

my @methods_album = qw(add_band add_song get_song total_song album_song_duration search_song);
can_ok($album_test1, @methods_album);

# Checking the Class attributes
ok( $album_test1->album_name  eq 'Ok Computer', 'album_name() get');
ok( $album_test1->album_year  eq '1997', 'album_year()  get' );


# Songs examples
my $song_test1 = Song->new(
    song_name    => 'Airbag',
    itunes_id    => '19808',
    duration     => '286432',
    track_number => '1',
    style        => 'pop rock',
);

my $song_test2 = Song->new(
    song_name    => 'Paranoid Android',
    itunes_id    => '19809',
    duration     => '286476',
    track_number => '2',
    style        => 'pop rock',
);

# Test SONG object is a SONG object and nothing else
ok( defined($song_test1) && ref $song_test1 eq 'Song', 'The new() works for Song' );
foreach my $class (@classes)
{
    if ($class eq 'Song') {
        isa_ok($song_test1, $class,'   The SONG object');
    }
    else {
        isnt($song_test1, $class,'   Right, it is NOT a <'.$class.'> object');
    }
}

my @methods_song = qw(add_band add_album get_duration_seconds);
can_ok($song_test1,@methods_song);

# Checking the Class attributes
ok( $song_test1->song_name  eq 'Airbag', '    song_name() works');
ok( $song_test1->itunes_id  eq '19808', '    itunes_id() works');
ok( $song_test1->duration  eq '286432', '    duration() works');
ok( $song_test1->track_number  eq '1', '    track_number() works');
ok( $song_test1->style  eq 'pop rock', '    style() works');

# Playlist examples
my $playlist_test1 = Playlist->new(
    playlist_name   =>  'Patio',
    created_by      =>  'David',
);

# Test SONG object is a SONG object and nothing else
ok( defined($playlist_test1) && ref $playlist_test1 eq 'Playlist', 'The new() works for PLAYLIST' );
foreach my $class (@classes)
{
    if ($class eq 'Playlist') {
        isa_ok($playlist_test1, $class,'   The PLAYLIST object');
    }
    else {
        isnt($playlist_test1, $class,'   Right, it is NOT a <'.$class.'> object');
    }
}

my @methods_playlist = qw(add_song total_song playlist_duration);
can_ok($playlist_test1, @methods_playlist);

# Checking the Class attributes
ok( $playlist_test1->playlist_name  eq 'Patio', '    playlist_name() works');
ok( $playlist_test1->created_by  eq 'David', '    created_by() works');


=pod

=over

=item * Interaction between classes

=back 

=cut

$album_test1->add_band($band_test1);
is ($album_test1->has_a_band, 1, "Band accept Album objects");

$album_test1->add_song($song_test1);
$album_test1->add_song($song_test2);
is ($album_test1->total_song, 2, "Album accept SONG objects");

# is ($album_test1->add_song($song_test1), 1, "Album accept several SONG objects");


__END__