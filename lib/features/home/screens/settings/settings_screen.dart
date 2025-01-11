import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'general_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor.withOpacity(0.5),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                color: Theme.of(context).cardColor,
              ),
              child: TabBar(
                dividerColor: Theme.of(context).dividerColor,
                tabs: [
                  Tab(
                    icon: const Icon(LucideIcons.settings),
                    child: Text(AppLocalizations.of(context)!.general),
                  ),
                  Tab(
                    icon: const Icon(LucideIcons.database),
                    child: Text(AppLocalizations.of(context)!.localStorage),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  GeneralSettings(),
                  SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
