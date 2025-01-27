import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class BlenderStript {
  List<String> scripts = ['import bpy'];

  BlenderStript addScript(String script) {
    scripts.add(script);
    return this;
  }

  /// Save the file in the given path
  /// @param absFileName the absolute path of the file without the extension
  static String saveBlenderFile(String absFileName, {String? template}) {
    return 'bpy.ops.wm.save_as_mainfile(filepath=r\'$absFileName.blend\')';
  }

  /// Save the file in the given path
  /// @param absFileName the absolute path of the file without the extension
  static String newFileFromtemplate(String template) {
    return 'bpy.ops.wm.read_homefile(app_template=\'$template\')';
  }

  @override
  toString() {
    return scripts.join('; ').split(":;").join(":").split(";;").join(";");
  }
}

BlenderStript useBlenderScript() => BlenderStript();

class BlenderEngines {
  static String cycles = "CYCLES";
  static String eevee = "BLENDER_EEVEE_NEXT";
  static String workbench = "BLENDER_WORKBENCH";
  static String viewport = "VIEWPORT";
}

class BlenderAddonTypes {
  static String extensions = "extension";
  static String addon = "addon";
}

enum BlenderProjectFactoryTemplate {
  animation2D("2D_Animation"),
  sculpting("Sculpting"),
  vFX("VFX"),
  videoEditing("Video_Editing"),
  texturePaint("Texture_Paint"),
  general("General");

  final String val;

  const BlenderProjectFactoryTemplate(this.val);
}

Future<String> getRenderBlenderFileScript({
  required String filePath,
  required String outPath,
  int width = 250,
  int height = 250,
  int frame = 1,
  String? engine,
  int samples = 64,
}) async {
  final val = (await rootBundle.loadString(
    'assets/data/bpy_scripts/rendering.image${(engine == null || engine == BlenderEngines.viewport) ? '.viewport' : ''}.py',
  ))
      .split("{{frame}}")
      .join(frame.toString())
      .split("{{engine}}")
      .join(engine ?? '')
      .split("{{width}}")
      .join(width.toString())
      .split("{{height}}")
      .join(height.toString())
      .split("{{out_path}}")
      .join(outPath)
      .split("{{samples}}")
      .join(samples.toString())
      .replaceAll(RegExp(r'\r?\n'), ';');

  return val
      .split("\n")
      .join("; ")
      .replaceAll("\n;", '')
      .split(":;")
      .join(":")
      .split(";;")
      .join(";");
}

class BlenderPythonFiles {
  final baseAssetsPath =
      "${Directory.current.path}\\data\\flutter_assets\\assets\\data\\bpy_scripts";
  final devBaseAssetsPath =
      "${Directory.current.path}\\assets\\data\\bpy_scripts";
  String get enableExtensions {
    return "${kDebugMode ? devBaseAssetsPath : baseAssetsPath}\\enable_addon.py";
  }
}
