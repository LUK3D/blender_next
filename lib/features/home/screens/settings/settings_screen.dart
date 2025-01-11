import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

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
                tabs: const [
                  Tab(
                    icon: Icon(LucideIcons.settings),
                    child: Text("General"),
                  ),
                  Tab(
                    icon: Icon(LucideIcons.database),
                    child: Text("Local Storage"),
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
