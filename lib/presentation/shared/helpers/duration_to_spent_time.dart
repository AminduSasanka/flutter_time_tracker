String durationToSpentTime(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  int additionalMinutes = (seconds / 60).round();
  minutes += additionalMinutes;

  return "${hours}h ${minutes}m";
}