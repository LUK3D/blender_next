import 'dart:convert';

import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/data/local_db_access_layer.dart';
import 'package:blender_next/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:html/parser.dart';
import 'package:logger/logger.dart';
import 'package:html2md/html2md.dart' as html2md;

class ExntesionsService {
  static final ExntesionsService _singleton = ExntesionsService._internal();
  factory ExntesionsService() {
    return _singleton;
  }
  ExntesionsService._internal();

  final db = useLocalDbAccessLayer();
  final dio = Dio();

  int lastPage = 1;
  int currentPage = 5;

  Future<ExntesionsService> initializeData() async {
    getExtensions();

    return this;
  }

  Future<List<BnextExtension>> getExtensions({int? page = 1}) async {
    final getResult =
        await dio.get('https://extensions.blender.org/add-ons/?page=$page');

    if (getResult.statusCode != 200) {
      return [];
    }

    final data = getResult.data;
    var document = parse(data);

    lastPage = int.tryParse(
            "${document.querySelector(".page-last a")?.attributes["href"]?.split("=").lastOrNull ?? 0}") ??
        1;

    final result = document
        .querySelectorAll(".cards-item > .cards-item-content")
        .map((bnextExtensionHtml) {
      final deatilas = bnextExtensionHtml.querySelector(".cards-item-extra");
      final l = deatilas?.children.length ?? 0;
      final maintainer = l > 0 ? deatilas?.children[l - 2].text ?? "" : "";
      final stars = bnextExtensionHtml
          .querySelector(".cards-item-extra .stars")
          ?.attributes["title"]
          ?.trim();
      final reviewers = bnextExtensionHtml
          .querySelector(".cards-item-extra-rating-stars")
          ?.text
          .split(")")
          .firstOrNull
          ?.trim()
          .replaceAll("(", "");
      final downloads = bnextExtensionHtml
              .querySelector(
                  '.cards-item-extra-rating-stars li[title\$="downloads"]')
              ?.attributes["title"]
              ?.split(" ")
              .firstOrNull ??
          "0";

      final url = bnextExtensionHtml.querySelector("a")?.attributes['href'];

      return BnextExtension(
          cover:
              'https://extensions.blender.org${bnextExtensionHtml.querySelector(".cards-item-thumbnail > img")?.attributes["src"]}',
          name: bnextExtensionHtml
              .querySelector(".cards-item-title")
              ?.text
              .trim(),
          description: bnextExtensionHtml
              .querySelector(".cards-item-excerpt")
              ?.text
              .trim(),
          tags: bnextExtensionHtml
              .querySelectorAll(".cards-item-extra .badge.badge-tag")
              .map((el) => el.text.trim())
              .toList()
              .join("|"),
          stars: double.tryParse(
              RegExp(r'\b\d+\.\d+\b').firstMatch(stars ?? "")?.group(0) ??
                  "0.0"),
          reviewers: int.tryParse(reviewers ?? "0"),
          maintainer: maintainer.trim(),
          downloads: int.tryParse(downloads),
          extId: url
              ?.split("/add-ons/")
              .elementAtOrNull(1)
              ?.split("/")
              .firstOrNull,
          detailsUrl: "https://extensions.blender.org$url");
    });
    getExtensionDetails(result.first);
    await db.database.insertExtensions(result.toList());

    if (currentPage <= lastPage || currentPage == 1) {
      currentPage += 1;

      db.database.getExtensions.then((val) {
        Future.delayed(Duration(seconds: val.isEmpty ? 3 : 5)).then((v) {
          getExtensions(page: currentPage);
        });
      });
    }

    return await db.database.getExtensions;
  }

  Future<BnextExtension?> getExtensionDetails(BnextExtension ext) async {
    final getResult =
        await dio.get('https://extensions.blender.org/add-ons/${ext.extId}');

    if (getResult.statusCode != 200) {
      return null;
    }

    final data = getResult.data;
    var document = parse(data);

    final mediaUrls =
        document.querySelectorAll(".galleria-items .galleria-item").map((el) {
      final lowResThumbnail = el.querySelector("img")?.attributes["src"];
      final thumbnailUrl =
          "https://extensions.blender.org${el.attributes["href"]}";
      final videoUrl = el.attributes["data-galleria-video-url"];

      return {
        "thumbnail": thumbnailUrl,
        "thumbnail_low_res": lowResThumbnail == null
            ? null
            : "https://extensions.blender.org$lowResThumbnail",
        "media_url": videoUrl == null
            ? thumbnailUrl
            : "https://extensions.blender.org$videoUrl",
      };
    }).toList();

    final icon =
        document.querySelector(".extension-icon>img")?.attributes["src"];
    String? mdDescription = document.querySelector("#about")?.innerHtml;
    if (mdDescription != null) {
      mdDescription = html2md.convert(
        mdDescription,
      );
    }

    final license = document.querySelector('a[href*="licenses"]');
    final downloadLink =
        document.querySelector('a[download*="add-on"]')?.attributes["href"];
    final draggableDownloadLink = document
        .querySelector('div[data-install-url*="https://"]')
        ?.attributes["data-install-url"];

    final tmpDatesRows =
        document.querySelectorAll('.ext-detail-info .card .dl-row');
    final tmpDates = tmpDatesRows
        .elementAtOrNull(2)
        ?.querySelectorAll("dd")
        .map((e) => formatNaturalDate(e.attributes["title"] ?? ""));

    final supportLink = tmpDatesRows
        .elementAtOrNull(tmpDatesRows.length == 9 ? 6 : 5)
        ?.querySelector("a")
        ?.attributes["href"];
    final websiteUrl = tmpDatesRows.length == 9
        ? tmpDatesRows
            .elementAtOrNull(5)
            ?.querySelector("a")
            ?.attributes["href"]
        : null;
    final minBlenderVersion = tmpDatesRows
        .elementAtOrNull(4)
        ?.querySelectorAll("a")
        .firstOrNull
        ?.attributes["title"];
    final version = tmpDatesRows
        .elementAtOrNull(1)
        ?.querySelectorAll("a")
        .elementAtOrNull(1)
        ?.text;
    final size = tmpDatesRows
        .elementAt(3)
        .querySelectorAll("dd")
        .elementAtOrNull(1)
        ?.text;

    final newExt = ext.copyWith(
      mediaUrls: Value(jsonEncode(mediaUrls)),
      icon: Value(
        icon == null ? null : "https://extensions.blender.org$icon",
      ),
      mdDescriptio: Value(mdDescription),
      licence: Value(license?.text.trim()),
      licenceUrl: Value(license?.attributes["href"]?.trim()),
      downloadUrl: Value(downloadLink),
      draggableUrl: Value(draggableDownloadLink),
      lastUpdateOn: Value(tmpDates?.firstOrNull),
      publishedOn: Value(tmpDates?.lastOrNull),
      supportUrl: Value(supportLink),
      blenderMinVersion: Value(minBlenderVersion),
      version: Value(version?.trim()),
      size: Value(size?.trim()),
      website: Value(websiteUrl),
    );

    final result = await db.database.updateExtension(newExt);
    return result;
  }
}

ExntesionsService useExntesionsService() => ExntesionsService();
