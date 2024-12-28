import 'package:blender_next/data/model/blender.dart';
import 'package:blender_next/data/model/blender_splashscreen.dart';

abstract class DataAccess {
  Future<List<Blender>> getLatestBuilds();
  Future<Map<String, BlenderSplashscreen>> getSpashScreens();
}
