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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SplashScreensTable splashScreens = $SplashScreensTable(this);
  late final $BlenderVersionsTable blenderVersions =
      $BlenderVersionsTable(this);
  late final $BnextInfoTable bnextInfo = $BnextInfoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [splashScreens, blenderVersions, bnextInfo];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SplashScreensTableTableManager get splashScreens =>
      $$SplashScreensTableTableManager(_db, _db.splashScreens);
  $$BlenderVersionsTableTableManager get blenderVersions =>
      $$BlenderVersionsTableTableManager(_db, _db.blenderVersions);
  $$BnextInfoTableTableManager get bnextInfo =>
      $$BnextInfoTableTableManager(_db, _db.bnextInfo);
}
