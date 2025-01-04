import 'dart:io';

import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/data/local_db_access_layer.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:blender_next/services/settings_service.dart';
import 'package:blender_next/utils/blender_scripts.dart';
import 'package:blender_next/utils/utils.dart';
import 'package:drift/drift.dart';
import 'package:logger/logger.dart';
import 'package:process_run/process_run.dart';

class BnexProcess {
  final Shell? shell;
  final BlenderVersion? blender;

  BnexProcess({required this.shell, required this.blender});
}

class ProjectManagerService {
  static final ProjectManagerService _singleton =
      ProjectManagerService._internal();
  factory ProjectManagerService() {
    return _singleton;
  }

  final db = useLocalDbAccessLayer();
  final settings = useSettingsService();
  final runningBlender = <String, BnexProcess>{};

  ProjectManagerService._internal();

  Future<BnexProject?> createProject(BnexProject project) async {
    final blenders = await useBlenderService().db.getBuildByVersion(
          project.blenderVersion,
          varient: project.blenderVariant,
        );

    final blender = blenders.firstOrNull;
    if (blender == null) {
      Logger().e("No blender version found!");
      return null;
    }
    if (blender.installed == false) {
      Logger().e("Blender not installed!");
      return null;
    }

    final resultPoject = await db.createProject(project);

    runProjectWithBlender(resultPoject, blender, saveNewFile: true);

    return resultPoject;
  }

  Future<BlenderVersion?> getInstalledBledner(BnexProject project) async {
    final blenders = await useBlenderService().db.getBuildByVersion(
        project.blenderVersion,
        varient: project.blenderVariant);
    final blender = blenders.firstOrNull;
    if (blender == null) {
      Logger().e("No blender version found!");
      return null;
    }

    if (blender.installed == false) {
      Logger().e("Blender not installed!");
      return null;
    }
    return blender;
  }

  Future runProject(BnexProject project, {bool saveNewFile = false}) async {
    final blender = await getInstalledBledner(project);

    if (blender == null) {
      return;
    }
    await runProjectWithBlender(project, blender);
  }

  Future runProjectWithBlender(BnexProject project, BlenderVersion blender,
      {bool saveNewFile = false}) async {
    runningBlender['${blender.version}-${project.id}'] = BnexProcess(
      shell: Shell(workingDirectory: blender.installationPath),
      blender: blender,
    );
    final process = runningBlender['${blender.version}-${project.id}'];
    await Directory('${project.dir}/${project.name}').create(recursive: true);
    final bscript = useBlenderScript().addScript(
      BlenderStript.saveBlenderFile(
        '${project.dir}/${project.name}/${project.name}',
      ),
    );
    final args = saveNewFile
        ? '--python-expr "${bscript.toString()}"'
        : ' "${project.dir}/${project.name}/${project.name}.blend"';
    final result = await process!.shell!
        .run('${blender.installationPath}/blender.exe $args');
    await generateThumbnail(project);
  }

  Future<BnexProject> updateProject(BnexProject project) async {
    return await db.updateProject(project);
  }

  Future<void> deleteProject(BnexProject project) async {
    await db.deleteProject(project);
  }

  Stream<List<BnexProject>> getProjectsStream() {
    return db.getProjects();
  }

  Future<BnexProject> unlistProject(BnexProject project) async {
    return await db.unlistProject(project);
  }

  Future generateThumbnail(BnexProject project) async {
    final thumbNailPath =
        '${project.dir}/${project.name}/${project.name}-thumbnail.png';
    final script = await getRenderBlenderFileScript(
      filePath: project.dir,
      outPath: thumbNailPath,
      engine: settings.getDefaultRenderingEngine(),
    );

    final blender = await getInstalledBledner(project);

    if (blender == null) {
      return;
    }

    Shell process = Shell(workingDirectory: blender.installationPath);
    final result = await process.run(
        "${blender.installationPath}/blender.exe -b '${project.dir}/${project.name}/${project.name}.blend' --python-expr '$script' ");

    final logResult =
        result.map((s) => "${s.stdout} | ERROR: ${s.stderr}").join("\n");

    if (logResult.toLowerCase().contains("saved")) {
      final size = await getFileSize(thumbNailPath, 2);
      await db.updateProject(
          project.copyWith(cover: Value(thumbNailPath), size: Value(size)));
    }
  }

  onDispose() {
    runningBlender.forEach((key, value) {
      value.shell?.kill();
    });
  }
}

ProjectManagerService useProjectManagerService() => ProjectManagerService();
