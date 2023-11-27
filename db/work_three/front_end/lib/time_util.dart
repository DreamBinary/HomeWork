class TimeUtil {
  // format string time  Sun, 26 Nov 2023 16:45:45 GMT
  static String formatStringTime(String time) {
    var timeList = time.split(' ');
    var day = timeList[1];
    var month = timeList[2];
    var year = timeList[3];
    return '$year / $month / $day';
  }
}
