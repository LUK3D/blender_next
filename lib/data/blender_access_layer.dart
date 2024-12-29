import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:blender_next/data/data_access.dart';
import 'package:blender_next/services/downloader_service.dart';
import 'package:blender_next/services/settings_service.dart';
import 'package:blender_next/utils/date_parser.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:blender_next/data/model/blender.dart';
import 'package:logger/logger.dart';

import 'model/blender_splashscreen.dart';
import 'model/registry.dart';

class BlenderDataAccess extends DataAccess {
  final dio = Dio();
  static final BlenderDataAccess _singleton = BlenderDataAccess._internal();
  String oldVarient = "local";
  Registry registry = Registry(blenders: [], lastUpdate: DateTime.now());

  factory BlenderDataAccess() {
    return _singleton;
  }

  BlenderDataAccess._internal();

  Future initializeData() async {
    final registryFile = File(useSettingsService().getLocalRegistryFilePath());
    if (await registryFile.exists()) {
      final registryJson = jsonDecode(await registryFile.readAsString());
      registry = Registry.fromJson(registryJson);
      registry.lastUpdate = DateTime.now().add(const Duration(minutes: 2));
    }

    Logger().w("Registry initialized");
  }

  Future saveRegistry() async {
    final registryFile = File(useSettingsService().getLocalRegistryFilePath());
    await registryFile.writeAsString(jsonEncode(registry.toJson()));
    Logger().w("Registry Saved");
  }

  Future installBlender({
    required Blender blender,
    required Function(double progress) onProgress,
    required Function(File? file) onDone,
  }) async {
    await DownloaderService.downloadFileWithProgress(
      blender.downloadUrl,
      "${useSettingsService().getInstallersFolder()}/${blender.downloadUrl.split("/").last}",
      onProgress,
      onDone: (file) {
        if (file != null) {
          blender.installed = true;
          blender.installationPath = file.path;
          updateBlenderState(blender);
        }
      },
    );

    File file = File(blender.installationPath!);
    final instalationPath =
        "${file.parent.path}/${blender.version}-${blender.variant.split(" ").join('-').toLowerCase()}";
    await extractFileToDisk(blender.installationPath!, file.parent.path);
    final dir = Directory(file.path.split(".zip").join(""));
    await Future.delayed(const Duration(seconds: 1));

    if (await dir.exists()) {
      await dir.rename(instalationPath);
    }
    await file.delete();
    blender.installationPath = instalationPath;
    await updateBlenderState(blender);
    final blenderExe = File("$instalationPath/blender.exe");
    onDone(blenderExe);
  }

  Future unInstallBlender(Blender blender) async {
    if (blender.installationPath == null) {
      return;
    }
    final dir = Directory(blender.installationPath!);
    await dir.delete(recursive: true);

    blender.installed = false;
    blender.installationPath = "";

    updateBlenderState(blender);
  }

