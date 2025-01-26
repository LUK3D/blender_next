import 'dart:io';

import 'package:blender_next/data/database/database.dart';
import 'package:process_run/process_run.dart';

class BnexProcess {
  final Shell? shell;
  final Process? process;
  final BlenderVersion? blender;
  final List<String> args;

  Future<(List<dynamic>, List<dynamic>)> runInShellBackground() async {
    try {
      if (blender?.installationPath == null) {
        return ([], []);
      }
      final result = await shell!.run(
          "${blender!.installationPath!.split("/").join('\\')}\\blender.exe ${args.join(" ")}");

      return (
        result.map((res) => res.stdout).toList(),
        result.map((res) => res.stderr).toList()
      );
    } catch (e) {
      return ([], [e.toString()]);
    }
  }

  Future<(List<dynamic>, List<dynamic>)> runInProcessBackground() async {
    try {
      if (blender?.installationPath == null) {
        return ([], []);
      }
      final result = await Process.run(
        "${blender!.installationPath!.split("/").join('\\')}\\blender.exe",
        args,
        runInShell: true,
      );

      return ([result.stdout], [result.stderr]);
    } catch (e) {
      return ([], [e.toString()]);
    }
  }

  BnexProcess(
      {this.args = const <String>[],
      this.shell,
      required this.blender,
      this.process});
}
