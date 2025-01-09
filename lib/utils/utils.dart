import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

Future<String> getFileSize(String path, int decimals) async {
  final bytes = await File(path).length();
  return formatBytes(bytes, decimals);
}

Future<String> getFileSizeFromFile(File file, int decimals) async {
  final bytes = await file.length();
  return formatBytes(bytes, decimals);
}

String getProjectDate(DateTime? date) {
  if (date == null) {
    return "";
  }
  if ((DateTime.now().difference(date).inDays == 0)) {
    return timeago.format(date);
  }
  return date.toString().split(" ").first;
}

DateTime? formatNaturalDate(String input) {
  if (input.trim().isEmpty) {
    return null;
  }
  try {
    //I will replace this with a proper Regex
    String processedInput = input
        .split("st,")
        .join(",")
        .split("nd,")
        .join(",")
        .split("rd,")
        .join(',')
        .split('th,')
        .join(',');
    DateFormat dateFormat = DateFormat("EEEE d, MMMM yyyy - HH:mm");
    DateTime dateTime = dateFormat.parse(processedInput);
    return dateTime;
  } catch (e) {
    return null;
  }
}

String ellipseString(String text, {int maxLength = 20}) {
  if (text.length <= maxLength) {
    return text; // No truncation needed
  }
  return '${text.substring(0, maxLength - 3)}...';
}
