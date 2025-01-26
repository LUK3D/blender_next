import 'dart:convert';

import 'package:blender_next/components/bn_markdown_video_element_builder.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:blender_next/services/exntesions_service.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:signals/signals_flutter.dart';

import 'preferences_screen.dart';

class BlenderVersionDetail extends StatefulWidget {
  final Function onClose;
  final BlenderVersion bVersion;
  const BlenderVersionDetail(
      {super.key, required this.bVersion, required this.onClose});

  @override
  State<BlenderVersionDetail> createState() => _BlenderVersionDetailState();
}

class _BlenderVersionDetailState extends State<BlenderVersionDetail>
    with SignalsMixin, TickerProviderStateMixin {
  final blenderServices = useBlenderService();
  late final selectedTab = createSignal<int>(0);

  late TabController tabController = TabController(length: 2, vsync: this);
  List<BnextExtension> selectedExtensions = [];
  Map<String, BnextExtensionVersion> selectedVesions = {};
  List<BnextExtension> previewsExtensions = [];
  Map<String, BnextExtensionVersion> previewsSelectedVesions = {};
  final extenSionsService = useExntesionsService();
  bool insLoading = true;
  @override
  void initState() {
    super.initState();

    extenSionsService.db.database
        .getBlenderInstalledExtensionsWithVersions(widget.bVersion.version)
        .then((data) {
      previewsExtensions = data.map((e) => e.keys.first).toList();
      final versions = data.map((e) => e.values.first).toList();

      for (var version in versions) {
        final ext =
            previewsExtensions.where((ex) => ex.id == version.ext).first;
        previewsSelectedVesions[ext.extId!] = version;
      }

      selectedExtensions = previewsExtensions;
      selectedVesions = previewsSelectedVesions;

      setState(() {
        insLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final splashScreenshot =
        blenderServices.db.getSplashScreenById(widget.bVersion.splashScreen);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: (splashScreenshot != null) ? 800 : 300,
                  collapsedHeight: 10,
                  toolbarHeight: 10,
                  pinned: true,
                  floating: false,
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  surfaceTintColor: Theme.of(context).cardColor,
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        if (splashScreenshot != null)
                          Image.network(
                            splashScreenshot.imageUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Theme.of(context).scaffoldBackgroundColor,
                              // Colors.transparent,
                            ],
                          )),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "Blender ${widget.bVersion.version} \n${widget.bVersion.variant}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(widget.bVersion.date),
                            const SizedBox(
                              height: 20,
                            ),
                            if (splashScreenshot != null)
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(16),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.network(
                                      splashScreenshot.imageUrl,
                                    ),
                                  ),
                                  Text(
                                      "${splashScreenshot.author} - ${splashScreenshot.license}")
                                ],
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: Container(
                      width: double.infinity,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxWidth: 1200, minWidth: 400),
                          child: TabBar(
                              dividerColor: Colors.transparent,
                              controller: tabController,
                              onTap: (value) {
                                selectedTab.value = value;
                              },
                              tabs: const [
                                Tab(
                                  child: Row(
                                    children: [
                                      Icon(LucideIcons.blocks),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Preferences"),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    children: [
                                      Icon(LucideIcons.file_text),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Release notes"),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                selectedTab.value == 0
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: 1200,
                                  minHeight:
                                      MediaQuery.of(context).size.height),
                              child: BlenderPreferencesScreen(
                                selectedVesions: selectedVesions,
                                blenderVersion: widget.bVersion,
                                selectedExtensions: selectedExtensions,
                                onExtensionsChange: (extensions, versions) {
                                  selectedExtensions = extensions;
                                  selectedVesions = versions;
                                },
                                onRemove: (extensionIds) {
                                  selectedExtensions =
                                      selectedExtensions.where((e) {
                                    return extensionIds.contains(e.id);
                                  }).toList();

                                  Map<String, BnextExtensionVersion> newData =
                                      {};

                                  selectedVesions.forEach((key, value) {
                                    if (extensionIds.contains(value.ext)) {
                                      newData[key] = value;
                                    }
                                  });

                                  selectedVesions = newData;
                                  setState(() {});
                                },
                                onSaveExtensions: () {
                                  final extensionsToBeInstalled =
                                      selectedExtensions.map((ext) {
                                    return {ext: selectedVesions[ext.extId!]!};
                                  }).toList();

                                  final extensionsToUninstall =
                                      previewsSelectedVesions.values
                                          .where((pe) {
                                    bool check1 = !selectedExtensions
                                        .map((e) => e.id)
                                        .contains(pe.ext);

                                    final check2 = selectedExtensions
                                        .where((e) =>
                                            e.id == pe.ext &&
                                            (selectedVesions[e.extId]!
                                                    .version !=
                                                pe.version))
                                        .toList()
                                        .isNotEmpty;

                                    return check1 || check2;
                                  }).where((el) {
                                    return previewsExtensions
                                        .where((ex) => ex.id == el.ext)
                                        .isNotEmpty;
                                  }).map((e) {
                                    return {
                                      previewsExtensions
                                          .where((ex) => ex.id == e.ext)
                                          .first: e
                                    };
                                  }).toList();

                                  extenSionsService.addExtensionsToBlender(
                                    widget.bVersion,
                                    extensionsToBeInstalled,
                                    extensionsToUninstall,
                                    context: context,
                                    onError: (title, message) {
                                      ElegantNotification.error(
                                        verticalDividerColor:
                                            Theme.of(context).dividerColor,
                                        background:
                                            Theme.of(context).canvasColor,
                                        toastDuration:
                                            const Duration(seconds: 15),
                                        width: 460,
                                        title: Text(
                                          title,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        description: Text(
                                          message,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        position: Alignment.bottomRight,
                                      ).show(context);
                                    },
                                    onInfo: (title, message) {
                                      ElegantNotification.info(
                                        verticalDividerColor:
                                            Theme.of(context).dividerColor,
                                        background:
                                            Theme.of(context).canvasColor,
                                        toastDuration:
                                            const Duration(seconds: 15),
                                        width: 460,
                                        title: Text(
                                          title,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        description: Text(
                                          message,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        icon: const Icon(
                                          LucideIcons.info,
                                          color: Colors.blue,
                                        ),
                                        position: Alignment.bottomRight,
                                      ).show(context);
                                    },
                                    onSuccess: (title, message) {
                                      ElegantNotification.success(
                                        verticalDividerColor:
                                            Theme.of(context).dividerColor,
                                        background:
                                            Theme.of(context).canvasColor,
                                        toastDuration:
                                            const Duration(seconds: 15),
                                        width: 460,
                                        title: Text(
                                          title,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        description: Text(
                                          message,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        position: Alignment.bottomRight,
                                      ).show(context);
                                    },
                                    onDone: () {},
                                  );
                                },
                              )),
                        ),
                      )
                    : StreamBuilder(
                        stream: blenderServices.db.database
                            .getBlenderVersionStreamById(widget.bVersion),
                        builder: (context, snapshot) {
                          if (snapshot.data == null ||
                              (snapshot.data?.description.trim().isEmpty ??
                                  true)) {
                            return SliverToBoxAdapter(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: Text("Loading..."),
                                ),
                              ),
                            );
                          }

                          final data = List<Map<String, dynamic>>.from(
                              jsonDecode(snapshot.data!.description));

                          return Watch(
                            (ctx) => SliverList.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final e = data[index];
                                  return Center(
                                      child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 1200,
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          subtitle: Markdown(
                                            data: e['description'],
                                            shrinkWrap: true,
                                            builders: {
                                              'a': BnMarkdownVideoElementBuilder(
                                                  "https://developer.blender.org/docs/release_notes/${widget.bVersion.version.substring(0, 3)}/"), // Add the custom builder for video
                                            },
                                            imageBuilder: (uri, title, alt) {
                                              if (uri
                                                      .toString()
                                                      .split(".")
                                                      .last ==
                                                  "svg") {
                                                return const SizedBox();
                                              }
                                              final imageUrl =
                                                  "https://developer.blender.org/docs/release_notes/${widget.bVersion.version.substring(0, 3)}/${uri.toString().split("..").last.split('//').join('/')}";
                                              return Image.network(imageUrl);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                                }),
                          );
                        },
                      )
              ],
            ),
          ),
          Positioned(
              right: 16,
              top: 17,
              child: IconButton.filled(
                onPressed: () {
                  widget.onClose();
                },
                icon: const Icon(LucideIcons.x),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).canvasColor,
                ),
              ))
        ],
      ),
    );
  }
}
