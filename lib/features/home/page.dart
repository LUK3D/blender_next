import 'package:blender_next/components/bn_sidebar.dart';
import 'package:blender_next/features/home/screens/extensions/main_screen.dart';
import 'package:blender_next/features/home/screens/settings/settings_screen.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/data/local_db_access_layer.dart';
import 'package:blender_next/data/model/side_menu_item.dart';
import 'package:blender_next/features/home/screens/projects_screen.dart';
import 'package:blender_next/services/project_manager_service.dart';
import 'package:blender_next/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
import '../../components/bn_text_input.dart';
import 'screens/installers_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SignalsMixin, TickerProviderStateMixin, TrayListener {
  final blenderAccess = useBlenderService();
  final localDbAccess = useLocalDbAccessLayer();
  final settingsService = useSettingsService();
  late TabController tabController = TabController(length: 4, vsync: this);
  late final selectedMenuItem = createSignal(0);
  late final variantFilterValue = createSignal("");
  final projectsManagerServce = useProjectManagerService();
  final Map<String, dynamic> blenderDownloadsTracker = {};

  @override
  void initState() {
    trayManager.addListener(this);
    super.initState();
  }

  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'show_window') {
      windowManager.show();
    } else if (menuItem.key == 'exit_app') {
      windowManager.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Watch((context) {
        return BnSidebar<int>(
          selectedItem: settingsService.showSettings.value
              ? null
              : selectedMenuItem.value,
          onItemSelected: (index) {
            settingsService.toggleSettingsPage(value: false);
            selectedMenuItem.value = index;
            tabController.animateTo(index);
          },
          onSettingsClick: () {
            settingsService.toggleSettingsPage(value: true);
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
          child: settingsService.showSettings.value
              ? const SettingsScreen()
              : Column(
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BnTextInput(
                            icon: Icon(
                              LucideIcons.search,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            hintText: AppLocalizations.of(context)!.search,
                          ),
                          Expanded(
                              child: DragToMoveArea(
                            child: Container(),
                          )),
                          IconButton.filled(
                            onPressed: () {
                              windowManager.hide();
                            },
                            icon: const Icon(
                              LucideIcons.x,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context).cardColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          StreamBuilder<List<BnexProject>>(
                            stream: projectsManagerServce.getProjectsStream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              }

                              return ProjectsScreen(
                                projects: snapshot.data ?? [],
                                isLoading: (snapshot.connectionState ==
                                        ConnectionState.waiting) &&
                                    (snapshot.data ?? []).isEmpty,
                              );
                            },
                          ),
                          Watch.builder(
                              builder: (context) =>
                                  StreamBuilder<List<BlenderVersion>>(
                                    stream: localDbAccess.getLatestBuildsStream(
                                        varient: variantFilterValue.value),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'),
                                        );
                                      }
                                      final installers = snapshot.data ?? [];

                                      return Watch((context) => InstallersSreen(
                                            isLoading: (snapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) &&
                                                installers.isEmpty,
                                            filterValue:
                                                variantFilterValue.value,
                                            onFilterChange: (value) {
                                              variantFilterValue.value =
                                                  value ?? "";
                                            },
                                            installers: installers,
                                            blenderDownloadsTracker:
                                                blenderDownloadsTracker,
                                            onDownload: (blender) async {
                                              final progresssSignal =
                                                  signal(0.0);

                                              blenderDownloadsTracker[
                                                  "${blender.version}-${blender.variant}-${blender.architecture}"] = {
                                                "progress": progresssSignal,
                                                "url": blender.downloadUrl,
                                              };

                                              blenderAccess.installBlender(
                                                blender: blender,
                                                onProgress: (progress) {
                                                  progresssSignal.value =
                                                      progress;
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
                          const ExtensionsMainScreen(),
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
