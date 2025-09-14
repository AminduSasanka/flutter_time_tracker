Duration spentTimeToDuration(String durationString) {
  String cleanString = durationString.replaceAll(' ', '').toLowerCase();

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  RegExp hoursRegex = RegExp(r'(\d+)h');
  Match? hoursMatch = hoursRegex.firstMatch(cleanString);
  if (hoursMatch != null) {
    hours = int.parse(hoursMatch.group(1)!);
  }

  RegExp minutesRegex = RegExp(r'(\d+)m');
  Match? minutesMatch = minutesRegex.firstMatch(cleanString);
  if (minutesMatch != null) {
    minutes = int.parse(minutesMatch.group(1)!);
  }

  RegExp secondsRegex = RegExp(r'(\d+)s');
  Match? secondsMatch = secondsRegex.firstMatch(cleanString);
  if (secondsMatch != null) {
    seconds = int.parse(secondsMatch.group(1)!);
  }

  int additionalMinutes = (seconds / 60).round();
  minutes += additionalMinutes;

  if (minutes >= 60) {
    hours += minutes ~/ 60;
    minutes = minutes % 60;
  }

  return Duration(hours: hours, minutes: minutes, seconds: 0);
}