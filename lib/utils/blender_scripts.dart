import 'package:flutter/services.dart' show rootBundle;

class BlenderStript {
  List<String> scripts = ['import bpy;'];

  BlenderStript addScript(String script) {
    scripts.add(script);
    return this;
  }

  /// Save the file in the given path
  /// @param absFileName the absolute path of the file without the extension
  static String saveBlenderFile(String absFileName) {
    return 'bpy.ops.wm.save_as_mainfile(filepath=r\'$absFileName.blend\')';
  }

  @override
  toString() {
    return scripts.join(' ');
  }
}

BlenderStript useBlenderScript() => BlenderStript();

class BlenderEngines {
  static String cycles = "CYCLES";
  static String eevee = "BLENDER_EEVEE_NEXT";
  static String workbench = "BLENDER_WORKBENCH";
  static String viewport = "VIEWPORT";
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

  return val.split("\n").join("; ").replaceAll("\n;", '');
}
