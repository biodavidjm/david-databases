package Duration;

use Moose::Role;

method songlist_duration (@allsongs{
  # my @allsongs = $self->get_song;
  my $totaltime  = 0;
  foreach my $song (@allsongs)
  {
    $totaltime+=$song->duration;
  }
  my $nice = get_duration_seconds($totaltime);
  return $nice;
}

sub get_duration_seconds{
    my ($millisec) = @_;
        
    # CONVERT TO HH:MM:SS
    my $sec = ($millisec * 0.001);

    my $hours = floor($sec/3600);
    my $remainder_1 = ($sec % 3600);
    my $minutes = floor($remainder_1 / 60);
    my $seconds = ($remainder_1 % 60);

    # PREP THE VALUES
    if(length($hours) == 1) {
        $hours = "0".$hours;
    }

    if(length($minutes) == 1) {
        $minutes = "0".$minutes;
    }

    if(length($seconds) == 1) {
        $seconds = "0".$seconds;
    }

    my $here = $hours.":".$minutes.":".$seconds;

    return $here;

}
