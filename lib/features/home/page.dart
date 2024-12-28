import 'package:blender_next/components/bn_sidebar.dart';
import 'package:blender_next/data/blender_data_access.dart';
import 'package:blender_next/data/model/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';

import '../../components/bn_text_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final blenderAccess = useBlenderDataAccess();
  late TabController tabController = TabController(length: 4, vsync: this);
  final selectedMenuItem = signal(0);
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
                    Center(
                      child: TextButton(
                          onPressed: () {
                            blenderAccess.getLatestBuilds();
                          },
                          child: const Text("Test service")),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.blenderPackages,
                      ),
                    ),
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
