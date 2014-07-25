#!/usr/bin/perl -w

use Modern::Perl;
use feature qw/say/;
use autodie qw/open close/;

use Band;
use Album;
use Song;
use Show;
use Fan;
use Playlist;

system('clear');

# # # # # # # # #
#
# To Do
#
# - - - - - - -
#
# # # # # # # # #

# CREATE OBJECTS OF EVERY CLASS FOR TESTING
my $band_test = Band->new(
    band_name => 'Radiohead',
    country   => 'England',
);
say "The band is " . $band_test->band_name . " from " . $band_test->country;

my $band_test2 = Band->new(
    band_name => 'Vicente Amigo',
    country   => 'Spain',
);
say "The band is " . $band_test2->band_name . " from " . $band_test2->country;

my $album_test = Album->new(
    album_name => 'Ok Computer',
    album_year => '1997',
);

my $album_test2 = Album->new(
    album_name => 'Kid A',
    album_year => '2000',
);

say "The most influencial album is "
    . $album_test->album_name . " ("
    . $album_test->album_year . ")";

my $show_test = Show->new(
    show_city    => 'Bilbao',
    show_country => 'Spain',
    show_year    => '2000',
);

say "The first show that I saw was in "
    . $show_test->show_city . " ("
    . $show_test->show_country
    . ") in the year "
    . $show_test->show_year;

my $song_test = Song->new(
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

say "Song: "
    . $song_test->song_name
    . ", duration: "
    . $song_test->duration . " ("
    . $song_test->get_duration_seconds
    . " seconds)";

my $fan_test = Fan->new( fan_name => 'David', );

say $fan_test->fan_name() . " is a big fan of the band";

if ( $fan_test->has_fan_name ) {
    say "\tYep, it has a fan name and is " . $fan_test->fan_name;
}

say "\nLet's add Albums to Band--------->";

$band_test->add_album($album_test);
$band_test->add_album($album_test2);

my $numberalbums = $band_test->total_album;

say "\tNumber of bands: " . $numberalbums;

my @temp = $band_test->get_album;
foreach my $album (@temp) {
    say "\t" . $band_test->band_name . " " . $album->album_name, "  ",
        $album->album_year;
}

say "Add songs to band-------->";
$band_test->add_song($song_test);
my @songs = $band_test->get_song;

foreach my $song (@songs) {
    print "\t"
        . $band_test->band_name . " "
        . $song->song_name
        . " Track #:"
        . $song->track_number
        . " iTunes ID:"
        . $song->itunes_id
        . " Duration:"
        . $song->get_duration_seconds . "\n";
}

say "Playing with the Album object ";

$album_test->add_band($band_test);

say "\tThe album '"
    . $album_test->album_name
    . "' belongs to the band "
    . $album_test->band->band_name;
$album_test->add_song($song_test);
$album_test->add_song($song_test2);

say "\tYou have " . $album_test->total_song . " songs for this artist";
my @songs2 = $album_test->get_song;
foreach my $song (@songs2) {
    print "\t\t"
        . $song->song_name
        . " ---> Track #:"
        . $song->track_number
        . " iTunes ID:"
        . $song->itunes_id
        . " Duration:"
        . $song->get_duration_seconds
        . " (remember, the band is: "
        . $album_test->band->band_name . ")\n";
}

$song_test->add_band($band_test);
$song_test->add_album($album_test);

say $song_test->song_name
    . " belongs to "
    . $song_test->band->band_name
    . " and the album "
    . $song_test->album->album_name;

say "Add bands to fan-------->";

say "\tLet's add the first band: " . $band_test->band_name;
$fan_test->add_band($band_test);

say "\tLet's add the second band: " . $band_test2->band_name;
$fan_test->add_band($band_test2);

my @fanban = $fan_test->get_band;
say "\nLet's review fan and bands.";
say "\t" . $fan_test->fan_name . " likes: ";

foreach my $obj_ban (@fanban) {
    say "\t\t" . $obj_ban->band_name;
}

say "\ti.e., "
    . $fan_test->fan_name
    . " likes "
    . $fan_test->total_band
    . " bands";

say "Add songs to playlist-------->";
my $playlist_test = Playlist->new( playlist_name => 'My best songs' );
say "\t" . $playlist_test->playlist_name;

$playlist_test->add_song($song_test);
say "\tLast song " . $song_test->get_duration_seconds;
say "\tPlaylist: " . $playlist_test->playlist_duration . "\n";

$playlist_test->add_song($song_test2);
say "\tLastSong: " . $song_test2->get_duration_seconds;
say "\tPlaylist: " . $playlist_test->playlist_duration;

exit;

=head1 NAME

testing_music_objects.pl - Testing the Music classes 

=head1 SYNOPSIS

perl djmusic_parser01.pl


=head1 DESCRIPTION

The script to test the Music classes. This is not a unit test, obviously.
