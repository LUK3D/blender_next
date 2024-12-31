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

@DriftDatabase(tables: [BlenderVersions, SplashScreens, BnextInfo])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

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

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'bledner_nex_db');
  }
}
