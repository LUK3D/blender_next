import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DownloaderService {
  final dio = Dio();
  static final DownloaderService _singleton = DownloaderService._internal();
  factory DownloaderService() {
    return _singleton;
  }
  DownloaderService._internal();

  static Future<File?> downloadFileWithProgress(
      String url, String savePath, Function(double progress) onProgress,
      {Function(File? file)? onDone}) async {
    Dio dio = Dio();

    final file = File(savePath);

    Directory(file.parent.path);

    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // Log the progress as a percentage
            double progress = (received / total) * 1;
            onProgress(progress);
          }
        },
      );
      Logger().i(savePath);
      final finalFile = File(savePath);

      final result = await finalFile.exists() ? finalFile : null;
      onDone?.call(result);
      return result;
    } catch (e) {
      return null;
    }
  }
}
