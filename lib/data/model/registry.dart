import 'package:blender_next/data/model/blender.dart';

class Registry {
  List<Blender> blenders;
  DateTime lastUpdate;

  Registry({
    required this.blenders,
    required this.lastUpdate,
  });

  static fromJson(Map<String, dynamic> data) {
    return Registry(
      blenders: data["blenders"] != null
          ? List<Blender>.from(
              data["blenders"].map(
                (b) => Blender.fromJson(b),
              ),
            )
          : [],
      lastUpdate: data["last_update"] == null
          ? DateTime.now()
          : DateTime.parse(data["last_update"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "blenders": blenders.map((b) => b.toJson()).toList(),
      "last_update": lastUpdate.toString(),
    };
  }
}
