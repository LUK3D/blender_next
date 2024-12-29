import 'dart:io';

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

  String getLocalRegistryFilePath() {
    return "${getContentPath()}/manifest.json";
  }
}

SettingsService useSettingsService() => SettingsService();
