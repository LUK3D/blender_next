import 'package:blender_next/data/data_access.dart';
import 'package:drift/drift.dart';

import 'database/database.dart';

class LocalDbAccessLayer extends DataAccess {
  static final LocalDbAccessLayer _singleton = LocalDbAccessLayer._internal();
  factory LocalDbAccessLayer() {
    return _singleton;
  }
  LocalDbAccessLayer._internal();

  final database = AppDatabase();

  List<SplashScreen> cachedSplashscreens = [];
  List<BlenderVersion> cachedBlenderVersions = [];

  @override
  Future<List<BlenderVersion>> getLatestBuilds({String? varient}) async {
    final result = await database.managers.blenderVersions.get();
    cachedBlenderVersions = result;
    return result;
  }

  @override
  Stream<List<BlenderVersion>> getLatestBuildsStream({String? varient}) {
    return database.managers.blenderVersions
        .filter((e) => platFormFilter(e, varient))
        .watch();
  }

  @override
  Future<bool> saveBuilds({required List<BlenderVersion> blenderBuilds}) async {
    try {
      await database.managers.blenderVersions.bulkCreate((o) => blenderBuilds,
          mode: InsertMode.insertOrReplace,
          onConflict: DoNothing(target: [
            database.blenderVersions.architecture,
            database.blenderVersions.variant,
            database.blenderVersions.version,
          ]));
      //Update the cache when we save something new
      await getLatestBuilds();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<BlenderVersion> updateBuild(BlenderVersion blender) async {
    await database.managers.blenderVersions
        .filter((f) => f.id.equals(blender.id))
        .update((o) => blender);
    //Update the cache when we change something
    await getLatestBuilds();
    return blender;
  }

  @override
  Future<List<SplashScreen>> getSplashScreens() async {
    final result = await database.managers.splashScreens.get();
    cachedSplashscreens = result;
    return cachedSplashscreens;
  }

  @override
  SplashScreen? getSplashScreenById(int? id) {
    if (id == null) {
      return null;
    }

    return cachedSplashscreens.where((s) => s.id == id).firstOrNull;
  }

  @override
  Future<bool> saveSplashCreens(List<SplashScreen> splashScreens) async {
    if (cachedSplashscreens.isEmpty) {
      await getSplashScreens();
    }

    await database.managers.splashScreens.bulkCreate(
      (o) => splashScreens
          .where((e) => cachedSplashscreens
              .where((s) => s.blenderVersion != e.blenderVersion)
              .isEmpty)
          .toList(),
      mode: InsertMode.insertOrFail,
    );
    await getSplashScreens();
    return true;
  }

  @override
  Future<bool> clearDatabase() async {
    await database.managers.blenderVersions.delete();
    await database.managers.splashScreens.delete();

    return true;
  }

  @override
  Future<BnextInfoData> getInfo() async {
    final result = await database.managers.bnextInfo.getSingleOrNull();
    if (result == null) {
      //If there is no info record, create a new empty one
      return await insertInfo(const BnextInfoData());
    }
    return result;
  }

  @override
  Future<BnextInfoData> insertInfo(BnextInfoData bnextInfo) async {
    await database.managers.bnextInfo.create((o) => bnextInfo);
    //Request from database so we can get the id
    return await getInfo();
  }

  @override
  Future<BnextInfoData> updateInfo(BnextInfoData bnextInfo) async {
    await database.managers.bnextInfo
        .filter((f) => f.id.equals(bnextInfo.id))
        .update((o) => bnextInfo);
    return bnextInfo;
  }
}

LocalDbAccessLayer useLocalDbAccessLayer() => LocalDbAccessLayer();

Expression<bool> platFormFilter(
  $$BlenderVersionsTableFilterComposer b,
  String? varient,
) {
  return b.downloadUrl.endsWith('sha256').not() &
      b.architecture.contains("windows", caseInsensitive: true) &
      b.architecture.contains("arm64", caseInsensitive: true).not() &
      ((varient == "installed"
          ? b.installed.equals(true)
          : b.variant.contains(varient ?? "", caseInsensitive: true))) &
      b.downloadUrl.contains(".zip", caseInsensitive: true);
}
