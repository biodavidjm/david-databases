#!/usr/bin/perl -w

use strict;
use feature qw/say/;
use autodie qw/open close/;

use Band;
use Album;
use Song;
use Show;
use Fan;

system('clear');

# # # # # # # # #
#
# To Do
#
# - - - - - - -
#
# # # # # # # # #


my $band_test = Band->new (
	band_name 		=> 'Radiohead',
	country 		=> 'England',
	);

say "The band is ".$band_test->band_name." from ".$band_test->country;

my $album_test = Album->new (
	album_name 		=>	'Ok Computer',																
	album_year		=>	'1997',
	);

say "The most influencial album is ".$album_test->album_name." (".$album_test->album_year.")";

my $show_test = Show->new (
	show_city 		=> 'Bilbao',
	show_country 	=> 'Spain',
	show_year		=> '2000',
	);

say "The first show that I saw was in ". $show_test->show_city ." (".$show_test->show_country.") in the year ". $show_test->show_year;

my $song_test = Song->new (
	song_name		=> 'Airbag',
	itunes_id		=> '19808',
	duration		=> '286432',
	track_number	=> '1',
	style			=> 'pop rock',
	);

say "Song: ".$song_test->song_name.", duration: ".$song_test->duration. " (".$song_test->get_duration_seconds." seconds)";

my $fan_test = Fan->new (
	fan_name 		=> 'David',
	);

say $fan_test->fan_name()." is a big fan of the band";

if ($fan_test->has_fan_name)
{
	say "\tYep, it has a fan name and is ".$fan_test->fan_name;
}
say "The name is not ".$band_test->band_name('Radio Head');






exit;

=head1 NAME

testing_music_objects.pl - Testing the Music classes 

=head1 SYNOPSIS

perl djmusic_parser01.pl


=head1 DESCRIPTION

The script to test the Music classes.
