import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/data/local_db_access_layer.dart';
import 'package:blender_next/services/downloader_service.dart';
import 'package:blender_next/services/settings_service.dart';
import 'package:blender_next/utils/date_parser.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:html/parser.dart';

class BlenderService {
  static final BlenderService _singleton = BlenderService._internal();
  factory BlenderService() {
    return _singleton;
  }
  BlenderService._internal();

  final db = useLocalDbAccessLayer();
  final dio = Dio();
  String oldVarient = "local";

  Future<BlenderService> initializeData() async {
    // await db.clearDatabase();

    return this;
  }

  Future installBlender({
    required BlenderVersion blender,
    required Function(double progress) onProgress,
    required Function(File? file) onDone,
  }) async {
    String tmpInstalationPath = '';
    await DownloaderService.downloadFileWithProgress(
      blender.downloadUrl,
      "${useSettingsService().getInstallersFolder()}/${blender.downloadUrl.split("/").last}",
      onProgress,
      onDone: (file) {
        if (file != null) {
          tmpInstalationPath = file.path;
        }
      },
    );

    File file = File(tmpInstalationPath);
    final instalationPath =
        "${file.parent.path}/${blender.version}-${blender.variant.split(" ").join('-').toLowerCase()}";
    await extractFileToDisk(tmpInstalationPath, file.parent.path);
    final dir = Directory(file.path.split(".zip").join(""));
    await Future.delayed(const Duration(seconds: 2));

    if (await dir.exists()) {
      await dir.rename(instalationPath);
    }
    await file.delete();
    await updateBlenderState(blender.copyWith(
        installationPath: Value(instalationPath), installed: true));
    final blenderExe = File("$instalationPath/blender.exe");
    onDone(blenderExe);
  }

  Future unInstallBlender(BlenderVersion blender) async {
    if (blender.installationPath == null) {
      return;
    }
    final dir = Directory(blender.installationPath!);
    await dir.delete(recursive: true);

    updateBlenderState(
        blender.copyWith(installed: false, installationPath: const Value("")));
  }

  Future updateBlenderState(BlenderVersion blender) async {
    await db.updateBuild(blender);
    await db.getLatestBuilds();
  }

//TODO Update this function to cache the data on the first request of each varient
  Future<List<BlenderVersion>> getLatestBuilds(
      {String? varient, bool? forceRefresh}) async {
    final info = await db.getInfo();

    if (info.createdAt != null) {
      if (info.createdAt!
              .add(const Duration(minutes: 2))
              .isBefore(DateTime.now()) &&
          db.cachedBlenderVersions.isNotEmpty) {
        await db.updateInfo(info.copyWith(createdAt: Value(DateTime.now())));
        return db.cachedBlenderVersions;
      }
    }
    oldVarient = varient ?? "";
    List<BlenderVersion> result = [];
    List<BlenderVersion> finalResult = [];

    final splashScreens = await getSplashScreens();

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
            final splashScreen = splashScreens
                .where((s) => s.blenderVersion == version.substring(0, 3));

            return BlenderVersion(
              installed: false,
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
              splashScreen: splashScreen.firstOrNull?.id,
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
      if (db.cachedBlenderVersions
          .where((ob) => (ob.architecture == b.architecture &&
              ob.variant == b.variant &&
              ob.version == b.version))
          .isEmpty) {
        db.cachedBlenderVersions.add(b);
      }
    }

    await db.saveBuilds(blenderBuilds: db.cachedBlenderVersions);

    return db.cachedBlenderVersions;
  }

  Future<List<SplashScreen>> getSplashScreens() async {
    List<SplashScreen> result = [];

    final getResult =
        await dio.get("https://www.blender.org/download/demo-files/");

    if (getResult.statusCode == 200) {
      final data = getResult.data;
      var document = parse(data);

      result =
          document.querySelectorAll("#splash .cards .cards-item").map((el) {
        String? size = (el
            .querySelectorAll(".cards-item-excerpt p")
            .lastOrNull
            ?.text
            .split(" –")
            .firstOrNull);

        final title = el.querySelector(".cards-item-title")?.text ?? '';

        return SplashScreen(
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
      }).toList();
    }

    await db.saveSplashCreens(result);

    return db.cachedSplashscreens;
  }
}

BlenderService useBlenderService() => BlenderService();
