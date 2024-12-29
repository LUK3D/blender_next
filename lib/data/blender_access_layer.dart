import 'dart:convert';
import 'dart:io';

import 'package:blender_next/data/data_access.dart';
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

//TODO Update this login to cache the data on the first request of each varient
  @override
  Future<List<Blender>> getLatestBuilds({String? varient}) async {
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

    registry.blenders = finalResult;
    registry.lastUpdate = DateTime.now();

    return finalResult;
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
