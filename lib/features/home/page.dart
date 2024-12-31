import 'package:blender_next/components/bn_sidebar.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/data/local_db_access_layer.dart';
import 'package:blender_next/data/model/side_menu_item.dart';
import 'package:blender_next/features/home/screens/projects_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';
import '../../components/bn_text_input.dart';
import 'screens/installers_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SignalsMixin, TickerProviderStateMixin {
  final blenderAccess = useBlenderService();
  final localDbAccess = useLocalDbAccessLayer();
  late TabController tabController = TabController(length: 4, vsync: this);
  late final selectedMenuItem = createSignal(0);
  late final variantFilterValue = createSignal("");
  final Map<String, dynamic> blenderDownloadsTracker = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Watch((context) {
        return BnSidebar<int>(
          selectedItem: selectedMenuItem.value,
          onItemSelected: (index) {
            selectedMenuItem.value = index;
            tabController.animateTo(index);
          },
          gap: 5,
          items: [
            SideMenuItem(
              id: 0,
              label: AppLocalizations.of(context)!.projectManager,
              icon: LucideIcons.box,
            ),
            SideMenuItem(
              id: 1,
              label: AppLocalizations.of(context)!.blenderPackages,
              icon: LucideIcons.cloud_download,
            ),
            SideMenuItem(
              id: 2,
              label: AppLocalizations.of(context)!.extensions,
              icon: LucideIcons.blocks,
            ),
            SideMenuItem(
              id: 3,
              label: AppLocalizations.of(context)!.workflows,
              icon: LucideIcons.workflow,
            ),
          ],
          child: Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BnTextInput(
                      icon: Icon(
                        LucideIcons.search,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      hintText: AppLocalizations.of(context)!.search,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    const ProjectsScreen(
                      isLoading: false,
                    ),

                    Watch.builder(
                        builder: (context) =>
                            StreamBuilder<List<BlenderVersion>>(
                              stream: localDbAccess.getLatestBuildsStream(
                                  varient: variantFilterValue.value),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                }
                                final installers = snapshot.data ?? [];

                                return Watch((context) => InstallersSreen(
                                      isLoading: (snapshot.connectionState ==
                                              ConnectionState.waiting) &&
                                          installers.isEmpty,
                                      filterValue: variantFilterValue.value,
                                      onFilterChange: (value) {
                                        variantFilterValue.value = value ?? "";
                                      },
                                      installers: installers,
                                      blenderDownloadsTracker:
                                          blenderDownloadsTracker,
                                      onDownload: (blender) async {
                                        final progresssSignal = signal(0.0);

                                        blenderDownloadsTracker[
                                            "${blender.version}-${blender.variant}-${blender.architecture}"] = {
                                          "progress": progresssSignal,
                                          "url": blender.downloadUrl,
                                        };

                                        blenderAccess.installBlender(
                                          blender: blender,
                                          onProgress: (progress) {
                                            progresssSignal.value = progress;
                                          },
                                          onDone: (file) {
                                            if (file != null) {
                                              setState(() {});
                                            }
                                          },
                                        );

                                        setState(() {});
                                      },
                                      onUninstall: (blender) async {
                                        await blenderAccess
                                            .unInstallBlender(blender);
                                        setState(() {});
                                      },
                                    ));
                              },
                            )),

                    // Watch.builder(
                    //     builder: (context) => FutureBuilder<List<Blender>>(
                    //           initialData: blenderAccess.registry.blenders,
                    //           future: blenderAccess.getLatestBuilds(
                    //               varient: variantFilterValue.value),
                    //           builder: (context, snapshot) {
                    //             if (snapshot.hasError) {
                    //               return Center(
                    //                 child: Text('Error: ${snapshot.error}'),
                    //               );
                    //             }
                    //             final installers = snapshot.data ?? [];

                    //             return Watch((context) => InstallersSreen(
                    //                   isLoading: (snapshot.connectionState ==
                    //                           ConnectionState.waiting) &&
                    //                       installers.isEmpty,
                    //                   filterValue: variantFilterValue.value,
                    //                   onFilterChange: (value) {
                    //                     variantFilterValue.value = value ?? "";
                    //                   },
                    //                   installers: installers,
                    //                   blenderDownloadsTracker:
                    //                       blenderDownloadsTracker,
                    //                   onDownload: (blender) async {
                    //                     final progresssSignal = signal(0.0);

                    //                     blenderDownloadsTracker[
                    //                         "${blender.version}-${blender.variant}-${blender.architecture}"] = {
                    //                       "progress": progresssSignal,
                    //                       "url": blender.downloadUrl,
                    //                     };

                    //                     blenderAccess.installBlender(
                    //                       blender: blender,
                    //                       onProgress: (progress) {
                    //                         progresssSignal.value = progress;
                    //                       },
                    //                       onDone: (file) {
                    //                         if (file != null) {
                    //                           setState(() {});
                    //                         }
                    //                       },
                    //                     );

                    //                     setState(() {});
                    //                   },
                    //                   onUninstall: (blender) async {
                    //                     await blenderAccess
                    //                         .unInstallBlender(blender);
                    //                     setState(() {});
                    //                   },
                    //                 ));
                    //           },
                    //         )),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.extensions,
                      ),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.workflows,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
