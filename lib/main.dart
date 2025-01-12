import 'package:blender_next/services/blender_service.dart';
import 'package:blender_next/services/exntesions_service.dart';
import 'package:blender_next/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:media_kit/media_kit.dart';
import 'package:signals/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'features/home/page.dart';
import 'services/system_try_service.dart';
import 'utils/theme_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MediaKit.ensureInitialized();

  await SystemTrayService.init();

  SignalsObserver.instance = null; //Disable Signal logs
  await useSettingsService().init();
  //Initialize database and refresh blender versions
  await useBlenderService()
      .initializeData()
      .then((bac) => bac.getLatestBuilds());
  useExntesionsService().initializeData();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    minimumSize: Size(1200, 800),
    // maximumSize: Size(1200, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setResizable(false);
    // await windowManager.setMaximizable(false);
  });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsService = useSettingsService();
    return Watch((context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        home: const HomePage(),
        locale: Locale(settingsService.locale.value),
      );
    });
  }
}
