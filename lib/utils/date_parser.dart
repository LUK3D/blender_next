import 'package:intl/intl.dart';

DateTime parseDate(String dateString) {
  DateFormat format = DateFormat("dd MMM HH:mm");
  DateTime parsedDate = format.parse(dateString);
  return parsedDate;
}
