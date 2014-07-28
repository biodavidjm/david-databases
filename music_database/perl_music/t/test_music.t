use strict;
use Test::More qw/no_plan/;

use_ok 'Band';
use_ok 'Album';
use_ok 'Fan';
use_ok 'Playlist';
use_ok 'Show';
use_ok 'Song';


my $band_test1 = Band->new(
    band_name => 'Radiohead',
    country   => 'England',
);

my $band_test2 = Band->new(
    band_name => 'Vicente Amigo',
    country   => 'Spain',
);

isa_ok($band_test1, 'Band');
isa_ok($band_test2, 'Band');

my $album_test1 = Album->new(
    album_name => 'Ok Computer',
    album_year => '1997',
);

my $album_test2 = Album->new(
    album_name => 'Kid A',
    album_year => '2000',
);

isa_ok($album_test1, 'Album');
isa_ok($album_test2, 'Album');


my $show_test = Show->new(
    show_city    => 'Bilbao',
    show_country => 'Spain',
    show_year    => '2000',
);

isa_ok($show_test, 'Show');

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

