import 'package:blender_next/data/data_access.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:blender_next/data/model/blender.dart';
import 'package:logger/logger.dart';

import 'model/blender_splashscreen.dart';

class BlenderDataAccess extends DataAccess {
  final dio = Dio();
  static final BlenderDataAccess _singleton = BlenderDataAccess._internal();

  factory BlenderDataAccess() {
    return _singleton;
  }

  BlenderDataAccess._internal();

  @override
  Future<List<Blender>> getLatestBuilds() async {
    final result = <Blender>[];

    final splashScreens = await getSpashScreens();

    final getResult =
        await dio.get('https://builder.blender.org/download/daily/');

    if (getResult.statusCode == 200) {
      final data = getResult.data;
      var document = parse(data);

      final d = document
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
            ).toJson();
          })
          .toList()
          .where((el) => el["downloadUrl"].split('.').last != 'sha256')
          .toList();

      Logger().i(d);
    }

    return result;
  }

  @override
  Future<Map<String, BlenderSplashscreen>> getSpashScreens() async {
    final result = <String, BlenderSplashscreen>{};

    final getResult =
        await dio.get("https://www.blender.org/download/demo-files/");

    if (getResult.statusCode == 200) {
      final data = getResult.data;
      var document = parse(data);

      final d =
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
