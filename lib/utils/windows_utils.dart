import 'dart:io';

import 'package:logger/logger.dart';

Future<bool> isExecutableRunning(String executableName) async {
  try {
    // Run the `tasklist` command to get a list of running processes
    final result = await Process.run('tasklist', []);

    if (result.exitCode == 0) {
      // Convert the output to a string and check if the executable name exists
      String output = result.stdout.toString();
      return output.contains(executableName);
    } else {
      Logger().e("Failed to execute tasklist: ${result.stderr}");
      return false;
    }
  } catch (e) {
    Logger().e("Error checking process: $e");
    return false;
  }
}
