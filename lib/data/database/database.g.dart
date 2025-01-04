// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SplashScreensTable extends SplashScreens
    with TableInfo<$SplashScreensTable, SplashScreen> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SplashScreensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _projectUrlMeta =
      const VerificationMeta('projectUrl');
  @override
  late final GeneratedColumn<String> projectUrl = GeneratedColumn<String>(
      'project_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorUrlMeta =
      const VerificationMeta('authorUrl');
  @override
  late final GeneratedColumn<String> authorUrl = GeneratedColumn<String>(
      'author_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _licenseMeta =
      const VerificationMeta('license');
  @override
  late final GeneratedColumn<String> license = GeneratedColumn<String>(
      'license', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
      'size', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _blenderVersionMeta =
      const VerificationMeta('blenderVersion');
  @override
  late final GeneratedColumn<String> blenderVersion = GeneratedColumn<String>(
      'blender_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        title,
        imageUrl,
        projectUrl,
        author,
        authorUrl,
        license,
        size,
        blenderVersion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'splash_screens';
  @override
  VerificationContext validateIntegrity(Insertable<SplashScreen> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('project_url')) {
      context.handle(
          _projectUrlMeta,
          projectUrl.isAcceptableOrUnknown(
              data['project_url']!, _projectUrlMeta));
    } else if (isInserting) {
      context.missing(_projectUrlMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('author_url')) {
      context.handle(_authorUrlMeta,
          authorUrl.isAcceptableOrUnknown(data['author_url']!, _authorUrlMeta));
    } else if (isInserting) {
      context.missing(_authorUrlMeta);
    }
    if (data.containsKey('license')) {
      context.handle(_licenseMeta,
          license.isAcceptableOrUnknown(data['license']!, _licenseMeta));
    } else if (isInserting) {
      context.missing(_licenseMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('blender_version')) {
      context.handle(
          _blenderVersionMeta,
          blenderVersion.isAcceptableOrUnknown(
              data['blender_version']!, _blenderVersionMeta));
    } else if (isInserting) {
      context.missing(_blenderVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SplashScreen map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SplashScreen(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      projectUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_url'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      authorUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_url'])!,
      license: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}license'])!,
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}size']),
      blenderVersion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}blender_version'])!,
    );
  }

  @override
  $SplashScreensTable createAlias(String alias) {
    return $SplashScreensTable(attachedDatabase, alias);
  }
}

class SplashScreen extends DataClass implements Insertable<SplashScreen> {
  final int? id;
  final DateTime? createdAt;
  final String title;
  final String imageUrl;
  final String projectUrl;
  final String author;
  final String authorUrl;
  final String license;
  final String? size;
  final String blenderVersion;
  const SplashScreen(
      {this.id,
      this.createdAt,
      required this.title,
      required this.imageUrl,
      required this.projectUrl,
      required this.author,
      required this.authorUrl,
      required this.license,
      this.size,
      required this.blenderVersion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['title'] = Variable<String>(title);
    map['image_url'] = Variable<String>(imageUrl);
    map['project_url'] = Variable<String>(projectUrl);
    map['author'] = Variable<String>(author);
    map['author_url'] = Variable<String>(authorUrl);
    map['license'] = Variable<String>(license);
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    map['blender_version'] = Variable<String>(blenderVersion);
    return map;
  }

  SplashScreensCompanion toCompanion(bool nullToAbsent) {
    return SplashScreensCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      title: Value(title),
      imageUrl: Value(imageUrl),
      projectUrl: Value(projectUrl),
      author: Value(author),
      authorUrl: Value(authorUrl),
      license: Value(license),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      blenderVersion: Value(blenderVersion),
    );
  }

  factory SplashScreen.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SplashScreen(
      id: serializer.fromJson<int?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      title: serializer.fromJson<String>(json['title']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      projectUrl: serializer.fromJson<String>(json['projectUrl']),
      author: serializer.fromJson<String>(json['author']),
      authorUrl: serializer.fromJson<String>(json['authorUrl']),
      license: serializer.fromJson<String>(json['license']),
      size: serializer.fromJson<String?>(json['size']),
      blenderVersion: serializer.fromJson<String>(json['blenderVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'title': serializer.toJson<String>(title),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'projectUrl': serializer.toJson<String>(projectUrl),
      'author': serializer.toJson<String>(author),
      'authorUrl': serializer.toJson<String>(authorUrl),
      'license': serializer.toJson<String>(license),
      'size': serializer.toJson<String?>(size),
      'blenderVersion': serializer.toJson<String>(blenderVersion),
    };
  }

  SplashScreen copyWith(
          {Value<int?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          String? title,
          String? imageUrl,
          String? projectUrl,
          String? author,
          String? authorUrl,
          String? license,
          Value<String?> size = const Value.absent(),
          String? blenderVersion}) =>
      SplashScreen(
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        projectUrl: projectUrl ?? this.projectUrl,
        author: author ?? this.author,
        authorUrl: authorUrl ?? this.authorUrl,
        license: license ?? this.license,
        size: size.present ? size.value : this.size,
        blenderVersion: blenderVersion ?? this.blenderVersion,
      );
  SplashScreen copyWithCompanion(SplashScreensCompanion data) {
    return SplashScreen(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      title: data.title.present ? data.title.value : this.title,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      projectUrl:
          data.projectUrl.present ? data.projectUrl.value : this.projectUrl,
      author: data.author.present ? data.author.value : this.author,
      authorUrl: data.authorUrl.present ? data.authorUrl.value : this.authorUrl,
      license: data.license.present ? data.license.value : this.license,
      size: data.size.present ? data.size.value : this.size,
      blenderVersion: data.blenderVersion.present
          ? data.blenderVersion.value
          : this.blenderVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SplashScreen(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('projectUrl: $projectUrl, ')
          ..write('author: $author, ')
          ..write('authorUrl: $authorUrl, ')
          ..write('license: $license, ')
          ..write('size: $size, ')
          ..write('blenderVersion: $blenderVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, title, imageUrl, projectUrl,
      author, authorUrl, license, size, blenderVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SplashScreen &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.title == this.title &&
          other.imageUrl == this.imageUrl &&
          other.projectUrl == this.projectUrl &&
          other.author == this.author &&
          other.authorUrl == this.authorUrl &&
          other.license == this.license &&
          other.size == this.size &&
          other.blenderVersion == this.blenderVersion);
}

class SplashScreensCompanion extends UpdateCompanion<SplashScreen> {
  final Value<int?> id;
  final Value<DateTime?> createdAt;
  final Value<String> title;
  final Value<String> imageUrl;
  final Value<String> projectUrl;
  final Value<String> author;
  final Value<String> authorUrl;
  final Value<String> license;
  final Value<String?> size;
  final Value<String> blenderVersion;
  const SplashScreensCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.title = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.projectUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.authorUrl = const Value.absent(),
    this.license = const Value.absent(),
    this.size = const Value.absent(),
    this.blenderVersion = const Value.absent(),
  });
  SplashScreensCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String title,
    required String imageUrl,
    required String projectUrl,
    required String author,
    required String authorUrl,
    required String license,
    this.size = const Value.absent(),
    required String blenderVersion,
  })  : title = Value(title),
        imageUrl = Value(imageUrl),
        projectUrl = Value(projectUrl),
        author = Value(author),
        authorUrl = Value(authorUrl),
        license = Value(license),
        blenderVersion = Value(blenderVersion);
  static Insertable<SplashScreen> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? title,
    Expression<String>? imageUrl,
    Expression<String>? projectUrl,
    Expression<String>? author,
    Expression<String>? authorUrl,
    Expression<String>? license,
    Expression<String>? size,
    Expression<String>? blenderVersion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (title != null) 'title': title,
      if (imageUrl != null) 'image_url': imageUrl,
      if (projectUrl != null) 'project_url': projectUrl,
      if (author != null) 'author': author,
      if (authorUrl != null) 'author_url': authorUrl,
      if (license != null) 'license': license,
      if (size != null) 'size': size,
      if (blenderVersion != null) 'blender_version': blenderVersion,
    });
  }

  SplashScreensCompanion copyWith(
      {Value<int?>? id,
      Value<DateTime?>? createdAt,
      Value<String>? title,
      Value<String>? imageUrl,
      Value<String>? projectUrl,
      Value<String>? author,
      Value<String>? authorUrl,
      Value<String>? license,
      Value<String?>? size,
      Value<String>? blenderVersion}) {
    return SplashScreensCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      projectUrl: projectUrl ?? this.projectUrl,
      author: author ?? this.author,
      authorUrl: authorUrl ?? this.authorUrl,
      license: license ?? this.license,
      size: size ?? this.size,
      blenderVersion: blenderVersion ?? this.blenderVersion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (projectUrl.present) {
      map['project_url'] = Variable<String>(projectUrl.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (authorUrl.present) {
      map['author_url'] = Variable<String>(authorUrl.value);
    }
    if (license.present) {
      map['license'] = Variable<String>(license.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (blenderVersion.present) {
      map['blender_version'] = Variable<String>(blenderVersion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SplashScreensCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('projectUrl: $projectUrl, ')
          ..write('author: $author, ')
          ..write('authorUrl: $authorUrl, ')
          ..write('license: $license, ')
          ..write('size: $size, ')
          ..write('blenderVersion: $blenderVersion')
          ..write(')'))
        .toString();
  }
}

class $BlenderVersionsTable extends BlenderVersions
    with TableInfo<$BlenderVersionsTable, BlenderVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlenderVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _variantMeta =
      const VerificationMeta('variant');
  @override
  late final GeneratedColumn<String> variant = GeneratedColumn<String>(
      'variant', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceUrlMeta =
      const VerificationMeta('referenceUrl');
  @override
  late final GeneratedColumn<String> referenceUrl = GeneratedColumn<String>(
      'reference_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shaMeta = const VerificationMeta('sha');
  @override
  late final GeneratedColumn<String> sha = GeneratedColumn<String>(
      'sha', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shaUrlMeta = const VerificationMeta('shaUrl');
  @override
  late final GeneratedColumn<String> shaUrl = GeneratedColumn<String>(
      'sha_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _architectureMeta =
      const VerificationMeta('architecture');
  @override
  late final GeneratedColumn<String> architecture = GeneratedColumn<String>(
      'architecture', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _downloadUrlMeta =
      const VerificationMeta('downloadUrl');
  @override
  late final GeneratedColumn<String> downloadUrl = GeneratedColumn<String>(
      'download_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _installedMeta =
      const VerificationMeta('installed');
  @override
  late final GeneratedColumn<bool> installed = GeneratedColumn<bool>(
      'installed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("installed" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _installationPathMeta =
      const VerificationMeta('installationPath');
  @override
  late final GeneratedColumn<String> installationPath = GeneratedColumn<String>(
      'installation_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _splashScreenMeta =
      const VerificationMeta('splashScreen');
  @override
  late final GeneratedColumn<int> splashScreen = GeneratedColumn<int>(
      'splash_screen', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES splash_screens (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        title,
        description,
        version,
        variant,
        reference,
        referenceUrl,
        sha,
        shaUrl,
        date,
        architecture,
        downloadUrl,
        installed,
        installationPath,
        splashScreen
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blender_versions';
  @override
  VerificationContext validateIntegrity(Insertable<BlenderVersion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('variant')) {
      context.handle(_variantMeta,
          variant.isAcceptableOrUnknown(data['variant']!, _variantMeta));
    } else if (isInserting) {
      context.missing(_variantMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('reference_url')) {
      context.handle(
          _referenceUrlMeta,
          referenceUrl.isAcceptableOrUnknown(
              data['reference_url']!, _referenceUrlMeta));
    } else if (isInserting) {
      context.missing(_referenceUrlMeta);
    }
    if (data.containsKey('sha')) {
      context.handle(
          _shaMeta, sha.isAcceptableOrUnknown(data['sha']!, _shaMeta));
    } else if (isInserting) {
      context.missing(_shaMeta);
    }
    if (data.containsKey('sha_url')) {
      context.handle(_shaUrlMeta,
          shaUrl.isAcceptableOrUnknown(data['sha_url']!, _shaUrlMeta));
    } else if (isInserting) {
      context.missing(_shaUrlMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('architecture')) {
      context.handle(
          _architectureMeta,
          architecture.isAcceptableOrUnknown(
              data['architecture']!, _architectureMeta));
    } else if (isInserting) {
      context.missing(_architectureMeta);
    }
    if (data.containsKey('download_url')) {
      context.handle(
          _downloadUrlMeta,
          downloadUrl.isAcceptableOrUnknown(
              data['download_url']!, _downloadUrlMeta));
    } else if (isInserting) {
      context.missing(_downloadUrlMeta);
    }
    if (data.containsKey('installed')) {
      context.handle(_installedMeta,
          installed.isAcceptableOrUnknown(data['installed']!, _installedMeta));
    }
    if (data.containsKey('installation_path')) {
      context.handle(
          _installationPathMeta,
          installationPath.isAcceptableOrUnknown(
              data['installation_path']!, _installationPathMeta));
    }
    if (data.containsKey('splash_screen')) {
      context.handle(
          _splashScreenMeta,
          splashScreen.isAcceptableOrUnknown(
              data['splash_screen']!, _splashScreenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlenderVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlenderVersion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
      variant: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference'])!,
      referenceUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_url'])!,
      sha: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sha'])!,
      shaUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sha_url'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      architecture: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}architecture'])!,
      downloadUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}download_url'])!,
      installed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}installed'])!,
      installationPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}installation_path']),
      splashScreen: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}splash_screen']),
    );
  }

  @override
  $BlenderVersionsTable createAlias(String alias) {
    return $BlenderVersionsTable(attachedDatabase, alias);
  }
}

class BlenderVersion extends DataClass implements Insertable<BlenderVersion> {
  final int? id;
  final DateTime? createdAt;
  final String title;
  final String description;
  final String version;
  final String variant;
  final String reference;
  final String referenceUrl;
  final String sha;
  final String shaUrl;
  final String date;
  final String architecture;
  final String downloadUrl;
  final bool installed;
  final String? installationPath;
  final int? splashScreen;
  const BlenderVersion(
      {this.id,
      this.createdAt,
      required this.title,
      required this.description,
      required this.version,
      required this.variant,
      required this.reference,
      required this.referenceUrl,
      required this.sha,
      required this.shaUrl,
      required this.date,
      required this.architecture,
      required this.downloadUrl,
      required this.installed,
      this.installationPath,
      this.splashScreen});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['version'] = Variable<String>(version);
    map['variant'] = Variable<String>(variant);
    map['reference'] = Variable<String>(reference);
    map['reference_url'] = Variable<String>(referenceUrl);
    map['sha'] = Variable<String>(sha);
    map['sha_url'] = Variable<String>(shaUrl);
    map['date'] = Variable<String>(date);
    map['architecture'] = Variable<String>(architecture);
    map['download_url'] = Variable<String>(downloadUrl);
    map['installed'] = Variable<bool>(installed);
    if (!nullToAbsent || installationPath != null) {
      map['installation_path'] = Variable<String>(installationPath);
    }
    if (!nullToAbsent || splashScreen != null) {
      map['splash_screen'] = Variable<int>(splashScreen);
    }
    return map;
  }

  BlenderVersionsCompanion toCompanion(bool nullToAbsent) {
    return BlenderVersionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      title: Value(title),
      description: Value(description),
      version: Value(version),
      variant: Value(variant),
      reference: Value(reference),
      referenceUrl: Value(referenceUrl),
      sha: Value(sha),
      shaUrl: Value(shaUrl),
      date: Value(date),
      architecture: Value(architecture),
      downloadUrl: Value(downloadUrl),
      installed: Value(installed),
      installationPath: installationPath == null && nullToAbsent
          ? const Value.absent()
          : Value(installationPath),
      splashScreen: splashScreen == null && nullToAbsent
          ? const Value.absent()
          : Value(splashScreen),
    );
  }

  factory BlenderVersion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlenderVersion(
      id: serializer.fromJson<int?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      version: serializer.fromJson<String>(json['version']),
      variant: serializer.fromJson<String>(json['variant']),
      reference: serializer.fromJson<String>(json['reference']),
      referenceUrl: serializer.fromJson<String>(json['referenceUrl']),
      sha: serializer.fromJson<String>(json['sha']),
      shaUrl: serializer.fromJson<String>(json['shaUrl']),
      date: serializer.fromJson<String>(json['date']),
      architecture: serializer.fromJson<String>(json['architecture']),
      downloadUrl: serializer.fromJson<String>(json['downloadUrl']),
      installed: serializer.fromJson<bool>(json['installed']),
      installationPath: serializer.fromJson<String?>(json['installationPath']),
      splashScreen: serializer.fromJson<int?>(json['splashScreen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'version': serializer.toJson<String>(version),
      'variant': serializer.toJson<String>(variant),
      'reference': serializer.toJson<String>(reference),
      'referenceUrl': serializer.toJson<String>(referenceUrl),
      'sha': serializer.toJson<String>(sha),
      'shaUrl': serializer.toJson<String>(shaUrl),
      'date': serializer.toJson<String>(date),
      'architecture': serializer.toJson<String>(architecture),
      'downloadUrl': serializer.toJson<String>(downloadUrl),
      'installed': serializer.toJson<bool>(installed),
      'installationPath': serializer.toJson<String?>(installationPath),
      'splashScreen': serializer.toJson<int?>(splashScreen),
    };
  }

  BlenderVersion copyWith(
          {Value<int?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          String? title,
          String? description,
          String? version,
          String? variant,
          String? reference,
          String? referenceUrl,
          String? sha,
          String? shaUrl,
          String? date,
          String? architecture,
          String? downloadUrl,
          bool? installed,
          Value<String?> installationPath = const Value.absent(),
          Value<int?> splashScreen = const Value.absent()}) =>
      BlenderVersion(
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        title: title ?? this.title,
        description: description ?? this.description,
        version: version ?? this.version,
        variant: variant ?? this.variant,
        reference: reference ?? this.reference,
        referenceUrl: referenceUrl ?? this.referenceUrl,
        sha: sha ?? this.sha,
        shaUrl: shaUrl ?? this.shaUrl,
        date: date ?? this.date,
        architecture: architecture ?? this.architecture,
        downloadUrl: downloadUrl ?? this.downloadUrl,
        installed: installed ?? this.installed,
        installationPath: installationPath.present
            ? installationPath.value
            : this.installationPath,
        splashScreen:
            splashScreen.present ? splashScreen.value : this.splashScreen,
      );
  BlenderVersion copyWithCompanion(BlenderVersionsCompanion data) {
    return BlenderVersion(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      version: data.version.present ? data.version.value : this.version,
      variant: data.variant.present ? data.variant.value : this.variant,
      reference: data.reference.present ? data.reference.value : this.reference,
      referenceUrl: data.referenceUrl.present
          ? data.referenceUrl.value
          : this.referenceUrl,
      sha: data.sha.present ? data.sha.value : this.sha,
      shaUrl: data.shaUrl.present ? data.shaUrl.value : this.shaUrl,
      date: data.date.present ? data.date.value : this.date,
      architecture: data.architecture.present
          ? data.architecture.value
          : this.architecture,
      downloadUrl:
          data.downloadUrl.present ? data.downloadUrl.value : this.downloadUrl,
      installed: data.installed.present ? data.installed.value : this.installed,
      installationPath: data.installationPath.present
          ? data.installationPath.value
          : this.installationPath,
      splashScreen: data.splashScreen.present
          ? data.splashScreen.value
          : this.splashScreen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlenderVersion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('version: $version, ')
          ..write('variant: $variant, ')
          ..write('reference: $reference, ')
          ..write('referenceUrl: $referenceUrl, ')
          ..write('sha: $sha, ')
          ..write('shaUrl: $shaUrl, ')
          ..write('date: $date, ')
          ..write('architecture: $architecture, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('installed: $installed, ')
          ..write('installationPath: $installationPath, ')
          ..write('splashScreen: $splashScreen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      title,
      description,
      version,
      variant,
      reference,
      referenceUrl,
      sha,
      shaUrl,
      date,
      architecture,
      downloadUrl,
      installed,
      installationPath,
      splashScreen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlenderVersion &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.title == this.title &&
          other.description == this.description &&
          other.version == this.version &&
          other.variant == this.variant &&
          other.reference == this.reference &&
          other.referenceUrl == this.referenceUrl &&
          other.sha == this.sha &&
          other.shaUrl == this.shaUrl &&
          other.date == this.date &&
          other.architecture == this.architecture &&
          other.downloadUrl == this.downloadUrl &&
          other.installed == this.installed &&
          other.installationPath == this.installationPath &&
          other.splashScreen == this.splashScreen);
}

class BlenderVersionsCompanion extends UpdateCompanion<BlenderVersion> {
  final Value<int?> id;
  final Value<DateTime?> createdAt;
  final Value<String> title;
  final Value<String> description;
  final Value<String> version;
  final Value<String> variant;
  final Value<String> reference;
  final Value<String> referenceUrl;
  final Value<String> sha;
  final Value<String> shaUrl;
  final Value<String> date;
  final Value<String> architecture;
  final Value<String> downloadUrl;
  final Value<bool> installed;
  final Value<String?> installationPath;
  final Value<int?> splashScreen;
  const BlenderVersionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.version = const Value.absent(),
    this.variant = const Value.absent(),
    this.reference = const Value.absent(),
    this.referenceUrl = const Value.absent(),
    this.sha = const Value.absent(),
    this.shaUrl = const Value.absent(),
    this.date = const Value.absent(),
    this.architecture = const Value.absent(),
    this.downloadUrl = const Value.absent(),
    this.installed = const Value.absent(),
    this.installationPath = const Value.absent(),
    this.splashScreen = const Value.absent(),
  });
  BlenderVersionsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String title,
    required String description,
    required String version,
    required String variant,
    required String reference,
    required String referenceUrl,
    required String sha,
    required String shaUrl,
    required String date,
    required String architecture,
    required String downloadUrl,
    this.installed = const Value.absent(),
    this.installationPath = const Value.absent(),
    this.splashScreen = const Value.absent(),
  })  : title = Value(title),
        description = Value(description),
        version = Value(version),
        variant = Value(variant),
        reference = Value(reference),
        referenceUrl = Value(referenceUrl),
        sha = Value(sha),
        shaUrl = Value(shaUrl),
        date = Value(date),
        architecture = Value(architecture),
        downloadUrl = Value(downloadUrl);
  static Insertable<BlenderVersion> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? version,
    Expression<String>? variant,
    Expression<String>? reference,
    Expression<String>? referenceUrl,
    Expression<String>? sha,
    Expression<String>? shaUrl,
    Expression<String>? date,
    Expression<String>? architecture,
    Expression<String>? downloadUrl,
    Expression<bool>? installed,
    Expression<String>? installationPath,
    Expression<int>? splashScreen,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (version != null) 'version': version,
      if (variant != null) 'variant': variant,
      if (reference != null) 'reference': reference,
      if (referenceUrl != null) 'reference_url': referenceUrl,
      if (sha != null) 'sha': sha,
      if (shaUrl != null) 'sha_url': shaUrl,
      if (date != null) 'date': date,
      if (architecture != null) 'architecture': architecture,
      if (downloadUrl != null) 'download_url': downloadUrl,
      if (installed != null) 'installed': installed,
      if (installationPath != null) 'installation_path': installationPath,
      if (splashScreen != null) 'splash_screen': splashScreen,
    });
  }

  BlenderVersionsCompanion copyWith(
      {Value<int?>? id,
      Value<DateTime?>? createdAt,
      Value<String>? title,
      Value<String>? description,
      Value<String>? version,
      Value<String>? variant,
      Value<String>? reference,
      Value<String>? referenceUrl,
      Value<String>? sha,
      Value<String>? shaUrl,
      Value<String>? date,
      Value<String>? architecture,
      Value<String>? downloadUrl,
      Value<bool>? installed,
      Value<String?>? installationPath,
      Value<int?>? splashScreen}) {
    return BlenderVersionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      description: description ?? this.description,
      version: version ?? this.version,
      variant: variant ?? this.variant,
      reference: reference ?? this.reference,
      referenceUrl: referenceUrl ?? this.referenceUrl,
      sha: sha ?? this.sha,
      shaUrl: shaUrl ?? this.shaUrl,
      date: date ?? this.date,
      architecture: architecture ?? this.architecture,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      installed: installed ?? this.installed,
      installationPath: installationPath ?? this.installationPath,
      splashScreen: splashScreen ?? this.splashScreen,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (variant.present) {
      map['variant'] = Variable<String>(variant.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (referenceUrl.present) {
      map['reference_url'] = Variable<String>(referenceUrl.value);
    }
    if (sha.present) {
      map['sha'] = Variable<String>(sha.value);
    }
    if (shaUrl.present) {
      map['sha_url'] = Variable<String>(shaUrl.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (architecture.present) {
      map['architecture'] = Variable<String>(architecture.value);
    }
    if (downloadUrl.present) {
      map['download_url'] = Variable<String>(downloadUrl.value);
    }
    if (installed.present) {
      map['installed'] = Variable<bool>(installed.value);
    }
    if (installationPath.present) {
      map['installation_path'] = Variable<String>(installationPath.value);
    }
    if (splashScreen.present) {
      map['splash_screen'] = Variable<int>(splashScreen.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlenderVersionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('version: $version, ')
          ..write('variant: $variant, ')
          ..write('reference: $reference, ')
          ..write('referenceUrl: $referenceUrl, ')
          ..write('sha: $sha, ')
          ..write('shaUrl: $shaUrl, ')
          ..write('date: $date, ')
          ..write('architecture: $architecture, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('installed: $installed, ')
          ..write('installationPath: $installationPath, ')
          ..write('splashScreen: $splashScreen')
          ..write(')'))
        .toString();
  }
}

class $BnextInfoTable extends BnextInfo
    with TableInfo<$BnextInfoTable, BnextInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BnextInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastRequestOnMeta =
      const VerificationMeta('lastRequestOn');
  @override
  late final GeneratedColumn<DateTime> lastRequestOn =
      GeneratedColumn<DateTime>('last_request_on', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, lastRequestOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bnext_info';
  @override
  VerificationContext validateIntegrity(Insertable<BnextInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_request_on')) {
      context.handle(
          _lastRequestOnMeta,
          lastRequestOn.isAcceptableOrUnknown(
              data['last_request_on']!, _lastRequestOnMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BnextInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BnextInfoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      lastRequestOn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_request_on']),
    );
  }

  @override
  $BnextInfoTable createAlias(String alias) {
    return $BnextInfoTable(attachedDatabase, alias);
  }
}

class BnextInfoData extends DataClass implements Insertable<BnextInfoData> {
  final int? id;
  final DateTime? createdAt;
  final DateTime? lastRequestOn;
  const BnextInfoData({this.id, this.createdAt, this.lastRequestOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || lastRequestOn != null) {
      map['last_request_on'] = Variable<DateTime>(lastRequestOn);
    }
    return map;
  }

  BnextInfoCompanion toCompanion(bool nullToAbsent) {
    return BnextInfoCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      lastRequestOn: lastRequestOn == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRequestOn),
    );
  }

  factory BnextInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BnextInfoData(
      id: serializer.fromJson<int?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      lastRequestOn: serializer.fromJson<DateTime?>(json['lastRequestOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'lastRequestOn': serializer.toJson<DateTime?>(lastRequestOn),
    };
  }

  BnextInfoData copyWith(
          {Value<int?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> lastRequestOn = const Value.absent()}) =>
      BnextInfoData(
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        lastRequestOn:
            lastRequestOn.present ? lastRequestOn.value : this.lastRequestOn,
      );
  BnextInfoData copyWithCompanion(BnextInfoCompanion data) {
    return BnextInfoData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastRequestOn: data.lastRequestOn.present
          ? data.lastRequestOn.value
          : this.lastRequestOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BnextInfoData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastRequestOn: $lastRequestOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, lastRequestOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BnextInfoData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.lastRequestOn == this.lastRequestOn);
}

class BnextInfoCompanion extends UpdateCompanion<BnextInfoData> {
  final Value<int?> id;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> lastRequestOn;
  const BnextInfoCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastRequestOn = const Value.absent(),
  });
  BnextInfoCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastRequestOn = const Value.absent(),
  });
  static Insertable<BnextInfoData> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastRequestOn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (lastRequestOn != null) 'last_request_on': lastRequestOn,
    });
  }

  BnextInfoCompanion copyWith(
      {Value<int?>? id,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? lastRequestOn}) {
    return BnextInfoCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      lastRequestOn: lastRequestOn ?? this.lastRequestOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastRequestOn.present) {
      map['last_request_on'] = Variable<DateTime>(lastRequestOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BnextInfoCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastRequestOn: $lastRequestOn')
          ..write(')'))
        .toString();
  }
}

class $BnexProjectsTable extends BnexProjects
    with TableInfo<$BnexProjectsTable, BnexProject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BnexProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => "value");
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
      'size', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _blenderVariantMeta =
      const VerificationMeta('blenderVariant');
  @override
  late final GeneratedColumn<String> blenderVariant = GeneratedColumn<String>(
      'blender_variant', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _blenderVersionMeta =
      const VerificationMeta('blenderVersion');
  @override
  late final GeneratedColumn<String> blenderVersion = GeneratedColumn<String>(
      'blender_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _templateMeta =
      const VerificationMeta('template');
  @override
  late final GeneratedColumn<String> template = GeneratedColumn<String>(
      'template', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usingVersionControlMeta =
      const VerificationMeta('usingVersionControl');
  @override
  late final GeneratedColumn<bool> usingVersionControl = GeneratedColumn<bool>(
      'using_version_control', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("using_version_control" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _clearExtentionsMeta =
      const VerificationMeta('clearExtentions');
  @override
  late final GeneratedColumn<bool> clearExtentions = GeneratedColumn<bool>(
      'clear_extentions', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("clear_extentions" IN (0, 1))'),
      clientDefault: () => false);
  static const VerificationMeta _dirMeta = const VerificationMeta('dir');
  @override
  late final GeneratedColumn<String> dir = GeneratedColumn<String>(
      'dir', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverMeta = const VerificationMeta('cover');
  @override
  late final GeneratedColumn<String> cover = GeneratedColumn<String>(
      'cover', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unlistedMeta =
      const VerificationMeta('unlisted');
  @override
  late final GeneratedColumn<bool> unlisted = GeneratedColumn<bool>(
      'unlisted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("unlisted" IN (0, 1))'),
      clientDefault: () => false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        name,
        description,
        size,
        tags,
        blenderVariant,
        blenderVersion,
        template,
        usingVersionControl,
        clearExtentions,
        dir,
        cover,
        unlisted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bnex_projects';
  @override
  VerificationContext validateIntegrity(Insertable<BnexProject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('blender_variant')) {
      context.handle(
          _blenderVariantMeta,
          blenderVariant.isAcceptableOrUnknown(
              data['blender_variant']!, _blenderVariantMeta));
    } else if (isInserting) {
      context.missing(_blenderVariantMeta);
    }
    if (data.containsKey('blender_version')) {
      context.handle(
          _blenderVersionMeta,
          blenderVersion.isAcceptableOrUnknown(
              data['blender_version']!, _blenderVersionMeta));
    } else if (isInserting) {
      context.missing(_blenderVersionMeta);
    }
    if (data.containsKey('template')) {
      context.handle(_templateMeta,
          template.isAcceptableOrUnknown(data['template']!, _templateMeta));
    } else if (isInserting) {
      context.missing(_templateMeta);
    }
    if (data.containsKey('using_version_control')) {
      context.handle(
          _usingVersionControlMeta,
          usingVersionControl.isAcceptableOrUnknown(
              data['using_version_control']!, _usingVersionControlMeta));
    }
    if (data.containsKey('clear_extentions')) {
      context.handle(
          _clearExtentionsMeta,
          clearExtentions.isAcceptableOrUnknown(
              data['clear_extentions']!, _clearExtentionsMeta));
    }
    if (data.containsKey('dir')) {
      context.handle(
          _dirMeta, dir.isAcceptableOrUnknown(data['dir']!, _dirMeta));
    } else if (isInserting) {
      context.missing(_dirMeta);
    }
    if (data.containsKey('cover')) {
      context.handle(
          _coverMeta, cover.isAcceptableOrUnknown(data['cover']!, _coverMeta));
    }
    if (data.containsKey('unlisted')) {
      context.handle(_unlistedMeta,
          unlisted.isAcceptableOrUnknown(data['unlisted']!, _unlistedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BnexProject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BnexProject(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}size']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      blenderVariant: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}blender_variant'])!,
      blenderVersion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}blender_version'])!,
      template: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}template'])!,
      usingVersionControl: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}using_version_control'])!,
      clearExtentions: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}clear_extentions'])!,
      dir: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dir'])!,
      cover: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover']),
      unlisted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unlisted'])!,
    );
  }

  @override
  $BnexProjectsTable createAlias(String alias) {
    return $BnexProjectsTable(attachedDatabase, alias);
  }
}

class BnexProject extends DataClass implements Insertable<BnexProject> {
  final int? id;
  final DateTime? createdAt;
  final String name;
  final String? description;
  final String? size;
  final String? tags;
  final String blenderVariant;
  final String blenderVersion;
  final String template;
  final bool usingVersionControl;
  final bool clearExtentions;
  final String dir;
  final String? cover;
  final bool unlisted;
  const BnexProject(
      {this.id,
      this.createdAt,
      required this.name,
      this.description,
      this.size,
      this.tags,
      required this.blenderVariant,
      required this.blenderVersion,
      required this.template,
      required this.usingVersionControl,
      required this.clearExtentions,
      required this.dir,
      this.cover,
      required this.unlisted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['blender_variant'] = Variable<String>(blenderVariant);
    map['blender_version'] = Variable<String>(blenderVersion);
    map['template'] = Variable<String>(template);
    map['using_version_control'] = Variable<bool>(usingVersionControl);
    map['clear_extentions'] = Variable<bool>(clearExtentions);
    map['dir'] = Variable<String>(dir);
    if (!nullToAbsent || cover != null) {
      map['cover'] = Variable<String>(cover);
    }
    map['unlisted'] = Variable<bool>(unlisted);
    return map;
  }

  BnexProjectsCompanion toCompanion(bool nullToAbsent) {
    return BnexProjectsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      blenderVariant: Value(blenderVariant),
      blenderVersion: Value(blenderVersion),
      template: Value(template),
      usingVersionControl: Value(usingVersionControl),
      clearExtentions: Value(clearExtentions),
      dir: Value(dir),
      cover:
          cover == null && nullToAbsent ? const Value.absent() : Value(cover),
      unlisted: Value(unlisted),
    );
  }

  factory BnexProject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BnexProject(
      id: serializer.fromJson<int?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      size: serializer.fromJson<String?>(json['size']),
      tags: serializer.fromJson<String?>(json['tags']),
      blenderVariant: serializer.fromJson<String>(json['blenderVariant']),
      blenderVersion: serializer.fromJson<String>(json['blenderVersion']),
      template: serializer.fromJson<String>(json['template']),
      usingVersionControl:
          serializer.fromJson<bool>(json['usingVersionControl']),
      clearExtentions: serializer.fromJson<bool>(json['clearExtentions']),
      dir: serializer.fromJson<String>(json['dir']),
      cover: serializer.fromJson<String?>(json['cover']),
      unlisted: serializer.fromJson<bool>(json['unlisted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'size': serializer.toJson<String?>(size),
      'tags': serializer.toJson<String?>(tags),
      'blenderVariant': serializer.toJson<String>(blenderVariant),
      'blenderVersion': serializer.toJson<String>(blenderVersion),
      'template': serializer.toJson<String>(template),
      'usingVersionControl': serializer.toJson<bool>(usingVersionControl),
      'clearExtentions': serializer.toJson<bool>(clearExtentions),
      'dir': serializer.toJson<String>(dir),
      'cover': serializer.toJson<String?>(cover),
      'unlisted': serializer.toJson<bool>(unlisted),
    };
  }

  BnexProject copyWith(
          {Value<int?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> size = const Value.absent(),
          Value<String?> tags = const Value.absent(),
          String? blenderVariant,
          String? blenderVersion,
          String? template,
          bool? usingVersionControl,
          bool? clearExtentions,
          String? dir,
          Value<String?> cover = const Value.absent(),
          bool? unlisted}) =>
      BnexProject(
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        size: size.present ? size.value : this.size,
        tags: tags.present ? tags.value : this.tags,
        blenderVariant: blenderVariant ?? this.blenderVariant,
        blenderVersion: blenderVersion ?? this.blenderVersion,
        template: template ?? this.template,
        usingVersionControl: usingVersionControl ?? this.usingVersionControl,
        clearExtentions: clearExtentions ?? this.clearExtentions,
        dir: dir ?? this.dir,
        cover: cover.present ? cover.value : this.cover,
        unlisted: unlisted ?? this.unlisted,
      );
  BnexProject copyWithCompanion(BnexProjectsCompanion data) {
    return BnexProject(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      size: data.size.present ? data.size.value : this.size,
      tags: data.tags.present ? data.tags.value : this.tags,
      blenderVariant: data.blenderVariant.present
          ? data.blenderVariant.value
          : this.blenderVariant,
      blenderVersion: data.blenderVersion.present
          ? data.blenderVersion.value
          : this.blenderVersion,
      template: data.template.present ? data.template.value : this.template,
      usingVersionControl: data.usingVersionControl.present
          ? data.usingVersionControl.value
          : this.usingVersionControl,
      clearExtentions: data.clearExtentions.present
          ? data.clearExtentions.value
          : this.clearExtentions,
      dir: data.dir.present ? data.dir.value : this.dir,
      cover: data.cover.present ? data.cover.value : this.cover,
      unlisted: data.unlisted.present ? data.unlisted.value : this.unlisted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BnexProject(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('size: $size, ')
          ..write('tags: $tags, ')
          ..write('blenderVariant: $blenderVariant, ')
          ..write('blenderVersion: $blenderVersion, ')
          ..write('template: $template, ')
          ..write('usingVersionControl: $usingVersionControl, ')
          ..write('clearExtentions: $clearExtentions, ')
          ..write('dir: $dir, ')
          ..write('cover: $cover, ')
          ..write('unlisted: $unlisted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      name,
      description,
      size,
      tags,
      blenderVariant,
      blenderVersion,
      template,
      usingVersionControl,
      clearExtentions,
      dir,
      cover,
      unlisted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BnexProject &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.name == this.name &&
          other.description == this.description &&
          other.size == this.size &&
          other.tags == this.tags &&
          other.blenderVariant == this.blenderVariant &&
          other.blenderVersion == this.blenderVersion &&
          other.template == this.template &&
          other.usingVersionControl == this.usingVersionControl &&
          other.clearExtentions == this.clearExtentions &&
          other.dir == this.dir &&
          other.cover == this.cover &&
          other.unlisted == this.unlisted);
}

class BnexProjectsCompanion extends UpdateCompanion<BnexProject> {
  final Value<int?> id;
  final Value<DateTime?> createdAt;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> size;
  final Value<String?> tags;
  final Value<String> blenderVariant;
  final Value<String> blenderVersion;
  final Value<String> template;
  final Value<bool> usingVersionControl;
  final Value<bool> clearExtentions;
  final Value<String> dir;
  final Value<String?> cover;
  final Value<bool> unlisted;
  const BnexProjectsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.size = const Value.absent(),
    this.tags = const Value.absent(),
    this.blenderVariant = const Value.absent(),
    this.blenderVersion = const Value.absent(),
    this.template = const Value.absent(),
    this.usingVersionControl = const Value.absent(),
    this.clearExtentions = const Value.absent(),
    this.dir = const Value.absent(),
    this.cover = const Value.absent(),
    this.unlisted = const Value.absent(),
  });
  BnexProjectsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.size = const Value.absent(),
    this.tags = const Value.absent(),
    required String blenderVariant,
    required String blenderVersion,
    required String template,
    this.usingVersionControl = const Value.absent(),
    this.clearExtentions = const Value.absent(),
    required String dir,
    this.cover = const Value.absent(),
    this.unlisted = const Value.absent(),
  })  : blenderVariant = Value(blenderVariant),
        blenderVersion = Value(blenderVersion),
        template = Value(template),
        dir = Value(dir);
  static Insertable<BnexProject> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? size,
    Expression<String>? tags,
    Expression<String>? blenderVariant,
    Expression<String>? blenderVersion,
    Expression<String>? template,
    Expression<bool>? usingVersionControl,
    Expression<bool>? clearExtentions,
    Expression<String>? dir,
    Expression<String>? cover,
    Expression<bool>? unlisted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (size != null) 'size': size,
      if (tags != null) 'tags': tags,
      if (blenderVariant != null) 'blender_variant': blenderVariant,
      if (blenderVersion != null) 'blender_version': blenderVersion,
      if (template != null) 'template': template,
      if (usingVersionControl != null)
        'using_version_control': usingVersionControl,
      if (clearExtentions != null) 'clear_extentions': clearExtentions,
      if (dir != null) 'dir': dir,
      if (cover != null) 'cover': cover,
      if (unlisted != null) 'unlisted': unlisted,
    });
  }

  BnexProjectsCompanion copyWith(
      {Value<int?>? id,
      Value<DateTime?>? createdAt,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? size,
      Value<String?>? tags,
      Value<String>? blenderVariant,
      Value<String>? blenderVersion,
      Value<String>? template,
      Value<bool>? usingVersionControl,
      Value<bool>? clearExtentions,
      Value<String>? dir,
      Value<String?>? cover,
      Value<bool>? unlisted}) {
    return BnexProjectsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      description: description ?? this.description,
      size: size ?? this.size,
      tags: tags ?? this.tags,
      blenderVariant: blenderVariant ?? this.blenderVariant,
      blenderVersion: blenderVersion ?? this.blenderVersion,
      template: template ?? this.template,
      usingVersionControl: usingVersionControl ?? this.usingVersionControl,
      clearExtentions: clearExtentions ?? this.clearExtentions,
      dir: dir ?? this.dir,
      cover: cover ?? this.cover,
      unlisted: unlisted ?? this.unlisted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (blenderVariant.present) {
      map['blender_variant'] = Variable<String>(blenderVariant.value);
    }
    if (blenderVersion.present) {
      map['blender_version'] = Variable<String>(blenderVersion.value);
    }
    if (template.present) {
      map['template'] = Variable<String>(template.value);
    }
    if (usingVersionControl.present) {
      map['using_version_control'] = Variable<bool>(usingVersionControl.value);
    }
    if (clearExtentions.present) {
      map['clear_extentions'] = Variable<bool>(clearExtentions.value);
    }
    if (dir.present) {
      map['dir'] = Variable<String>(dir.value);
    }
    if (cover.present) {
      map['cover'] = Variable<String>(cover.value);
    }
    if (unlisted.present) {
      map['unlisted'] = Variable<bool>(unlisted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BnexProjectsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('size: $size, ')
          ..write('tags: $tags, ')
          ..write('blenderVariant: $blenderVariant, ')
          ..write('blenderVersion: $blenderVersion, ')
          ..write('template: $template, ')
          ..write('usingVersionControl: $usingVersionControl, ')
          ..write('clearExtentions: $clearExtentions, ')
          ..write('dir: $dir, ')
          ..write('cover: $cover, ')
          ..write('unlisted: $unlisted')
          ..write(')'))
        .toString();
  }
}

class $BnextExtensionsTable extends BnextExtensions
    with TableInfo<$BnextExtensionsTable, BnextExtension> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BnextExtensionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _schemaVersionMeta =
      const VerificationMeta('schemaVersion');
  @override
  late final GeneratedColumn<String> schemaVersion = GeneratedColumn<String>(
      'schema_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _extIdMeta = const VerificationMeta('extId');
  @override
  late final GeneratedColumn<String> extId = GeneratedColumn<String>(
      'ext_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taglineMeta =
      const VerificationMeta('tagline');
  @override
  late final GeneratedColumn<String> tagline = GeneratedColumn<String>(
      'tagline', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maintainerMeta =
      const VerificationMeta('maintainer');
  @override
  late final GeneratedColumn<String> maintainer = GeneratedColumn<String>(
      'maintainer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _blenderMinVersionMeta =
      const VerificationMeta('blenderMinVersion');
  @override
  late final GeneratedColumn<String> blenderMinVersion =
      GeneratedColumn<String>('blender_min_version', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _licenceMeta =
      const VerificationMeta('licence');
  @override
  late final GeneratedColumn<String> licence = GeneratedColumn<String>(
      'licence', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _websiteMeta =
      const VerificationMeta('website');
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
      'website', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _copyrightMeta =
      const VerificationMeta('copyright');
  @override
  late final GeneratedColumn<String> copyright = GeneratedColumn<String>(
      'copyright', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _permissionsMeta =
      const VerificationMeta('permissions');
  @override
  late final GeneratedColumn<String> permissions = GeneratedColumn<String>(
      'permissions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        schemaVersion,
        extId,
        name,
        version,
        tagline,
        maintainer,
        type,
        tags,
        blenderMinVersion,
        licence,
        website,
        copyright,
        permissions
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bnext_extensions';
  @override
  VerificationContext validateIntegrity(Insertable<BnextExtension> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('schema_version')) {
      context.handle(
          _schemaVersionMeta,
          schemaVersion.isAcceptableOrUnknown(
              data['schema_version']!, _schemaVersionMeta));
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('ext_id')) {
      context.handle(
          _extIdMeta, extId.isAcceptableOrUnknown(data['ext_id']!, _extIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('tagline')) {
      context.handle(_taglineMeta,
          tagline.isAcceptableOrUnknown(data['tagline']!, _taglineMeta));
    }
    if (data.containsKey('maintainer')) {
      context.handle(
          _maintainerMeta,
          maintainer.isAcceptableOrUnknown(
              data['maintainer']!, _maintainerMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('blender_min_version')) {
      context.handle(
          _blenderMinVersionMeta,
          blenderMinVersion.isAcceptableOrUnknown(
              data['blender_min_version']!, _blenderMinVersionMeta));
    } else if (isInserting) {
      context.missing(_blenderMinVersionMeta);
    }
    if (data.containsKey('licence')) {
      context.handle(_licenceMeta,
          licence.isAcceptableOrUnknown(data['licence']!, _licenceMeta));
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website']!, _websiteMeta));
    }
    if (data.containsKey('copyright')) {
      context.handle(_copyrightMeta,
          copyright.isAcceptableOrUnknown(data['copyright']!, _copyrightMeta));
    }
    if (data.containsKey('permissions')) {
      context.handle(
          _permissionsMeta,
          permissions.isAcceptableOrUnknown(
              data['permissions']!, _permissionsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BnextExtension map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BnextExtension(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      schemaVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}schema_version'])!,
      extId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ext_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
      tagline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tagline']),
      maintainer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}maintainer']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      blenderMinVersion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}blender_min_version'])!,
      licence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}licence']),
      website: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}website']),
      copyright: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}copyright']),
      permissions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}permissions']),
    );
  }

  @override
  $BnextExtensionsTable createAlias(String alias) {
    return $BnextExtensionsTable(attachedDatabase, alias);
  }
}

class BnextExtension extends DataClass implements Insertable<BnextExtension> {
  final int? id;
  final DateTime? createdAt;
  final String schemaVersion;
  final String? extId;
  final String? name;
  final String version;
  final String? tagline;
  final String? maintainer;
  final String? type;
  final String? tags;
  final String blenderMinVersion;
  final String? licence;
  final String? website;
  final String? copyright;
  final String? permissions;
  const BnextExtension(
      {this.id,
      this.createdAt,
      required this.schemaVersion,
      this.extId,
      this.name,
      required this.version,
      this.tagline,
      this.maintainer,
      this.type,
      this.tags,
      required this.blenderMinVersion,
      this.licence,
      this.website,
      this.copyright,
      this.permissions});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['schema_version'] = Variable<String>(schemaVersion);
    if (!nullToAbsent || extId != null) {
      map['ext_id'] = Variable<String>(extId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['version'] = Variable<String>(version);
    if (!nullToAbsent || tagline != null) {
      map['tagline'] = Variable<String>(tagline);
    }
    if (!nullToAbsent || maintainer != null) {
      map['maintainer'] = Variable<String>(maintainer);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['blender_min_version'] = Variable<String>(blenderMinVersion);
    if (!nullToAbsent || licence != null) {
      map['licence'] = Variable<String>(licence);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || copyright != null) {
      map['copyright'] = Variable<String>(copyright);
    }
    if (!nullToAbsent || permissions != null) {
      map['permissions'] = Variable<String>(permissions);
    }
    return map;
  }

  BnextExtensionsCompanion toCompanion(bool nullToAbsent) {
    return BnextExtensionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      schemaVersion: Value(schemaVersion),
      extId:
          extId == null && nullToAbsent ? const Value.absent() : Value(extId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      version: Value(version),
      tagline: tagline == null && nullToAbsent
          ? const Value.absent()
          : Value(tagline),
      maintainer: maintainer == null && nullToAbsent
          ? const Value.absent()
          : Value(maintainer),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      blenderMinVersion: Value(blenderMinVersion),
      licence: licence == null && nullToAbsent
          ? const Value.absent()
          : Value(licence),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      copyright: copyright == null && nullToAbsent
          ? const Value.absent()
          : Value(copyright),
      permissions: permissions == null && nullToAbsent
          ? const Value.absent()
          : Value(permissions),
    );
  }

  factory BnextExtension.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BnextExtension(
      id: serializer.fromJson<int?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      schemaVersion: serializer.fromJson<String>(json['schemaVersion']),
      extId: serializer.fromJson<String?>(json['extId']),
      name: serializer.fromJson<String?>(json['name']),
      version: serializer.fromJson<String>(json['version']),
      tagline: serializer.fromJson<String?>(json['tagline']),
      maintainer: serializer.fromJson<String?>(json['maintainer']),
      type: serializer.fromJson<String?>(json['type']),
      tags: serializer.fromJson<String?>(json['tags']),
      blenderMinVersion: serializer.fromJson<String>(json['blenderMinVersion']),
      licence: serializer.fromJson<String?>(json['licence']),
      website: serializer.fromJson<String?>(json['website']),
      copyright: serializer.fromJson<String?>(json['copyright']),
      permissions: serializer.fromJson<String?>(json['permissions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'schemaVersion': serializer.toJson<String>(schemaVersion),
      'extId': serializer.toJson<String?>(extId),
      'name': serializer.toJson<String?>(name),
      'version': serializer.toJson<String>(version),
      'tagline': serializer.toJson<String?>(tagline),
      'maintainer': serializer.toJson<String?>(maintainer),
      'type': serializer.toJson<String?>(type),
      'tags': serializer.toJson<String?>(tags),
      'blenderMinVersion': serializer.toJson<String>(blenderMinVersion),
      'licence': serializer.toJson<String?>(licence),
      'website': serializer.toJson<String?>(website),
      'copyright': serializer.toJson<String?>(copyright),
      'permissions': serializer.toJson<String?>(permissions),
    };
  }

  BnextExtension copyWith(
          {Value<int?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          String? schemaVersion,
          Value<String?> extId = const Value.absent(),
          Value<String?> name = const Value.absent(),
          String? version,
          Value<String?> tagline = const Value.absent(),
          Value<String?> maintainer = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<String?> tags = const Value.absent(),
          String? blenderMinVersion,
          Value<String?> licence = const Value.absent(),
          Value<String?> website = const Value.absent(),
          Value<String?> copyright = const Value.absent(),
          Value<String?> permissions = const Value.absent()}) =>
      BnextExtension(
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        schemaVersion: schemaVersion ?? this.schemaVersion,
        extId: extId.present ? extId.value : this.extId,
        name: name.present ? name.value : this.name,
        version: version ?? this.version,
        tagline: tagline.present ? tagline.value : this.tagline,
        maintainer: maintainer.present ? maintainer.value : this.maintainer,
        type: type.present ? type.value : this.type,
        tags: tags.present ? tags.value : this.tags,
        blenderMinVersion: blenderMinVersion ?? this.blenderMinVersion,
        licence: licence.present ? licence.value : this.licence,
        website: website.present ? website.value : this.website,
        copyright: copyright.present ? copyright.value : this.copyright,
        permissions: permissions.present ? permissions.value : this.permissions,
      );
  BnextExtension copyWithCompanion(BnextExtensionsCompanion data) {
    return BnextExtension(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      extId: data.extId.present ? data.extId.value : this.extId,
      name: data.name.present ? data.name.value : this.name,
      version: data.version.present ? data.version.value : this.version,
      tagline: data.tagline.present ? data.tagline.value : this.tagline,
      maintainer:
          data.maintainer.present ? data.maintainer.value : this.maintainer,
      type: data.type.present ? data.type.value : this.type,
      tags: data.tags.present ? data.tags.value : this.tags,
      blenderMinVersion: data.blenderMinVersion.present
          ? data.blenderMinVersion.value
          : this.blenderMinVersion,
      licence: data.licence.present ? data.licence.value : this.licence,
      website: data.website.present ? data.website.value : this.website,
      copyright: data.copyright.present ? data.copyright.value : this.copyright,
      permissions:
          data.permissions.present ? data.permissions.value : this.permissions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BnextExtension(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('extId: $extId, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('tagline: $tagline, ')
          ..write('maintainer: $maintainer, ')
          ..write('type: $type, ')
          ..write('tags: $tags, ')
          ..write('blenderMinVersion: $blenderMinVersion, ')
          ..write('licence: $licence, ')
          ..write('website: $website, ')
          ..write('copyright: $copyright, ')
          ..write('permissions: $permissions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      schemaVersion,
      extId,
      name,
      version,
      tagline,
      maintainer,
      type,
      tags,
      blenderMinVersion,
      licence,
      website,
      copyright,
      permissions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BnextExtension &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.schemaVersion == this.schemaVersion &&
          other.extId == this.extId &&
          other.name == this.name &&
          other.version == this.version &&
          other.tagline == this.tagline &&
          other.maintainer == this.maintainer &&
          other.type == this.type &&
          other.tags == this.tags &&
          other.blenderMinVersion == this.blenderMinVersion &&
          other.licence == this.licence &&
          other.website == this.website &&
          other.copyright == this.copyright &&
          other.permissions == this.permissions);
}

class BnextExtensionsCompanion extends UpdateCompanion<BnextExtension> {
  final Value<int?> id;
  final Value<DateTime?> createdAt;
  final Value<String> schemaVersion;
  final Value<String?> extId;
  final Value<String?> name;
  final Value<String> version;
  final Value<String?> tagline;
  final Value<String?> maintainer;
  final Value<String?> type;
  final Value<String?> tags;
  final Value<String> blenderMinVersion;
  final Value<String?> licence;
  final Value<String?> website;
  final Value<String?> copyright;
  final Value<String?> permissions;
  const BnextExtensionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.extId = const Value.absent(),
    this.name = const Value.absent(),
    this.version = const Value.absent(),
    this.tagline = const Value.absent(),
    this.maintainer = const Value.absent(),
    this.type = const Value.absent(),
    this.tags = const Value.absent(),
    this.blenderMinVersion = const Value.absent(),
    this.licence = const Value.absent(),
    this.website = const Value.absent(),
    this.copyright = const Value.absent(),
    this.permissions = const Value.absent(),
  });
  BnextExtensionsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String schemaVersion,
    this.extId = const Value.absent(),
    this.name = const Value.absent(),
    required String version,
    this.tagline = const Value.absent(),
    this.maintainer = const Value.absent(),
    this.type = const Value.absent(),
    this.tags = const Value.absent(),
    required String blenderMinVersion,
    this.licence = const Value.absent(),
    this.website = const Value.absent(),
    this.copyright = const Value.absent(),
    this.permissions = const Value.absent(),
  })  : schemaVersion = Value(schemaVersion),
        version = Value(version),
        blenderMinVersion = Value(blenderMinVersion);
  static Insertable<BnextExtension> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? schemaVersion,
    Expression<String>? extId,
    Expression<String>? name,
    Expression<String>? version,
    Expression<String>? tagline,
    Expression<String>? maintainer,
    Expression<String>? type,
    Expression<String>? tags,
    Expression<String>? blenderMinVersion,
    Expression<String>? licence,
    Expression<String>? website,
    Expression<String>? copyright,
    Expression<String>? permissions,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (extId != null) 'ext_id': extId,
      if (name != null) 'name': name,
      if (version != null) 'version': version,
      if (tagline != null) 'tagline': tagline,
      if (maintainer != null) 'maintainer': maintainer,
      if (type != null) 'type': type,
      if (tags != null) 'tags': tags,
      if (blenderMinVersion != null) 'blender_min_version': blenderMinVersion,
      if (licence != null) 'licence': licence,
      if (website != null) 'website': website,
      if (copyright != null) 'copyright': copyright,
      if (permissions != null) 'permissions': permissions,
    });
  }

  BnextExtensionsCompanion copyWith(
      {Value<int?>? id,
      Value<DateTime?>? createdAt,
      Value<String>? schemaVersion,
      Value<String?>? extId,
      Value<String?>? name,
      Value<String>? version,
      Value<String?>? tagline,
      Value<String?>? maintainer,
      Value<String?>? type,
      Value<String?>? tags,
      Value<String>? blenderMinVersion,
      Value<String?>? licence,
      Value<String?>? website,
      Value<String?>? copyright,
      Value<String?>? permissions}) {
    return BnextExtensionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      extId: extId ?? this.extId,
      name: name ?? this.name,
      version: version ?? this.version,
      tagline: tagline ?? this.tagline,
      maintainer: maintainer ?? this.maintainer,
      type: type ?? this.type,
      tags: tags ?? this.tags,
      blenderMinVersion: blenderMinVersion ?? this.blenderMinVersion,
      licence: licence ?? this.licence,
      website: website ?? this.website,
      copyright: copyright ?? this.copyright,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<String>(schemaVersion.value);
    }
    if (extId.present) {
      map['ext_id'] = Variable<String>(extId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (tagline.present) {
      map['tagline'] = Variable<String>(tagline.value);
    }
    if (maintainer.present) {
      map['maintainer'] = Variable<String>(maintainer.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (blenderMinVersion.present) {
      map['blender_min_version'] = Variable<String>(blenderMinVersion.value);
    }
    if (licence.present) {
      map['licence'] = Variable<String>(licence.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (copyright.present) {
      map['copyright'] = Variable<String>(copyright.value);
    }
    if (permissions.present) {
      map['permissions'] = Variable<String>(permissions.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BnextExtensionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('extId: $extId, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('tagline: $tagline, ')
          ..write('maintainer: $maintainer, ')
          ..write('type: $type, ')
          ..write('tags: $tags, ')
          ..write('blenderMinVersion: $blenderMinVersion, ')
          ..write('licence: $licence, ')
          ..write('website: $website, ')
          ..write('copyright: $copyright, ')
          ..write('permissions: $permissions')
          ..write(')'))
        .toString();
  }
}

class $BnextProjectExtensionsTable extends BnextProjectExtensions
    with TableInfo<$BnextProjectExtensionsTable, BnextProjectExtension> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BnextProjectExtensionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _projectMeta =
      const VerificationMeta('project');
  @override
  late final GeneratedColumn<int> project = GeneratedColumn<int>(
      'project', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bnex_projects (id)'));
  static const VerificationMeta _bnextExtensionMeta =
      const VerificationMeta('bnextExtension');
  @override
  late final GeneratedColumn<int> bnextExtension = GeneratedColumn<int>(
      'bnext_extension', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bnext_extensions (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, project, bnextExtension];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bnext_project_extensions';
  @override
  VerificationContext validateIntegrity(
      Insertable<BnextProjectExtension> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('project')) {
      context.handle(_projectMeta,
          project.isAcceptableOrUnknown(data['project']!, _projectMeta));
    } else if (isInserting) {
      context.missing(_projectMeta);
    }
    if (data.containsKey('bnext_extension')) {
      context.handle(
          _bnextExtensionMeta,
          bnextExtension.isAcceptableOrUnknown(
              data['bnext_extension']!, _bnextExtensionMeta));
    } else if (isInserting) {
      context.missing(_bnextExtensionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BnextProjectExtension map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BnextProjectExtension(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      project: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project'])!,
      bnextExtension: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bnext_extension'])!,
    );
  }

  @override
  $BnextProjectExtensionsTable createAlias(String alias) {
    return $BnextProjectExtensionsTable(attachedDatabase, alias);
  }
}

class BnextProjectExtension extends DataClass
    implements Insertable<BnextProjectExtension> {
  final int? id;
  final DateTime? createdAt;
  final int project;
  final int bnextExtension;
  const BnextProjectExtension(
      {this.id,
      this.createdAt,
      required this.project,
      required this.bnextExtension});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['project'] = Variable<int>(project);
    map['bnext_extension'] = Variable<int>(bnextExtension);
    return map;
  }

  BnextProjectExtensionsCompanion toCompanion(bool nullToAbsent) {
    return BnextProjectExtensionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      project: Value(project),
      bnextExtension: Value(bnextExtension),
    );
  }

  factory BnextProjectExtension.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BnextProjectExtension(
      id: serializer.fromJson<int?>(json['id']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      project: serializer.fromJson<int>(json['project']),
      bnextExtension: serializer.fromJson<int>(json['bnextExtension']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'project': serializer.toJson<int>(project),
      'bnextExtension': serializer.toJson<int>(bnextExtension),
    };
  }

  BnextProjectExtension copyWith(
          {Value<int?> id = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          int? project,
          int? bnextExtension}) =>
      BnextProjectExtension(
        id: id.present ? id.value : this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        project: project ?? this.project,
        bnextExtension: bnextExtension ?? this.bnextExtension,
      );
  BnextProjectExtension copyWithCompanion(
      BnextProjectExtensionsCompanion data) {
    return BnextProjectExtension(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      project: data.project.present ? data.project.value : this.project,
      bnextExtension: data.bnextExtension.present
          ? data.bnextExtension.value
          : this.bnextExtension,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BnextProjectExtension(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('project: $project, ')
          ..write('bnextExtension: $bnextExtension')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, project, bnextExtension);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BnextProjectExtension &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.project == this.project &&
          other.bnextExtension == this.bnextExtension);
}

class BnextProjectExtensionsCompanion
    extends UpdateCompanion<BnextProjectExtension> {
  final Value<int?> id;
  final Value<DateTime?> createdAt;
  final Value<int> project;
  final Value<int> bnextExtension;
  const BnextProjectExtensionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.project = const Value.absent(),
    this.bnextExtension = const Value.absent(),
  });
  BnextProjectExtensionsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required int project,
    required int bnextExtension,
  })  : project = Value(project),
        bnextExtension = Value(bnextExtension);
  static Insertable<BnextProjectExtension> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? project,
    Expression<int>? bnextExtension,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (project != null) 'project': project,
      if (bnextExtension != null) 'bnext_extension': bnextExtension,
    });
  }

  BnextProjectExtensionsCompanion copyWith(
      {Value<int?>? id,
      Value<DateTime?>? createdAt,
      Value<int>? project,
      Value<int>? bnextExtension}) {
    return BnextProjectExtensionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      project: project ?? this.project,
      bnextExtension: bnextExtension ?? this.bnextExtension,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (project.present) {
      map['project'] = Variable<int>(project.value);
    }
    if (bnextExtension.present) {
      map['bnext_extension'] = Variable<int>(bnextExtension.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BnextProjectExtensionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('project: $project, ')
          ..write('bnextExtension: $bnextExtension')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SplashScreensTable splashScreens = $SplashScreensTable(this);
  late final $BlenderVersionsTable blenderVersions =
      $BlenderVersionsTable(this);
  late final $BnextInfoTable bnextInfo = $BnextInfoTable(this);
  late final $BnexProjectsTable bnexProjects = $BnexProjectsTable(this);
  late final $BnextExtensionsTable bnextExtensions =
      $BnextExtensionsTable(this);
  late final $BnextProjectExtensionsTable bnextProjectExtensions =
      $BnextProjectExtensionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        splashScreens,
        blenderVersions,
        bnextInfo,
        bnexProjects,
        bnextExtensions,
        bnextProjectExtensions
      ];
}

typedef $$SplashScreensTableCreateCompanionBuilder = SplashScreensCompanion
    Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  required String title,
  required String imageUrl,
  required String projectUrl,
  required String author,
  required String authorUrl,
  required String license,
  Value<String?> size,
  required String blenderVersion,
});
typedef $$SplashScreensTableUpdateCompanionBuilder = SplashScreensCompanion
    Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  Value<String> title,
  Value<String> imageUrl,
  Value<String> projectUrl,
  Value<String> author,
  Value<String> authorUrl,
  Value<String> license,
  Value<String?> size,
  Value<String> blenderVersion,
});

final class $$SplashScreensTableReferences
    extends BaseReferences<_$AppDatabase, $SplashScreensTable, SplashScreen> {
  $$SplashScreensTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BlenderVersionsTable, List<BlenderVersion>>
      _blenderVersionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.blenderVersions,
              aliasName: $_aliasNameGenerator(
                  db.splashScreens.id, db.blenderVersions.splashScreen));

  $$BlenderVersionsTableProcessedTableManager get blenderVersionsRefs {
    final manager =
        $$BlenderVersionsTableTableManager($_db, $_db.blenderVersions)
            .filter((f) => f.splashScreen.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_blenderVersionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SplashScreensTableFilterComposer
    extends Composer<_$AppDatabase, $SplashScreensTable> {
  $$SplashScreensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get projectUrl => $composableBuilder(
      column: $table.projectUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorUrl => $composableBuilder(
      column: $table.authorUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get license => $composableBuilder(
      column: $table.license, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get blenderVersion => $composableBuilder(
      column: $table.blenderVersion,
      builder: (column) => ColumnFilters(column));

  Expression<bool> blenderVersionsRefs(
      Expression<bool> Function($$BlenderVersionsTableFilterComposer f) f) {
    final $$BlenderVersionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blenderVersions,
        getReferencedColumn: (t) => t.splashScreen,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlenderVersionsTableFilterComposer(
              $db: $db,
              $table: $db.blenderVersions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SplashScreensTableOrderingComposer
    extends Composer<_$AppDatabase, $SplashScreensTable> {
  $$SplashScreensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get projectUrl => $composableBuilder(
      column: $table.projectUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorUrl => $composableBuilder(
      column: $table.authorUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get license => $composableBuilder(
      column: $table.license, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blenderVersion => $composableBuilder(
      column: $table.blenderVersion,
      builder: (column) => ColumnOrderings(column));
}

class $$SplashScreensTableAnnotationComposer
    extends Composer<_$AppDatabase, $SplashScreensTable> {
  $$SplashScreensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get projectUrl => $composableBuilder(
      column: $table.projectUrl, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get authorUrl =>
      $composableBuilder(column: $table.authorUrl, builder: (column) => column);

  GeneratedColumn<String> get license =>
      $composableBuilder(column: $table.license, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get blenderVersion => $composableBuilder(
      column: $table.blenderVersion, builder: (column) => column);

  Expression<T> blenderVersionsRefs<T extends Object>(
      Expression<T> Function($$BlenderVersionsTableAnnotationComposer a) f) {
    final $$BlenderVersionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.blenderVersions,
        getReferencedColumn: (t) => t.splashScreen,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlenderVersionsTableAnnotationComposer(
              $db: $db,
              $table: $db.blenderVersions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SplashScreensTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SplashScreensTable,
    SplashScreen,
    $$SplashScreensTableFilterComposer,
    $$SplashScreensTableOrderingComposer,
    $$SplashScreensTableAnnotationComposer,
    $$SplashScreensTableCreateCompanionBuilder,
    $$SplashScreensTableUpdateCompanionBuilder,
    (SplashScreen, $$SplashScreensTableReferences),
    SplashScreen,
    PrefetchHooks Function({bool blenderVersionsRefs})> {
  $$SplashScreensTableTableManager(_$AppDatabase db, $SplashScreensTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SplashScreensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SplashScreensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SplashScreensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> imageUrl = const Value.absent(),
            Value<String> projectUrl = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String> authorUrl = const Value.absent(),
            Value<String> license = const Value.absent(),
            Value<String?> size = const Value.absent(),
            Value<String> blenderVersion = const Value.absent(),
          }) =>
              SplashScreensCompanion(
            id: id,
            createdAt: createdAt,
            title: title,
            imageUrl: imageUrl,
            projectUrl: projectUrl,
            author: author,
            authorUrl: authorUrl,
            license: license,
            size: size,
            blenderVersion: blenderVersion,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            required String title,
            required String imageUrl,
            required String projectUrl,
            required String author,
            required String authorUrl,
            required String license,
            Value<String?> size = const Value.absent(),
            required String blenderVersion,
          }) =>
              SplashScreensCompanion.insert(
            id: id,
            createdAt: createdAt,
            title: title,
            imageUrl: imageUrl,
            projectUrl: projectUrl,
            author: author,
            authorUrl: authorUrl,
            license: license,
            size: size,
            blenderVersion: blenderVersion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SplashScreensTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({blenderVersionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (blenderVersionsRefs) db.blenderVersions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blenderVersionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$SplashScreensTableReferences
                            ._blenderVersionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SplashScreensTableReferences(db, table, p0)
                                .blenderVersionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.splashScreen == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SplashScreensTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SplashScreensTable,
    SplashScreen,
    $$SplashScreensTableFilterComposer,
    $$SplashScreensTableOrderingComposer,
    $$SplashScreensTableAnnotationComposer,
    $$SplashScreensTableCreateCompanionBuilder,
    $$SplashScreensTableUpdateCompanionBuilder,
    (SplashScreen, $$SplashScreensTableReferences),
    SplashScreen,
    PrefetchHooks Function({bool blenderVersionsRefs})>;
typedef $$BlenderVersionsTableCreateCompanionBuilder = BlenderVersionsCompanion
    Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  required String title,
  required String description,
  required String version,
  required String variant,
  required String reference,
  required String referenceUrl,
  required String sha,
  required String shaUrl,
  required String date,
  required String architecture,
  required String downloadUrl,
  Value<bool> installed,
  Value<String?> installationPath,
  Value<int?> splashScreen,
});
typedef $$BlenderVersionsTableUpdateCompanionBuilder = BlenderVersionsCompanion
    Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  Value<String> title,
  Value<String> description,
  Value<String> version,
  Value<String> variant,
  Value<String> reference,
  Value<String> referenceUrl,
  Value<String> sha,
  Value<String> shaUrl,
  Value<String> date,
  Value<String> architecture,
  Value<String> downloadUrl,
  Value<bool> installed,
  Value<String?> installationPath,
  Value<int?> splashScreen,
});

final class $$BlenderVersionsTableReferences extends BaseReferences<
    _$AppDatabase, $BlenderVersionsTable, BlenderVersion> {
  $$BlenderVersionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SplashScreensTable _splashScreenTable(_$AppDatabase db) =>
      db.splashScreens.createAlias($_aliasNameGenerator(
          db.blenderVersions.splashScreen, db.splashScreens.id));

  $$SplashScreensTableProcessedTableManager? get splashScreen {
    if ($_item.splashScreen == null) return null;
    final manager = $$SplashScreensTableTableManager($_db, $_db.splashScreens)
        .filter((f) => f.id($_item.splashScreen!));
    final item = $_typedResult.readTableOrNull(_splashScreenTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BlenderVersionsTableFilterComposer
    extends Composer<_$AppDatabase, $BlenderVersionsTable> {
  $$BlenderVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get variant => $composableBuilder(
      column: $table.variant, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceUrl => $composableBuilder(
      column: $table.referenceUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sha => $composableBuilder(
      column: $table.sha, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shaUrl => $composableBuilder(
      column: $table.shaUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get architecture => $composableBuilder(
      column: $table.architecture, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get installed => $composableBuilder(
      column: $table.installed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get installationPath => $composableBuilder(
      column: $table.installationPath,
      builder: (column) => ColumnFilters(column));

  $$SplashScreensTableFilterComposer get splashScreen {
    final $$SplashScreensTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.splashScreen,
        referencedTable: $db.splashScreens,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SplashScreensTableFilterComposer(
              $db: $db,
              $table: $db.splashScreens,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlenderVersionsTableOrderingComposer
    extends Composer<_$AppDatabase, $BlenderVersionsTable> {
  $$BlenderVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variant => $composableBuilder(
      column: $table.variant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceUrl => $composableBuilder(
      column: $table.referenceUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sha => $composableBuilder(
      column: $table.sha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shaUrl => $composableBuilder(
      column: $table.shaUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get architecture => $composableBuilder(
      column: $table.architecture,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get installed => $composableBuilder(
      column: $table.installed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get installationPath => $composableBuilder(
      column: $table.installationPath,
      builder: (column) => ColumnOrderings(column));

  $$SplashScreensTableOrderingComposer get splashScreen {
    final $$SplashScreensTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.splashScreen,
        referencedTable: $db.splashScreens,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SplashScreensTableOrderingComposer(
              $db: $db,
              $table: $db.splashScreens,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlenderVersionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlenderVersionsTable> {
  $$BlenderVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get variant =>
      $composableBuilder(column: $table.variant, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get referenceUrl => $composableBuilder(
      column: $table.referenceUrl, builder: (column) => column);

  GeneratedColumn<String> get sha =>
      $composableBuilder(column: $table.sha, builder: (column) => column);

  GeneratedColumn<String> get shaUrl =>
      $composableBuilder(column: $table.shaUrl, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get architecture => $composableBuilder(
      column: $table.architecture, builder: (column) => column);

  GeneratedColumn<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => column);

  GeneratedColumn<bool> get installed =>
      $composableBuilder(column: $table.installed, builder: (column) => column);

  GeneratedColumn<String> get installationPath => $composableBuilder(
      column: $table.installationPath, builder: (column) => column);

  $$SplashScreensTableAnnotationComposer get splashScreen {
    final $$SplashScreensTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.splashScreen,
        referencedTable: $db.splashScreens,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SplashScreensTableAnnotationComposer(
              $db: $db,
              $table: $db.splashScreens,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlenderVersionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BlenderVersionsTable,
    BlenderVersion,
    $$BlenderVersionsTableFilterComposer,
    $$BlenderVersionsTableOrderingComposer,
    $$BlenderVersionsTableAnnotationComposer,
    $$BlenderVersionsTableCreateCompanionBuilder,
    $$BlenderVersionsTableUpdateCompanionBuilder,
    (BlenderVersion, $$BlenderVersionsTableReferences),
    BlenderVersion,
    PrefetchHooks Function({bool splashScreen})> {
  $$BlenderVersionsTableTableManager(
      _$AppDatabase db, $BlenderVersionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlenderVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlenderVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlenderVersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> version = const Value.absent(),
            Value<String> variant = const Value.absent(),
            Value<String> reference = const Value.absent(),
            Value<String> referenceUrl = const Value.absent(),
            Value<String> sha = const Value.absent(),
            Value<String> shaUrl = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> architecture = const Value.absent(),
            Value<String> downloadUrl = const Value.absent(),
            Value<bool> installed = const Value.absent(),
            Value<String?> installationPath = const Value.absent(),
            Value<int?> splashScreen = const Value.absent(),
          }) =>
              BlenderVersionsCompanion(
            id: id,
            createdAt: createdAt,
            title: title,
            description: description,
            version: version,
            variant: variant,
            reference: reference,
            referenceUrl: referenceUrl,
            sha: sha,
            shaUrl: shaUrl,
            date: date,
            architecture: architecture,
            downloadUrl: downloadUrl,
            installed: installed,
            installationPath: installationPath,
            splashScreen: splashScreen,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            required String title,
            required String description,
            required String version,
            required String variant,
            required String reference,
            required String referenceUrl,
            required String sha,
            required String shaUrl,
            required String date,
            required String architecture,
            required String downloadUrl,
            Value<bool> installed = const Value.absent(),
            Value<String?> installationPath = const Value.absent(),
            Value<int?> splashScreen = const Value.absent(),
          }) =>
              BlenderVersionsCompanion.insert(
            id: id,
            createdAt: createdAt,
            title: title,
            description: description,
            version: version,
            variant: variant,
            reference: reference,
            referenceUrl: referenceUrl,
            sha: sha,
            shaUrl: shaUrl,
            date: date,
            architecture: architecture,
            downloadUrl: downloadUrl,
            installed: installed,
            installationPath: installationPath,
            splashScreen: splashScreen,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BlenderVersionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({splashScreen = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (splashScreen) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.splashScreen,
                    referencedTable:
                        $$BlenderVersionsTableReferences._splashScreenTable(db),
                    referencedColumn: $$BlenderVersionsTableReferences
                        ._splashScreenTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BlenderVersionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BlenderVersionsTable,
    BlenderVersion,
    $$BlenderVersionsTableFilterComposer,
    $$BlenderVersionsTableOrderingComposer,
    $$BlenderVersionsTableAnnotationComposer,
    $$BlenderVersionsTableCreateCompanionBuilder,
    $$BlenderVersionsTableUpdateCompanionBuilder,
    (BlenderVersion, $$BlenderVersionsTableReferences),
    BlenderVersion,
    PrefetchHooks Function({bool splashScreen})>;
typedef $$BnextInfoTableCreateCompanionBuilder = BnextInfoCompanion Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  Value<DateTime?> lastRequestOn,
});
typedef $$BnextInfoTableUpdateCompanionBuilder = BnextInfoCompanion Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  Value<DateTime?> lastRequestOn,
});

class $$BnextInfoTableFilterComposer
    extends Composer<_$AppDatabase, $BnextInfoTable> {
  $$BnextInfoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastRequestOn => $composableBuilder(
      column: $table.lastRequestOn, builder: (column) => ColumnFilters(column));
}

class $$BnextInfoTableOrderingComposer
    extends Composer<_$AppDatabase, $BnextInfoTable> {
  $$BnextInfoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastRequestOn => $composableBuilder(
      column: $table.lastRequestOn,
      builder: (column) => ColumnOrderings(column));
}

class $$BnextInfoTableAnnotationComposer
    extends Composer<_$AppDatabase, $BnextInfoTable> {
  $$BnextInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRequestOn => $composableBuilder(
      column: $table.lastRequestOn, builder: (column) => column);
}

class $$BnextInfoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BnextInfoTable,
    BnextInfoData,
    $$BnextInfoTableFilterComposer,
    $$BnextInfoTableOrderingComposer,
    $$BnextInfoTableAnnotationComposer,
    $$BnextInfoTableCreateCompanionBuilder,
    $$BnextInfoTableUpdateCompanionBuilder,
    (
      BnextInfoData,
      BaseReferences<_$AppDatabase, $BnextInfoTable, BnextInfoData>
    ),
    BnextInfoData,
    PrefetchHooks Function()> {
  $$BnextInfoTableTableManager(_$AppDatabase db, $BnextInfoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BnextInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BnextInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BnextInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> lastRequestOn = const Value.absent(),
          }) =>
              BnextInfoCompanion(
            id: id,
            createdAt: createdAt,
            lastRequestOn: lastRequestOn,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> lastRequestOn = const Value.absent(),
          }) =>
              BnextInfoCompanion.insert(
            id: id,
            createdAt: createdAt,
            lastRequestOn: lastRequestOn,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BnextInfoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BnextInfoTable,
    BnextInfoData,
    $$BnextInfoTableFilterComposer,
    $$BnextInfoTableOrderingComposer,
    $$BnextInfoTableAnnotationComposer,
    $$BnextInfoTableCreateCompanionBuilder,
    $$BnextInfoTableUpdateCompanionBuilder,
    (
      BnextInfoData,
      BaseReferences<_$AppDatabase, $BnextInfoTable, BnextInfoData>
    ),
    BnextInfoData,
    PrefetchHooks Function()>;
typedef $$BnexProjectsTableCreateCompanionBuilder = BnexProjectsCompanion
    Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  Value<String> name,
  Value<String?> description,
  Value<String?> size,
  Value<String?> tags,
  required String blenderVariant,
  required String blenderVersion,
  required String template,
  Value<bool> usingVersionControl,
  Value<bool> clearExtentions,
  required String dir,
  Value<String?> cover,
  Value<bool> unlisted,
});
typedef $$BnexProjectsTableUpdateCompanionBuilder = BnexProjectsCompanion
    Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  Value<String> name,
  Value<String?> description,
  Value<String?> size,
  Value<String?> tags,
  Value<String> blenderVariant,
  Value<String> blenderVersion,
  Value<String> template,
  Value<bool> usingVersionControl,
  Value<bool> clearExtentions,
  Value<String> dir,
  Value<String?> cover,
  Value<bool> unlisted,
});

final class $$BnexProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $BnexProjectsTable, BnexProject> {
  $$BnexProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BnextProjectExtensionsTable,
      List<BnextProjectExtension>> _bnextProjectExtensionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.bnextProjectExtensions,
          aliasName: $_aliasNameGenerator(
              db.bnexProjects.id, db.bnextProjectExtensions.project));

  $$BnextProjectExtensionsTableProcessedTableManager
      get bnextProjectExtensionsRefs {
    final manager = $$BnextProjectExtensionsTableTableManager(
            $_db, $_db.bnextProjectExtensions)
        .filter((f) => f.project.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_bnextProjectExtensionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BnexProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $BnexProjectsTable> {
  $$BnexProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get blenderVariant => $composableBuilder(
      column: $table.blenderVariant,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get blenderVersion => $composableBuilder(
      column: $table.blenderVersion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get template => $composableBuilder(
      column: $table.template, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get usingVersionControl => $composableBuilder(
      column: $table.usingVersionControl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get clearExtentions => $composableBuilder(
      column: $table.clearExtentions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dir => $composableBuilder(
      column: $table.dir, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cover => $composableBuilder(
      column: $table.cover, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get unlisted => $composableBuilder(
      column: $table.unlisted, builder: (column) => ColumnFilters(column));

  Expression<bool> bnextProjectExtensionsRefs(
      Expression<bool> Function($$BnextProjectExtensionsTableFilterComposer f)
          f) {
    final $$BnextProjectExtensionsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.bnextProjectExtensions,
            getReferencedColumn: (t) => t.project,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$BnextProjectExtensionsTableFilterComposer(
                  $db: $db,
                  $table: $db.bnextProjectExtensions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$BnexProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $BnexProjectsTable> {
  $$BnexProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blenderVariant => $composableBuilder(
      column: $table.blenderVariant,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blenderVersion => $composableBuilder(
      column: $table.blenderVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get template => $composableBuilder(
      column: $table.template, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get usingVersionControl => $composableBuilder(
      column: $table.usingVersionControl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get clearExtentions => $composableBuilder(
      column: $table.clearExtentions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dir => $composableBuilder(
      column: $table.dir, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cover => $composableBuilder(
      column: $table.cover, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get unlisted => $composableBuilder(
      column: $table.unlisted, builder: (column) => ColumnOrderings(column));
}

class $$BnexProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BnexProjectsTable> {
  $$BnexProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get blenderVariant => $composableBuilder(
      column: $table.blenderVariant, builder: (column) => column);

  GeneratedColumn<String> get blenderVersion => $composableBuilder(
      column: $table.blenderVersion, builder: (column) => column);

  GeneratedColumn<String> get template =>
      $composableBuilder(column: $table.template, builder: (column) => column);

  GeneratedColumn<bool> get usingVersionControl => $composableBuilder(
      column: $table.usingVersionControl, builder: (column) => column);

  GeneratedColumn<bool> get clearExtentions => $composableBuilder(
      column: $table.clearExtentions, builder: (column) => column);

  GeneratedColumn<String> get dir =>
      $composableBuilder(column: $table.dir, builder: (column) => column);

  GeneratedColumn<String> get cover =>
      $composableBuilder(column: $table.cover, builder: (column) => column);

  GeneratedColumn<bool> get unlisted =>
      $composableBuilder(column: $table.unlisted, builder: (column) => column);

  Expression<T> bnextProjectExtensionsRefs<T extends Object>(
      Expression<T> Function($$BnextProjectExtensionsTableAnnotationComposer a)
          f) {
    final $$BnextProjectExtensionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.bnextProjectExtensions,
            getReferencedColumn: (t) => t.project,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$BnextProjectExtensionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.bnextProjectExtensions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$BnexProjectsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BnexProjectsTable,
    BnexProject,
    $$BnexProjectsTableFilterComposer,
    $$BnexProjectsTableOrderingComposer,
    $$BnexProjectsTableAnnotationComposer,
    $$BnexProjectsTableCreateCompanionBuilder,
    $$BnexProjectsTableUpdateCompanionBuilder,
    (BnexProject, $$BnexProjectsTableReferences),
    BnexProject,
    PrefetchHooks Function({bool bnextProjectExtensionsRefs})> {
  $$BnexProjectsTableTableManager(_$AppDatabase db, $BnexProjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BnexProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BnexProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BnexProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> size = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<String> blenderVariant = const Value.absent(),
            Value<String> blenderVersion = const Value.absent(),
            Value<String> template = const Value.absent(),
            Value<bool> usingVersionControl = const Value.absent(),
            Value<bool> clearExtentions = const Value.absent(),
            Value<String> dir = const Value.absent(),
            Value<String?> cover = const Value.absent(),
            Value<bool> unlisted = const Value.absent(),
          }) =>
              BnexProjectsCompanion(
            id: id,
            createdAt: createdAt,
            name: name,
            description: description,
            size: size,
            tags: tags,
            blenderVariant: blenderVariant,
            blenderVersion: blenderVersion,
            template: template,
            usingVersionControl: usingVersionControl,
            clearExtentions: clearExtentions,
            dir: dir,
            cover: cover,
            unlisted: unlisted,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> size = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            required String blenderVariant,
            required String blenderVersion,
            required String template,
            Value<bool> usingVersionControl = const Value.absent(),
            Value<bool> clearExtentions = const Value.absent(),
            required String dir,
            Value<String?> cover = const Value.absent(),
            Value<bool> unlisted = const Value.absent(),
          }) =>
              BnexProjectsCompanion.insert(
            id: id,
            createdAt: createdAt,
            name: name,
            description: description,
            size: size,
            tags: tags,
            blenderVariant: blenderVariant,
            blenderVersion: blenderVersion,
            template: template,
            usingVersionControl: usingVersionControl,
            clearExtentions: clearExtentions,
            dir: dir,
            cover: cover,
            unlisted: unlisted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BnexProjectsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bnextProjectExtensionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bnextProjectExtensionsRefs) db.bnextProjectExtensions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bnextProjectExtensionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$BnexProjectsTableReferences
                            ._bnextProjectExtensionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BnexProjectsTableReferences(db, table, p0)
                                .bnextProjectExtensionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.project == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BnexProjectsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BnexProjectsTable,
    BnexProject,
    $$BnexProjectsTableFilterComposer,
    $$BnexProjectsTableOrderingComposer,
    $$BnexProjectsTableAnnotationComposer,
    $$BnexProjectsTableCreateCompanionBuilder,
    $$BnexProjectsTableUpdateCompanionBuilder,
    (BnexProject, $$BnexProjectsTableReferences),
    BnexProject,
    PrefetchHooks Function({bool bnextProjectExtensionsRefs})>;
typedef $$BnextExtensionsTableCreateCompanionBuilder = BnextExtensionsCompanion
    Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  required String schemaVersion,
  Value<String?> extId,
  Value<String?> name,
  required String version,
  Value<String?> tagline,
  Value<String?> maintainer,
  Value<String?> type,
  Value<String?> tags,
  required String blenderMinVersion,
  Value<String?> licence,
  Value<String?> website,
  Value<String?> copyright,
  Value<String?> permissions,
});
typedef $$BnextExtensionsTableUpdateCompanionBuilder = BnextExtensionsCompanion
    Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  Value<String> schemaVersion,
  Value<String?> extId,
  Value<String?> name,
  Value<String> version,
  Value<String?> tagline,
  Value<String?> maintainer,
  Value<String?> type,
  Value<String?> tags,
  Value<String> blenderMinVersion,
  Value<String?> licence,
  Value<String?> website,
  Value<String?> copyright,
  Value<String?> permissions,
});

final class $$BnextExtensionsTableReferences extends BaseReferences<
    _$AppDatabase, $BnextExtensionsTable, BnextExtension> {
  $$BnextExtensionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BnextProjectExtensionsTable,
      List<BnextProjectExtension>> _bnextProjectExtensionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.bnextProjectExtensions,
          aliasName: $_aliasNameGenerator(
              db.bnextExtensions.id, db.bnextProjectExtensions.bnextExtension));

  $$BnextProjectExtensionsTableProcessedTableManager
      get bnextProjectExtensionsRefs {
    final manager = $$BnextProjectExtensionsTableTableManager(
            $_db, $_db.bnextProjectExtensions)
        .filter((f) => f.bnextExtension.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_bnextProjectExtensionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BnextExtensionsTableFilterComposer
    extends Composer<_$AppDatabase, $BnextExtensionsTable> {
  $$BnextExtensionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extId => $composableBuilder(
      column: $table.extId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagline => $composableBuilder(
      column: $table.tagline, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get maintainer => $composableBuilder(
      column: $table.maintainer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get blenderMinVersion => $composableBuilder(
      column: $table.blenderMinVersion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get licence => $composableBuilder(
      column: $table.licence, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get copyright => $composableBuilder(
      column: $table.copyright, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get permissions => $composableBuilder(
      column: $table.permissions, builder: (column) => ColumnFilters(column));

  Expression<bool> bnextProjectExtensionsRefs(
      Expression<bool> Function($$BnextProjectExtensionsTableFilterComposer f)
          f) {
    final $$BnextProjectExtensionsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.bnextProjectExtensions,
            getReferencedColumn: (t) => t.bnextExtension,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$BnextProjectExtensionsTableFilterComposer(
                  $db: $db,
                  $table: $db.bnextProjectExtensions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$BnextExtensionsTableOrderingComposer
    extends Composer<_$AppDatabase, $BnextExtensionsTable> {
  $$BnextExtensionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extId => $composableBuilder(
      column: $table.extId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagline => $composableBuilder(
      column: $table.tagline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get maintainer => $composableBuilder(
      column: $table.maintainer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blenderMinVersion => $composableBuilder(
      column: $table.blenderMinVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get licence => $composableBuilder(
      column: $table.licence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get copyright => $composableBuilder(
      column: $table.copyright, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get permissions => $composableBuilder(
      column: $table.permissions, builder: (column) => ColumnOrderings(column));
}

class $$BnextExtensionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BnextExtensionsTable> {
  $$BnextExtensionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => column);

  GeneratedColumn<String> get extId =>
      $composableBuilder(column: $table.extId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get tagline =>
      $composableBuilder(column: $table.tagline, builder: (column) => column);

  GeneratedColumn<String> get maintainer => $composableBuilder(
      column: $table.maintainer, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get blenderMinVersion => $composableBuilder(
      column: $table.blenderMinVersion, builder: (column) => column);

  GeneratedColumn<String> get licence =>
      $composableBuilder(column: $table.licence, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get copyright =>
      $composableBuilder(column: $table.copyright, builder: (column) => column);

  GeneratedColumn<String> get permissions => $composableBuilder(
      column: $table.permissions, builder: (column) => column);

  Expression<T> bnextProjectExtensionsRefs<T extends Object>(
      Expression<T> Function($$BnextProjectExtensionsTableAnnotationComposer a)
          f) {
    final $$BnextProjectExtensionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.bnextProjectExtensions,
            getReferencedColumn: (t) => t.bnextExtension,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$BnextProjectExtensionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.bnextProjectExtensions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$BnextExtensionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BnextExtensionsTable,
    BnextExtension,
    $$BnextExtensionsTableFilterComposer,
    $$BnextExtensionsTableOrderingComposer,
    $$BnextExtensionsTableAnnotationComposer,
    $$BnextExtensionsTableCreateCompanionBuilder,
    $$BnextExtensionsTableUpdateCompanionBuilder,
    (BnextExtension, $$BnextExtensionsTableReferences),
    BnextExtension,
    PrefetchHooks Function({bool bnextProjectExtensionsRefs})> {
  $$BnextExtensionsTableTableManager(
      _$AppDatabase db, $BnextExtensionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BnextExtensionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BnextExtensionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BnextExtensionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<String> schemaVersion = const Value.absent(),
            Value<String?> extId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> version = const Value.absent(),
            Value<String?> tagline = const Value.absent(),
            Value<String?> maintainer = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<String> blenderMinVersion = const Value.absent(),
            Value<String?> licence = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<String?> copyright = const Value.absent(),
            Value<String?> permissions = const Value.absent(),
          }) =>
              BnextExtensionsCompanion(
            id: id,
            createdAt: createdAt,
            schemaVersion: schemaVersion,
            extId: extId,
            name: name,
            version: version,
            tagline: tagline,
            maintainer: maintainer,
            type: type,
            tags: tags,
            blenderMinVersion: blenderMinVersion,
            licence: licence,
            website: website,
            copyright: copyright,
            permissions: permissions,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            required String schemaVersion,
            Value<String?> extId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required String version,
            Value<String?> tagline = const Value.absent(),
            Value<String?> maintainer = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            required String blenderMinVersion,
            Value<String?> licence = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<String?> copyright = const Value.absent(),
            Value<String?> permissions = const Value.absent(),
          }) =>
              BnextExtensionsCompanion.insert(
            id: id,
            createdAt: createdAt,
            schemaVersion: schemaVersion,
            extId: extId,
            name: name,
            version: version,
            tagline: tagline,
            maintainer: maintainer,
            type: type,
            tags: tags,
            blenderMinVersion: blenderMinVersion,
            licence: licence,
            website: website,
            copyright: copyright,
            permissions: permissions,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BnextExtensionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bnextProjectExtensionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bnextProjectExtensionsRefs) db.bnextProjectExtensions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bnextProjectExtensionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$BnextExtensionsTableReferences
                            ._bnextProjectExtensionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BnextExtensionsTableReferences(db, table, p0)
                                .bnextProjectExtensionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bnextExtension == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BnextExtensionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BnextExtensionsTable,
    BnextExtension,
    $$BnextExtensionsTableFilterComposer,
    $$BnextExtensionsTableOrderingComposer,
    $$BnextExtensionsTableAnnotationComposer,
    $$BnextExtensionsTableCreateCompanionBuilder,
    $$BnextExtensionsTableUpdateCompanionBuilder,
    (BnextExtension, $$BnextExtensionsTableReferences),
    BnextExtension,
    PrefetchHooks Function({bool bnextProjectExtensionsRefs})>;
typedef $$BnextProjectExtensionsTableCreateCompanionBuilder
    = BnextProjectExtensionsCompanion Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  required int project,
  required int bnextExtension,
});
typedef $$BnextProjectExtensionsTableUpdateCompanionBuilder
    = BnextProjectExtensionsCompanion Function({
  Value<int?> id,
  Value<DateTime?> createdAt,
  Value<int> project,
  Value<int> bnextExtension,
});

final class $$BnextProjectExtensionsTableReferences extends BaseReferences<
    _$AppDatabase, $BnextProjectExtensionsTable, BnextProjectExtension> {
  $$BnextProjectExtensionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BnexProjectsTable _projectTable(_$AppDatabase db) =>
      db.bnexProjects.createAlias($_aliasNameGenerator(
          db.bnextProjectExtensions.project, db.bnexProjects.id));

  $$BnexProjectsTableProcessedTableManager get project {
    final manager = $$BnexProjectsTableTableManager($_db, $_db.bnexProjects)
        .filter((f) => f.id($_item.project!));
    final item = $_typedResult.readTableOrNull(_projectTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BnextExtensionsTable _bnextExtensionTable(_$AppDatabase db) =>
      db.bnextExtensions.createAlias($_aliasNameGenerator(
          db.bnextProjectExtensions.bnextExtension, db.bnextExtensions.id));

  $$BnextExtensionsTableProcessedTableManager get bnextExtension {
    final manager =
        $$BnextExtensionsTableTableManager($_db, $_db.bnextExtensions)
            .filter((f) => f.id($_item.bnextExtension!));
    final item = $_typedResult.readTableOrNull(_bnextExtensionTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BnextProjectExtensionsTableFilterComposer
    extends Composer<_$AppDatabase, $BnextProjectExtensionsTable> {
  $$BnextProjectExtensionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$BnexProjectsTableFilterComposer get project {
    final $$BnexProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.project,
        referencedTable: $db.bnexProjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BnexProjectsTableFilterComposer(
              $db: $db,
              $table: $db.bnexProjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BnextExtensionsTableFilterComposer get bnextExtension {
    final $$BnextExtensionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bnextExtension,
        referencedTable: $db.bnextExtensions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BnextExtensionsTableFilterComposer(
              $db: $db,
              $table: $db.bnextExtensions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BnextProjectExtensionsTableOrderingComposer
    extends Composer<_$AppDatabase, $BnextProjectExtensionsTable> {
  $$BnextProjectExtensionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$BnexProjectsTableOrderingComposer get project {
    final $$BnexProjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.project,
        referencedTable: $db.bnexProjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BnexProjectsTableOrderingComposer(
              $db: $db,
              $table: $db.bnexProjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BnextExtensionsTableOrderingComposer get bnextExtension {
    final $$BnextExtensionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bnextExtension,
        referencedTable: $db.bnextExtensions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BnextExtensionsTableOrderingComposer(
              $db: $db,
              $table: $db.bnextExtensions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BnextProjectExtensionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BnextProjectExtensionsTable> {
  $$BnextProjectExtensionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BnexProjectsTableAnnotationComposer get project {
    final $$BnexProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.project,
        referencedTable: $db.bnexProjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BnexProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.bnexProjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BnextExtensionsTableAnnotationComposer get bnextExtension {
    final $$BnextExtensionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bnextExtension,
        referencedTable: $db.bnextExtensions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BnextExtensionsTableAnnotationComposer(
              $db: $db,
              $table: $db.bnextExtensions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BnextProjectExtensionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BnextProjectExtensionsTable,
    BnextProjectExtension,
    $$BnextProjectExtensionsTableFilterComposer,
    $$BnextProjectExtensionsTableOrderingComposer,
    $$BnextProjectExtensionsTableAnnotationComposer,
    $$BnextProjectExtensionsTableCreateCompanionBuilder,
    $$BnextProjectExtensionsTableUpdateCompanionBuilder,
    (BnextProjectExtension, $$BnextProjectExtensionsTableReferences),
    BnextProjectExtension,
    PrefetchHooks Function({bool project, bool bnextExtension})> {
  $$BnextProjectExtensionsTableTableManager(
      _$AppDatabase db, $BnextProjectExtensionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BnextProjectExtensionsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$BnextProjectExtensionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BnextProjectExtensionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int> project = const Value.absent(),
            Value<int> bnextExtension = const Value.absent(),
          }) =>
              BnextProjectExtensionsCompanion(
            id: id,
            createdAt: createdAt,
            project: project,
            bnextExtension: bnextExtension,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            required int project,
            required int bnextExtension,
          }) =>
              BnextProjectExtensionsCompanion.insert(
            id: id,
            createdAt: createdAt,
            project: project,
            bnextExtension: bnextExtension,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BnextProjectExtensionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({project = false, bnextExtension = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (project) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.project,
                    referencedTable: $$BnextProjectExtensionsTableReferences
                        ._projectTable(db),
                    referencedColumn: $$BnextProjectExtensionsTableReferences
                        ._projectTable(db)
                        .id,
                  ) as T;
                }
                if (bnextExtension) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bnextExtension,
                    referencedTable: $$BnextProjectExtensionsTableReferences
                        ._bnextExtensionTable(db),
                    referencedColumn: $$BnextProjectExtensionsTableReferences
                        ._bnextExtensionTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BnextProjectExtensionsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $BnextProjectExtensionsTable,
        BnextProjectExtension,
        $$BnextProjectExtensionsTableFilterComposer,
        $$BnextProjectExtensionsTableOrderingComposer,
        $$BnextProjectExtensionsTableAnnotationComposer,
        $$BnextProjectExtensionsTableCreateCompanionBuilder,
        $$BnextProjectExtensionsTableUpdateCompanionBuilder,
        (BnextProjectExtension, $$BnextProjectExtensionsTableReferences),
        BnextProjectExtension,
        PrefetchHooks Function({bool project, bool bnextExtension})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SplashScreensTableTableManager get splashScreens =>
      $$SplashScreensTableTableManager(_db, _db.splashScreens);
  $$BlenderVersionsTableTableManager get blenderVersions =>
      $$BlenderVersionsTableTableManager(_db, _db.blenderVersions);
  $$BnextInfoTableTableManager get bnextInfo =>
      $$BnextInfoTableTableManager(_db, _db.bnextInfo);
  $$BnexProjectsTableTableManager get bnexProjects =>
      $$BnexProjectsTableTableManager(_db, _db.bnexProjects);
  $$BnextExtensionsTableTableManager get bnextExtensions =>
      $$BnextExtensionsTableTableManager(_db, _db.bnextExtensions);
  $$BnextProjectExtensionsTableTableManager get bnextProjectExtensions =>
      $$BnextProjectExtensionsTableTableManager(
          _db, _db.bnextProjectExtensions);
}
