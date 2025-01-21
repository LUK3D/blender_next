import 'dart:convert';
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
import 'package:html2md/html2md.dart' as html2md;

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
    await db.clearDatabase();

    return this;
  }

  Future installBlender({
    required BlenderVersion blender,
    required Function(double progress) onProgress,
    required Function(File? file) onDone,
  }) async {
    String tmpInstalationPath =
        "${useSettingsService().getInstallersFolder()}/${blender.downloadUrl.split("/").last}";
    File file = File(tmpInstalationPath);
    final instalationPath =
        "${file.parent.path}/${blender.version}-${blender.variant.split(" ").join('-').toLowerCase()}";

    File blenderExe = File("$instalationPath/blender.exe");

    //If there is an existing blender in this directory, return it instead of downloading a new one.
    if (await blenderExe.exists()) {
      await updateBlenderState(blender.copyWith(
          installationPath: Value(instalationPath), installed: true));
      onDone(blenderExe);
      return;
    }

    await DownloaderService.downloadFileWithProgress(
      blender.downloadUrl,
      tmpInstalationPath,
      onProgress,
      onDone: (file) {
        if (file != null) {
          file = file;
        }
      },
    );

    await extractFileToDisk(tmpInstalationPath, file.parent.path);
    final dir = Directory(file.path.split(".zip").join(""));
    await Future.delayed(const Duration(seconds: 2));

    if (await dir.exists()) {
      await dir.rename(instalationPath);
    }
    await file.delete();
    await updateBlenderState(blender.copyWith(
        installationPath: Value(instalationPath), installed: true));
    blenderExe = File("$instalationPath/blender.exe");
    onDone(blenderExe);
  }

  Future unInstallBlender(BlenderVersion blender) async {
    if (blender.installationPath == null) {
      return;
    }
    final dir = Directory(blender.installationPath!);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }

    updateBlenderState(blender.copyWith(
      installed: false,
      installationPath: const Value(""),
    ));
  }

  Future<BlenderVersion> updateBlenderState(BlenderVersion blender) async {
    final result = await db.updateBuild(blender);
    await db.getLatestBuilds();

    return result;
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

  Future isInstalled(BlenderVersion b) async {
    if (b.installed) {
      final f = File("${b.installationPath!}/blender.exe");
      if (!(await f.exists())) {
        updateBlenderState(
          b.copyWith(
            installed: false,
            installationPath: const Value(
              null,
            ),
          ),
        );
      }
    }
  }

  Future<List<Map<String, dynamic>>> getReleaseNotes(BlenderVersion b) async {
    if (b.description.isNotEmpty) {
      return List<Map<String, dynamic>>.from(jsonDecode(b.description));
    }
    final result = <Map<String, dynamic>>[];
    final getResult =
        await dio.get('https://developer.blender.org/docs/release_notes');

    if (getResult.statusCode == 200) {
      final data = getResult.data;
      var document = parse(data);
      final links = document
          .querySelectorAll('.md-nav a[href*="${b.version.substring(0, 3)}/"]');

      for (var element in links) {
        final url = element.attributes["href"] ?? "";
        final tmpV = url.trim();

        final vv = "${b.version.substring(0, 3)}/";
        if (tmpV.endsWith(vv)) {
          continue;
        }
        final content = await getSectionDetails(url);
        result.add({
          "title": element.text.trim(),
          "description": html2md.convert(content,
              // imageBaseUrl:
              //     "https://developer.blender.org/docs/release_notes/${b.version.substring(0, 3)}",
              rules: [
                html2md.Rule("video", filters: ['video'],
                    replacement: (content, node) {
                  final url = node.getAttribute("src").toString();

                  return '[video_url]($url)';
                }),
                html2md.Rule("img", filters: ['img'],
                    replacement: (content, node) {
                  final url = node.getAttribute("src").toString();

                  return url;
                })
              ])
        });

        //Updating the database so we can stream the results to the UI instead of waiting for the whole process to finish
        final d = jsonEncode(result);
        await db.updateBlenderDescriptions(b.version.substring(0, 3), d);
      }
      return result;
    }

    return result;
  }

  Future<String> getSectionDetails(String url) async {
    if (url.isEmpty) {
      return "";
    }
    final getResult =
        await dio.get('https://developer.blender.org/docs/release_notes/$url');

    if (getResult.statusCode == 200) {
      final data = getResult.data;
      var document = parse(data);
      return document.querySelector(".md-content")?.innerHtml ?? "";
    }

    return "";
  }
}

BlenderService useBlenderService() => BlenderService();
