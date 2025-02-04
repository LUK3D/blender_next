import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:logger/logger.dart';

part 'database.g.dart';

mixin TableMixin on Table {
  // Primary key column
  late final id = integer().nullable().autoIncrement()();

  // Column for created at timestamp
  late final createdAt =
      dateTime().nullable().withDefault(currentDateAndTime)();
}

class BlenderVersions extends Table with TableMixin {
  late final title = text()();
  late final description = text()();
  late final version = text()();
  late final variant = text()();
  late final reference = text()();
  late final referenceUrl = text()();
  late final sha = text()();
  late final shaUrl = text()();
  late final date = text()();
  late final architecture = text()();
  late final downloadUrl = text()();
  late final installed = boolean().clientDefault(() => false)();
  late final installationPath = text().nullable()();
  late final splashScreen =
      integer().nullable().references(SplashScreens, #id)();
}

class SplashScreens extends Table with TableMixin {
  late final title = text()();
  late final imageUrl = text()();
  late final projectUrl = text()();
  late final author = text()();
  late final authorUrl = text()();
  late final license = text()();
  late final size = text().nullable()();
  late final blenderVersion = text()();
}

class BnextInfo extends Table with TableMixin {
  late final lastRequestOn =
      dateTime().nullable().withDefault(currentDateAndTime)();
}

class BnexProjects extends Table with TableMixin {
  late final name = text().clientDefault(() => "value")();
  late final description = text().nullable()();
  late final size = text().nullable()();
  late final tags = text().nullable()();
  late final blenderVariant = text()();
  late final blenderVersion = text()();
  late final template = text().nullable()();
  late final usingVersionControl =
      boolean().nullable().clientDefault(() => false)();
  late final clearExtentions =
      boolean().nullable().clientDefault(() => false)();
  late final dir = text()();
  late final cover = text().nullable()();
  late final unlisted = boolean().nullable().clientDefault(() => false)();
}

class BnextExtensions extends Table with TableMixin {
  late final schemaVersion = text().nullable()();
  late final cover = text().nullable()();
  late final icon = text().nullable()();
  late final extId = text().nullable()();
  late final name = text().nullable()();
  late final description = text().nullable()();
  late final mdDescriptio = text().nullable()();
  late final version = text().nullable()();
  late final tagline = text().nullable()();
  late final maintainer = text().nullable()();
  late final type = text().nullable()();
  late final tags = text().nullable()();
  late final blenderMinVersion = text().nullable()();
  late final licence = text().nullable()();
  late final licenceUrl = text().nullable()();
  late final website = text().nullable()();
  late final detailsUrl = text().nullable()();
  late final downloadUrl = text().nullable()();
  late final draggableUrl = text().nullable()();
  late final size = text().nullable()();
  late final copyright = text().nullable()();
  late final permissions = text().nullable()();
  late final stars = real().nullable()();
  late final reviewers = integer().nullable()();
  late final downloads = integer().nullable()();
  late final mediaUrls = text()
      .nullable()(); //A json string with the urls of the videos/images showcasing this extension.
  late final publishedOn = dateTime().nullable()();
  late final lastUpdateOn = dateTime().nullable()();
  late final supportUrl = text().nullable()();
}

class BnextProjectExtensions extends Table with TableMixin {
  late final project = integer().references(BnexProjects, #id)();
  late final bnextExtension = integer().references(BnextExtensions, #id)();
}

class BnextExtensionVersions extends Table with TableMixin {
  late final ext = integer().references(BnextExtensions, #id)();
  late final version = text()();
  late final blenderMinVersion = text().nullable()();
  late final blenderMinVersionint = integer().nullable()();
  late final downloadUrl = text().nullable()();
  late final instalationPath = text().nullable()();
  late final releaseNotes = text().nullable()();
  late final metaData = text().nullable()();
}

class BnextBlenderInstalledExtensions extends Table with TableMixin {
  late final extId = text()();
  late final extVersionNumber = text()();
  late final blenderVersionNumber = text()();
  late final instalationFolderPath = text()();
}

@DriftDatabase(tables: [
  BlenderVersions,
  SplashScreens,
  BnextInfo,
  BnexProjects,
  BnextExtensions,
  BnextProjectExtensions,
  BnextExtensionVersions,
  BnextBlenderInstalledExtensions,
])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        await m.createAll();
      },
    );
  }

  Future deleteAll() async {
    final m = createMigrator();
    // Going through tables in reverse because they are sorted for foreign keys
    for (final table in allTables.toList().reversed) {
      await m.deleteTable(table.actualTableName);
    }
  }

