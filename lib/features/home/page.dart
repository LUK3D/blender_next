import 'package:blender_next/components/bn_logo.dart';
import 'package:blender_next/components/bn_sidebar.dart';
import 'package:blender_next/data/model/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final selectedMenuItem = signal(0);
    return Scaffold(
      body: Watch((context) {
        return BnSidebar<int>(
          selectedItem: selectedMenuItem.value,
          onItemSelected: (index) {
            selectedMenuItem.value = index;
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
          child: const Center(
            child: BnLogo(
              type: BnLogoType.labeledColored,
              width: 200,
            ),
          ),
        );
      }),
    );
  }
}
