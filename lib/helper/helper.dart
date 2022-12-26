

String getNameDay(int day) {
  String? name;
  if (day == 0) {
    name = 'Monday';
  } else if (day == 1) {
    name = 'Sunday';
  } else if (day == 2) {
    name = 'Tuesday';
  } else if (day == 3) {
    name = 'Wednesday';
  } else if (day == 4) {
    name = 'Thursday';
  } else if (day == 5) {
    name = 'Friday';
  } else if (day == 6) {
    name = 'Saturday';
  }
  return name.toString();
}

String formatTimeCustom(String time) {
  String? formatTime;
  if (time.length == 4) {
    var split = time.split('');
    formatTime = '${split[0]}${split[1]}:${split[2]}${split[3]}';
  } else {
    formatTime = time;
  }
  return formatTime.toString();
}
