import 'package:blender_next/data/model/blender.dart';
import 'package:blender_next/data/model/blender_splashscreen.dart';

abstract class DataAccess {
  Future<List<Blender>> getLatestBuilds({String? varient});
  Future<Map<String, BlenderSplashscreen>> getSpashScreens();
}
