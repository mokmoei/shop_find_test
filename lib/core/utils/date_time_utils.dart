import 'package:intl/intl.dart';

class AppDateTimeUtil {
  static DateTime convertTimeStringToDateTime(String time) {
    // Parse the time string and extract hours, minutes, and seconds
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    // Create a DateTime object using the extracted values
    return DateTime(6, 6, 6, hours, minutes, seconds);
  }

  static DateTime dateTimeToDateTimeOnly(DateTime date) {
    return DateTime(6, 6, 6, date.hour, date.minute);
  }

  static String dateToTimeString(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static bool compareTimeInRange(DateTime date, DateTime start, DateTime end) {
    date = dateTimeToDateTimeOnly(date);
    return date.isAfter(start) && date.isBefore(end);
  }
}
