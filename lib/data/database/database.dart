import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

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
  late final template = text()();
  late final usingVersionControl = boolean().clientDefault(() => false)();
  late final clearExtentions = boolean().clientDefault(() => false)();
  late final dir = text()();
  late final cover = text().nullable()();
  late final unlisted = boolean().clientDefault(() => false)();
}

class BnextExtensions extends Table with TableMixin {
  late final schemaVersion = text()();
  late final extId = text().nullable()();
  late final name = text().nullable()();
  late final version = text()();
  late final tagline = text().nullable()();
  late final maintainer = text().nullable()();
  late final type = text().nullable()();
  late final tags = text().nullable()();
  late final blenderMinVersion = text()();
  late final licence = text().nullable()();
  late final website = text().nullable()();
  late final copyright = text().nullable()();
  late final permissions = text().nullable()();
}

class BnextProjectExtensions extends Table with TableMixin {
  late final project = integer().references(BnexProjects, #id)();
  late final bnextExtension = integer().references(BnextExtensions, #id)();
}

@DriftDatabase(tables: [
  BlenderVersions,
  SplashScreens,
  BnextInfo,
  BnexProjects,
  BnextExtensions,
  BnextProjectExtensions
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

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'bledner_nex_db');
  }
}
