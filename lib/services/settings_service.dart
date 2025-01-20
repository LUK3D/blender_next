import 'dart:convert';
import 'dart:io';
import 'package:blender_next/utils/blender_scripts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signals/signals.dart';

class SettingsService {
  static final SettingsService _singleton = SettingsService._internal();
  factory SettingsService() {
    return _singleton;
  }
  SettingsService._internal();
  late GetStorage box;

  late final showSettings = signal(false);
  late final locale = signal("en");
  late final defaultInstallationDir = signal("");
  late final thumbnailRenderingEngine = signal("");
  late final thumbnailSize = signal<Size>(const Size(250, 250));
  late final thumbnailSamples = signal(0.0);
  late final thumbnailFrame = signal(1);
  late final extentionsDir = signal("");

  Future init() async {
    await GetStorage.init();
    box = GetStorage();

    locale.value = getLocale() ?? "en";
    thumbnailRenderingEngine.value = getDefaultRenderingEngine();

    defaultInstallationDir.value = getInstallersFolder();
    thumbnailSize.value = getThumbnailSize();
    thumbnailSamples.value = getThumbnailSamples();
    thumbnailFrame.value = getThumbnailFrame();
    extentionsDir.value = getExtensionsDir();
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
    return box.read("insllations_dir") ?? "${getContentPath()}/installs";
  }

  void setInstallersFolder(String? val) {
    if (val == null || val.isEmpty) {
      return;
    }

    box.write("insllations_dir", val);
    defaultInstallationDir.value = val;
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
    thumbnailRenderingEngine.value = engine;
    await box.write("default_rendering_engine", engine);
  }

  String getDefaultRenderingEngine() {
    return box.read<String>("default_rendering_engine") ??
        BlenderEngines.workbench;
  }

  Future<void> setExtensionsDir(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    extentionsDir.value = path;
    await box.write("extensions_dir", path);
  }

  String getExtensionsDir() {
    return box.read("extensions_dir") ?? "${getContentPath()}/extensions";
  }

  setThumbnailSize({double? width, double? height}) async {
    thumbnailSize.value = Size(width ?? thumbnailSize.value.width,
        height ?? thumbnailSize.value.height);
    await box.write(
        "thumbnail_size",
        json.encode({
          "width": thumbnailSize.value.width,
          "height": thumbnailSize.value.height
        }));
  }

  getThumbnailSize() {
    final data = json.decode(
        "${box.read("thumbnail_size") ?? '{"width": 250, "height": 250}'}");
    return Size(double.parse(data["width"].toString()),
        double.parse(data["height"].toString()));
  }

  setThumbnailSamples(double? samples) async {
    if (samples == null) {
      return;
    }
    thumbnailSamples.value = samples;
    await box.write("thumbnail_samples", samples);
  }

  double getThumbnailSamples() {
    return box.read("thumbnail_samples") ?? 100.0;
  }

  setThumbnailFrame(int? frame) async {
    if (frame == null) {
      return;
    }
    thumbnailFrame.value = frame;

    await box.write("thumbnail_frame", frame);
  }

  int getThumbnailFrame() {
    return box.read("thumbnail_frame") ?? 1;
  }

  void toggleSettingsPage({bool? value}) {
    showSettings.value = value ?? !showSettings.value;
  }

  void setLocale(String localeValue) async {
    if (localeValue.trim().isEmpty) {
      return;
    }
    locale.value = localeValue;
    await box.write("locale", locale);
  }

  String? getLocale() {
    return box.read<String?>("locale");
  }
}

SettingsService useSettingsService() => SettingsService();
