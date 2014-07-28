use strict;
use Test::More qw/no_plan/; 
# The no_plan option allows you not to pass the number of test that you are expecting to pass.
# Basically traduces in that it is not needed to add at the end of the script the option 
# done_testing();

use Modern::Perl;

use_ok 'Band';
use_ok 'Album';
use_ok 'Fan';
use_ok 'Playlist';
use_ok 'Show';
use_ok 'Song';

# Band object examples
my $band_test1 = Band->new(
    band_name => 'Radiohead',
    country   => 'England',
);

my $band_test2 = Band->new(
    band_name => 'Vicente Amigo',
    country   => 'Spain',
);

# Test band objects:
isa_ok($band_test1, 'Band');
can_ok($band_test1, 'add_album');
can_ok($band_test1, 'get_album');
can_ok($band_test1, 'total_album');
can_ok($band_test1, 'add_song');
can_ok($band_test1, 'get_song');
can_ok($band_test1, 'total_song');
can_ok($band_test1, 'add_fan');
can_ok($band_test1, 'get_fan');
can_ok($band_test1, 'total_fan');
can_ok($band_test1, 'add_show');
can_ok($band_test1, 'get_show');
can_ok($band_test1, 'total_show');


# Album examples
my $album_test1 = Album->new(
    album_name => 'Ok Computer',
    album_year => '1997',
);

my $album_test2 = Album->new(
    album_name => 'Kid A',
    album_year => '2000',
);

isa_ok($album_test1, 'Album');
can_ok($album_test1, 'add_band');
can_ok($album_test1, 'add_song');
can_ok($album_test1, 'get_song');
can_ok($album_test1, 'total_song');


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

isa_ok($song_test1,'Song');
can_ok($song_test1,'add_band');
can_ok($song_test1,'add_album');
can_ok($song_test1,'get_duration_seconds');

# Show examples
my $playlist_test = Playlist->new(
    playlist_name   =>  'Patio',
    created_by      =>  'David',
);

isa_ok($playlist_test,'Playlist');
can_ok($playlist_test,'add_song');
can_ok($playlist_test,'get_song');
can_ok($playlist_test,'total_song');
can_ok($playlist_test,'playlist_duration');

# Interactions between classes
$album_test1->add_band($band_test1);
is ($album_test1->has_a_band, 1);

$album_test1->add_song($song_test1);
$album_test1->add_song($song_test2);
is($album_test1->total_song, 2);



