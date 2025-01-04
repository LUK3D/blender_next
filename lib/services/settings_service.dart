import 'dart:io';

import 'package:blender_next/utils/blender_scripts.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService {
  static final SettingsService _singleton = SettingsService._internal();
  factory SettingsService() {
    return _singleton;
  }
  SettingsService._internal();
  late GetStorage box;

  Future init() async {
    await GetStorage.init();
    box = GetStorage();
  }

  String getContentPath() {
    //Check if the user has defined a custom place to store the files.
    //Otherwise, use the default path
    return box.read<String>("content_path") ??
        "${Directory.current.path}/content";
  }

  Future<void> setContentPath(String path) async {
    await box.write("content_path", path);
  }

  String getInstallersFolder() {
    return "${getContentPath()}/installs";
  }

  Future<void> setProjectsFolder(String path) async {
    if (path.isEmpty) {
      return;
    }
    await box.write("projects_folder", path);
  }

  String? getProjectsFolder() {
    return box.read<String>("projects_folder");
  }

  Future<void> setDefaultRenderingEngine(String engine) async {
    await box.write("default_rendering_engine", engine);
  }

  String? getDefaultRenderingEngine() {
    return box.read<String>("default_rendering_engine") ?? BlenderEngines.eevee;
  }
}

SettingsService useSettingsService() => SettingsService();
