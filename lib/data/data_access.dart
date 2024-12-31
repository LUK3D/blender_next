import 'database/database.dart';

abstract class DataAccess {
  Future<bool> saveBuilds({required List<BlenderVersion> blenderBuilds});
  Future<BlenderVersion> updateBuild(BlenderVersion blender);
  Future<bool> saveSplashCreens(List<SplashScreen> splashScreens);
  Future<List<SplashScreen>> getSplashScreens();
  SplashScreen? getSplashScreenById(int id);
  Future<List<BlenderVersion>> getLatestBuilds({String? varient});
  Stream<List<BlenderVersion>> getLatestBuildsStream({String? varient});
  Future<bool> clearDatabase();
  Future<BnextInfoData> getInfo();
  Future<BnextInfoData> updateInfo(BnextInfoData bnextInfo);
  Future<BnextInfoData> insertInfo(BnextInfoData bnextInfo);
}
