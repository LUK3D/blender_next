import 'package:blender_next/components/video_player.dart';
import 'package:blender_next/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:markdown/markdown.dart' as md;

class BnMarkdownVideoElementBuilder extends MarkdownElementBuilder {
  final String baseUrl;
  BnMarkdownVideoElementBuilder(this.baseUrl);
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    String href = (element.attributes['href'] ?? "");
    final String text = element.textContent;

    if (isVideo(href)) {
      Logger().e(href);
    }

    if (href.startsWith("../../../") || href.startsWith("/")) {
      href = href.split("../").join("");
      final splitedBase = baseUrl.split("/");
      splitedBase.removeLast();
      splitedBase.removeLast();
      splitedBase.removeLast();
      href = "${splitedBase.join("/")}/$href";
    } else if (href.startsWith("../")) {
      href = "$baseUrl/${href.split("../").join("")}";
    } else {
      href = href.split("../").join("");
    }

    if (href.startsWith("/")) {
      href = "$baseUrl$href";
    }

    href = href.split("//v").join("/v");

    if (isVideo(href)) {
      Logger().w(href);
    }

    if (isVideo(href)) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: BnVideoPlayer(
          videoUrl: href.startsWith("https:")
              ? href
              : "$baseUrl$href".split("//").join("/"),
          thumbnailUrl: "",
        ),
      );
    }
    if (isImage(href)) {
      return Image.network(
        href.startsWith("https:") ? href : "$baseUrl$href",
      );
    }

    if (text == "¶" ||
        text.trim().isEmpty ||
        href.startsWith("../") ||
        href.endsWith(".svg")) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () async {
        Logger().i(href);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