  Future updateBlenderState(Blender blender) async {
    registry.blenders = registry.blenders.map((b) {
      if (b.version == blender.version &&
          b.variant == blender.variant &&
          b.architecture == blender.architecture) {
        return blender;
      }
      return b;
    }).toList();

    await saveRegistry();
  }

//TODO Update this login to cache the data on the first request of each varient
  @override
  Future<List<Blender>> getLatestBuilds({String? varient}) async {
    if (varient == "installed") {
      return registry.blenders.where((b) => b.installed).toList();
    }
    if (registry.blenders.isNotEmpty &&
        registry.lastUpdate.difference(DateTime.now()).inMinutes < 1) {
      return registry.blenders
          .where((el) => el.variant.toLowerCase().contains(varient ?? ''))
          .toList();
    }
    oldVarient = varient ?? "";
    List<Blender> result = [];
    List<Blender> finalResult = [];

    final splashScreens = await getSpashScreens();

    final getResult =
        await dio.get('https://builder.blender.org/download/daily/archive/');

    if (getResult.statusCode == 200) {
      final data = getResult.data;
      var document = parse(data);

      result = document
          .querySelectorAll(".builds-list-container > ul > li.t-row.build")
          .map((e) {
            final version = (e
                    .querySelector("a.t-cell.b-version")
                    ?.text
                    .split(" ")
                    .elementAtOrNull(1)) ??
                "";
            return Blender(
              title: (e
                      .querySelector("a.t-cell.b-version")
                      ?.text
                      .split(" ")
                      .first) ??
                  "",
              variant: e.querySelector("a.t-cell.b-variant")?.text ?? "",
              reference: e.querySelector("a.t-cell.b-reference")?.text ?? "",
              referenceUrl:
                  e.querySelector("a.t-cell.b-reference")?.attributes["href"] ??
                      "",
              sha: e.querySelector("a.t-cell.b-sha")?.text ?? "",
              shaUrl:
                  e.querySelector("a.t-cell.b-sha")?.attributes["href"] ?? "",
              date: e.querySelector("div.t-cell.b-date")?.text ?? "",
              architecture: e.querySelector("div.t-cell.b-arch")?.text ?? "",
              description: "",
              splashscreen: splashScreens[version.substring(0, 3)],
              downloadUrl:
                  e.querySelector("div.b-down > a")?.attributes["href"] ?? "",
              version: version,
            );
          })
          .toList()
          .where((el) =>
              el.downloadUrl.split('.').last != 'sha256' &&
              el.architecture.toLowerCase().contains("windows") &&
              !el.architecture.toLowerCase().contains("arm64") &&
              el.variant.toLowerCase().contains(varient ?? '') &&
              el.downloadUrl.contains(".zip"))
          .toList();
    }

    for (var i = 0; i < result.length; i++) {
      final b = result[i];

      final old = finalResult
          .where((element) =>
              element.version == b.version && element.variant == b.variant)
          .firstOrNull;

      if (old == null) {
        finalResult.add(b);
        continue;
      }

      if (parseDate(old.date).isBefore(parseDate(b.date))) {
        finalResult.remove(old);
        finalResult.add(b);
      }
    }

    //in order to mantain the state of the local blender versions and avoid duplication
    //We should only add to list, the ones that are new
    //This logic should be moved to the previous for loop
    for (var b in result) {
      if (registry.blenders
          .where((ob) => (ob.architecture == b.architecture &&
              ob.variant == b.variant &&
              ob.version == b.version))
          .isEmpty) {
        registry.blenders.add(b);
      }
    }
    registry.lastUpdate = DateTime.now();

    return registry.blenders;
  }

  @override
  Future<Map<String, BlenderSplashscreen>> getSpashScreens() async {
    final result = <String, BlenderSplashscreen>{};

    final getResult =
        await dio.get("https://www.blender.org/download/demo-files/");

    if (getResult.statusCode == 200) {
      final data = getResult.data;
      var document = parse(data);

      document.querySelectorAll("#splash .cards .cards-item").map((el) {
        String? size = (el
            .querySelectorAll(".cards-item-excerpt p")
            .lastOrNull
            ?.text
            .split(" –")
            .firstOrNull);

        final title = el.querySelector(".cards-item-title")?.text ?? '';

        return BlenderSplashscreen(
          title: title,
          blenderVersion: title
                  .split("Blender ")
                  .elementAtOrNull(1)
                  ?.split(" ")
                  .firstOrNull ??
              '',
          size: ((size?.length ?? 11) > 10 ||
                  (size?.toLowerCase().contains("c") ?? true))
              ? ''
              : size,
          imageUrl: el.querySelector("img")?.attributes["src"] ?? '',
          projectUrl:
              el.querySelector(".cards-item-thumbnail")?.attributes["href"] ??
                  '',
          author: el.querySelector(".cards-item-excerpt a")?.text ?? '',
          authorUrl:
              el.querySelector(".cards-item-excerpt a")?.attributes['href'] ??
                  '',
          license: ((el
                      .querySelectorAll(".cards-item-excerpt p")
                      .lastOrNull
                      ?.text
                      .split(" – ")
                      .elementAtOrNull(1)) ??
                  (el
                      .querySelectorAll(".cards-item-excerpt p")
                      .lastOrNull
                      ?.text
                      .split("- ")
                      .firstOrNull) ??
                  '')
              .trim(),
        );
      }).forEach((bSc) {
        result[bSc.blenderVersion] = bSc;
      });
    }

    return result;
  }
}

BlenderDataAccess useBlenderDataAccess() => BlenderDataAccess();
