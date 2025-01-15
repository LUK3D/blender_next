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
  List<BlenderVersion> localBlenderVersions = [];

  @override
  Future<List<BlenderVersion>> getLatestBuilds({String? varient}) async {
    final result = await database.managers.blenderVersions.get();
    cachedBlenderVersions = result;
    localBlenderVersions = result;
    return result;
  }

  @override
  Stream<List<BlenderVersion>> getLatestBuildsStream({String? varient}) {
    return database.managers.blenderVersions
        .filter((e) => platFormFilter(e, varient))
        .watch();
  }

  @override
  Future<List<BlenderVersion>> getBuildById(int id) async {
    return await database.managers.blenderVersions
        .filter((e) => e.id.equals(id) & e.installed.equals(true))
        .get();
  }

  @override
  Future<List<BlenderVersion>> getBuildByVersion(String version,
      {String? varient, String? architecture, bool? instaled}) async {
    if (instaled != null) {
      return await database.managers.blenderVersions.filter((e) {
        return platFormFilter(e, varient) &
            e.version.startsWith(version) &
            e.installed.equals(instaled);
      }).get();
    }
    return await database.managers.blenderVersions.filter((e) {
      return platFormFilter(e, varient) & e.version.startsWith(version);
    }).get();
  }

  @override
  Future<bool> saveBuilds({required List<BlenderVersion> blenderBuilds}) async {
    if (localBlenderVersions.isEmpty) {
      await getLatestBuilds();
    }
    try {
      final blendersToSave = <BlenderVersion>[];

      for (final blender in blenderBuilds) {
        final existing = localBlenderVersions
            .where((e) =>
                e.version == blender.version &&
                e.id != null &&
                e.variant == blender.variant &&
                e.architecture == blender.architecture)
            .firstOrNull;
        if (existing == null) {
          blendersToSave.add(blender);
        }
      }

      await database.managers.blenderVersions.bulkCreate(
        (o) => blendersToSave,
        mode: InsertMode.insertOrReplace,
      );
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
    // await database.managers.blenderVersions.delete();
    // await database.managers.splashScreens.delete();
    // await database.managers.bnexProjects.delete();
    // await database.managers.bnextExtensions.delete();

    // await database.deleteAll();
    // Logger().e("All deleted!!");

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

  @override
  Future<BnexProject> createProject(BnexProject project) async {
    final id = await database.managers.bnexProjects.create((o) => project);
    return project.copyWith(id: Value(id));
  }

//Change this so we only hide the project instead of deleting it
  @override
  Future<void> deleteProject(BnexProject project, {bool unlist = false}) async {
    if (unlist) {
      await updateProject(project.copyWith(unlisted: const Value(true)));
      return;
    }
    await database.managers.bnexProjects
        .filter((e) => e.id.equals(project.id))
        .delete();
  }

  @override
  Future<BnexProject> unlistProject(BnexProject project) async {
    await database.managers.bnexProjects
        .filter((e) => e.id.equals(project.id))
        .update((o) => o(unlisted: const Value(true)));
    return project;
  }

  @override
  Stream<List<BnexProject>> getProjects() {
    return database.managers.bnexProjects
        .filter((e) => e.unlisted.equals(false))
        .watch();
  }

  @override
  Future<BnexProject> updateProject(BnexProject project) async {
    await database.managers.bnexProjects
        .filter((e) => e.id.equals(project.id))
        .update((o) => project);

    return project;
  }

  @override
  Future<List<BnextExtension>> getExtensions() async {
    return await database.managers.bnextExtensions.get();
  }

  @override
  Stream<List<BnextExtension>> getExtensionsStream() {
    return database.managers.bnextExtensions.watch();
  }

  @override
  Future<List<BnextExtension>> saveExtensions(
    List<BnextExtension> extensions,
  ) async {
    await database.managers.bnextExtensions.bulkCreate((o) => extensions);

    return await getExtensions();
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
