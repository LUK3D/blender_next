import 'dart:convert';

class BlenderSplashscreen {
  final String title;
  final String imageUrl;
  final String projectUrl;
  final String author;
  final String authorUrl;
  final String license;
  final String? size;
  final String blenderVersion;

  BlenderSplashscreen({
    required this.title,
    required this.size,
    required this.imageUrl,
    required this.projectUrl,
    required this.author,
    required this.authorUrl,
    required this.license,
    required this.blenderVersion,
  });

  static fromJson(Map<String, dynamic> json) {
    return BlenderSplashscreen(
      title: json['title'],
      size: json['size'],
      imageUrl: json['imageUrl'],
      projectUrl: json['projectUrl'],
      author: json['author'],
      authorUrl: json['authorUrl'],
      license: json['license'],
      blenderVersion: json['blenderVersion'],
    );
  }

  static fromRawJson(String rawJson) {
    return BlenderSplashscreen.fromJson(jsonDecode(rawJson));
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'size': size,
      'imageUrl': imageUrl,
      'projectUrl': projectUrl,
      'author': author,
      'authorUrl': authorUrl,
      'license': license,
      'blenderVersion': blenderVersion,
    };
  }
}