  Stream<BlenderVersion> getBlenderVersionStreamById(BlenderVersion bv) {
    return managers.blenderVersions
        .filter((e) => e.id.equals(bv.id))
        .watchSingle();
  }

  Future<List<BnextExtension>> get getExtensions =>
      select(bnextExtensions).get();

  Future<List<BnextExtension>> insertExtensions(
      List<BnextExtension> extensions) async {
    final List<BnextExtension> toBeInserted = [];
    for (var ext in extensions) {
      var exists = await (select(bnextExtensions)
            ..where((o) => o.extId.equals(ext.extId ?? "")))
          .get();

      if (exists.isEmpty) {
        Logger().i("ADDING: ${ext.extId}");
        toBeInserted.add(ext);
      } else {
        await updateExtension(exists.first.copyWith(
          version: Value(ext.version),
          blenderMinVersion: Value(ext.blenderMinVersion),
          copyright: Value(ext.copyright),
          cover: Value(ext.cover),
          description: Value(ext.description),
          detailsUrl: Value(ext.detailsUrl),
          downloadUrl: Value(ext.downloadUrl),
          downloads: Value(ext.downloads),
          draggableUrl: Value(ext.draggableUrl),
          icon: Value(ext.icon),
          lastUpdateOn: Value(ext.lastUpdateOn),
          licence: Value(ext.licence),
          licenceUrl: Value(ext.licenceUrl),
          maintainer: Value(ext.maintainer),
          mdDescriptio: Value(ext.mdDescriptio),
          mediaUrls: Value(ext.mediaUrls),
          name: Value(ext.name),
          permissions: Value(ext.permissions),
          publishedOn: Value(ext.publishedOn),
          reviewers: Value(ext.reviewers),
          schemaVersion: Value(ext.schemaVersion),
          size: Value(ext.size),
          stars: Value(ext.stars),
          supportUrl: Value(ext.supportUrl),
          tagline: Value(ext.tagline),
          tags: Value(ext.tags),
          type: Value(ext.type),
          website: Value(ext.website),
        ));
      }
    }

    await batch((batch) {
      batch.insertAll(bnextExtensions, toBeInserted);
    });
    return managers.bnextExtensions
        .filter((f) => f.extId.isIn(extensions.map((e) => e.extId!)))
        .get();
  }

  Future<BnextExtension> updateExtension(BnextExtension ext) async {
    await managers.bnextExtensions
        .filter((f) => f.id.equals(ext.id))
        .update((e) => ext);
    return ext;
  }

  Stream<List<BnextExtension>> top5Extensions() {
    return managers.bnextExtensions
        .orderBy((o) => o.downloads.asc())
        .limit(5)
        .watch();
  }

  Future<List<BnextExtension>> getExtensionById(int id) {
    return managers.bnextExtensions.filter((e) => e.id.equals(id)).get();
  }

  Stream<BnextExtension> getExtensionStreamById(BnextExtension ext) {
    return managers.bnextExtensions
        .filter((e) => e.id.equals(ext.id))
        .watchSingle();
  }

  Stream<List<BnextExtension>> getExtensionsStream() {
    return managers.bnextExtensions.orderBy((o) => o.stars.desc()).watch();
  }

  Future<List<BnextExtensionVersion>> createExtensionVersions(
    List<BnextExtensionVersion> extVersions,
  ) async {
    final List<BnextExtensionVersion> toBeInserted = [];

    for (var ext in extVersions) {
      final result = (await managers.bnextExtensionVersions
          .filter(
              (f) => f.version.equals(ext.version) & f.ext.id.equals(ext.ext))
          .get());
      if (result.isEmpty) {
        toBeInserted.add(ext);
      }
    }

    await batch((batch) {
      batch.insertAll(bnextExtensionVersions, toBeInserted);
    });

    return await getExtensionVersionByExtensionId(extVersions.first.ext);
  }

  Future<BnextExtensionVersion> updateExtensionVersion(
      BnextExtensionVersion extVersion) async {
    await managers.bnextExtensionVersions
        .filter((f) => f.id.equals(extVersion.id))
        .update((f) => extVersion);
    return extVersion;
  }

  Future<List<BnextExtensionVersion>> getExtensionVersionById(int id) async {
    return await managers.bnextExtensionVersions
        .filter((f) => f.id.equals(id))
        .get();
  }

