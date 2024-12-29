import 'dart:convert';

import 'package:blender_next/data/model/blender_splashscreen.dart';

class Blender {
  final String title;
  final String description;
  final String version;
  final String variant;
  final String reference;
  final String referenceUrl;
  final String sha;
  final String shaUrl;
  final String date;
  final String architecture;
  final BlenderSplashscreen? splashscreen;
  final String downloadUrl;
  bool installed;
  String? installationPath;

  Blender({
    required this.title,
    required this.description,
    required this.version,
    required this.variant,
    required this.reference,
    required this.referenceUrl,
    required this.sha,
    required this.shaUrl,
    required this.date,
    required this.architecture,
    required this.downloadUrl,
    this.splashscreen,
    this.installed = false,
    this.installationPath,
  });

  static fromJson(Map<String, dynamic> json) {
    return Blender(
      title: json['title'],
      description: json['description'],
      version: json['version'],
      variant: json['variant'],
      reference: json['reference'],
      sha: json['sha'],
      date: json['date'],
      architecture: json['architecture'],
      splashscreen: json['splashscreen'] != null
          ? BlenderSplashscreen.fromJson(json['splashscreen'])
          : null,
      downloadUrl: json['downloadUrl'],
      referenceUrl: json['referenceUrl'],
      shaUrl: json['shaUrl'],
      installed: json['installed'] ?? false,
      installationPath: json['installation_path'],
    );
  }

  static fromRawJson(String rawJson) {
    return Blender.fromJson(jsonDecode(rawJson));
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'version': version,
      'variant': variant,
      'reference': reference,
      'referenceUrl': referenceUrl,
      'sha': sha,
      'shaUrl': shaUrl,
      'date': date,
      'architecture': architecture,
      'splashscreen': splashscreen?.toJson(),
      'downloadUrl': downloadUrl,
      'installed': installed,
      'installation_path': installationPath,
    };
  }
}
