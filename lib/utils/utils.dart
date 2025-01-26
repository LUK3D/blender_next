import 'dart:io';
import 'dart:math';
import 'package:archive/archive.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
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

bool isImage(String path) {
  final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
  final extension = path.split('.').last.toLowerCase();
  return imageExtensions.contains(extension);
}

bool isVideo(String path) {
  final videoExtensions = ['mp4', 'mov', 'wmv', 'avi', 'mkv', 'flv', 'webm'];
  final extension = path.split('.').last.toLowerCase();
  return videoExtensions.contains(extension);
}

String extractFileNameFromExtension(String fileName) {
  final regex = RegExp(r'^(.*?)(?:-\d+\.\d+\.\d+)?(?:\.zip)?$');
  final match = regex.firstMatch(fileName);
  if (match != null) {
    return match.group(1) ?? fileName;
  }
  return fileName; // Return the original name if no match
}

Future<void> extractZipFile(String zipFilePath, String outputFolderPath) async {
  try {
    // Read the ZIP file
    final zipFile = File(zipFilePath);
    final bytes = await zipFile.readAsBytes();

    // Decode the ZIP file
    final archive = ZipDecoder().decodeBytes(bytes);

    // Check if the archive contains a single root folder
    final entries = archive.map((file) => file.name.split('/').first).toSet();
    final hasSingleRootFolder = entries.length == 1 &&
        archive.every((file) => file.name.startsWith('${entries.first}/'));

    // Ensure the output folder exists
    final outputFolder = Directory(outputFolderPath);
    if (!outputFolder.existsSync()) {
      outputFolder.createSync(recursive: true);
    }

    // Extract files
    for (final file in archive) {
      final filePath = hasSingleRootFolder
          ? '$outputFolderPath/${file.name.substring(entries.first.length + 1)}'
          : '$outputFolderPath/${file.name}';

      if (file.isFile) {
        final outputFile = File(filePath);
        await outputFile.create(recursive: true);
        await outputFile.writeAsBytes(file.content as List<int>);
      } else if (file.isDirectory) {
        Directory(filePath).createSync(recursive: true);
      }
    }

    Logger().i('Extraction completed: $outputFolderPath');
  } catch (e) {
    Logger().e('Error extracting ZIP file: $e');
  }
}