  Future<List<BnextExtensionVersion>>
      getExtensionVersionByExtensionIdAndVersion(
          int extensionId, String version) async {
    return await managers.bnextExtensionVersions
        .filter((f) => f.ext.id.equals(extensionId) & f.version.equals(version))
        .get();
  }

  Future<List<BnextExtensionVersion>> getExtensionVersionByExtensionId(
      int id) async {
    return await managers.bnextExtensionVersions
        .filter((f) => f.ext.id.equals(id))
        .get();
  }

  Future<List<BnextExtension>> getExtensionSteamsByBlenderMajorVersion(
      String version) async {
    final List<int> extensionIds = [];

    for (var extVersion in (await managers.bnextExtensionVersions
        .filter((f) =>
            f.blenderMinVersionint.isSmallerOrEqualTo(
                int.tryParse(version.substring(0, 3).split(".").join("")) ??
                    0) &
            f.blenderMinVersionint.not.equals(0))
        .get())) {
      if (!extensionIds.contains(extVersion.ext)) {
        extensionIds.add(extVersion.ext);
      }
    }

    return await managers.bnextExtensions
        .filter((f) => f.id.isIn(extensionIds))
        .get();
  }

  Stream<List<BnextExtensionVersion>> getExtensionVersionByExtensionIdSteam(
      int id) {
    return managers.bnextExtensionVersions
        .filter((f) => f.ext.id.equals(id))
        .watch();
  }

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(
        name: 'temp_db_1',
        native: DriftNativeOptions(
          databasePath: () {
            return Future.value(
                '${Directory.current.path}/blender_next_database.sqlite');
          },
        ));
  }

  Future<List<BnextBlenderInstalledExtension>> insertBlenderInstalledExtensions(
      List<BnextBlenderInstalledExtension> ext, String blenderVersion) async {
    await managers.bnextBlenderInstalledExtensions
        .filter((f) => f.extId.isIn(ext.map((e) => e.extId)))
        .delete();

    await batch((batch) {
      batch.insertAll(bnextBlenderInstalledExtensions, ext);
    });

    return await getBlenderInstalledExtensions(blenderVersion);
  }

  Future<List<BnextBlenderInstalledExtension>> getBlenderInstalledExtensions(
      String blenderVersion) async {
    return await managers.bnextBlenderInstalledExtensions
        .filter((f) => f.blenderVersionNumber.equals(blenderVersion))
        .get();
  }

  Future<List<Map<BnextExtension, BnextExtensionVersion>>>
      getBlenderInstalledExtensionsWithVersions(String blenderVersion) async {
    final installedExtensions = await managers.bnextBlenderInstalledExtensions
        .filter((f) => f.blenderVersionNumber.equals(blenderVersion))
        .get();

    final extensions = await managers.bnextExtensions
        .filter((e) =>
            e.extId.isIn(installedExtensions.map((ee) => ee.extId).toList()))
        .get();

    final versions = await managers.bnextExtensionVersions
        .filter((ev) =>
            ev.version.isIn(
                installedExtensions.map((ee) => ee.extVersionNumber).toList()) &
            ev.ext.extId
                .isIn(installedExtensions.map((ee) => ee.extId).toList()))
        .get();

    final result = <Map<BnextExtension, BnextExtensionVersion>>[];

    for (var ext in extensions) {
      result.add({ext: versions.where((e) => e.ext == ext.id).first});
    }

    return result;
  }

  Future<List<BnextBlenderInstalledExtension>> getBlenderInstalledExtensionId(
      String extId) async {
    return await managers.bnextBlenderInstalledExtensions
        .filter((f) => f.extId.equals(extId))
        .get();
  }

  Future<List<BnextExtension>> getBlenderInstalledExtensionsByExtensionId(
      String extId) async {
    final extensons = await managers.bnextBlenderInstalledExtensions
        .filter((f) => f.extId.equals(extId))
        .get();

    return await managers.bnextExtensions
        .filter((f) => f.extId.isIn(extensons.map((e) => e.extId)))
        .get();
  }

  Future deleteBlenderInstalledExtensionsByExtensionId(
      List<String> extId) async {
    await managers.bnextBlenderInstalledExtensions
        .filter((f) => f.extId.isIn(extId))
        .delete();
  }

  Future<List<BnextExtensionVersion>> installedExtensions(
      BnextExtension ext) async {
    return await managers.bnextExtensionVersions
        .filter((f) =>
            f.instalationPath.not.equals(null) &
            f.instalationPath.not.equals("") &
            f.ext.id.equals(ext.id))
        .get();
  }
}
