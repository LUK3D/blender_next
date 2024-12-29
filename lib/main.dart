import 'package:blender_next/data/blender_access_layer.dart';
import 'package:blender_next/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:signals/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'features/home/page.dart';
import 'utils/theme_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SignalsObserver.instance = null; //Disable Signal logs
  await useSettingsService().init();
  await useBlenderDataAccess().initializeData();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
