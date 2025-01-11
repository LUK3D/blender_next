import 'dart:io';

import 'package:flutter/material.dart' hide MenuItem;
import 'package:tray_manager/tray_manager.dart';

class SystemTrayService {
  static Menu menu = Menu(
    items: [
      MenuItem(
        key: 'show_window',
        label: 'Show Window',
      ),
      MenuItem.separator(),
      MenuItem(
        key: 'exit_app',
        label: 'Exit App',
      ),
    ],
  );

  static Future<void> init() async {
    print('${Directory.current.path}/resources/app_icon.ico');
    await trayManager.setIcon(
      Platform.isWindows
          ? '${Directory.current.path}/resources/app_icon.ico'
          : 'images/tray_icon.png',
    );

    await trayManager.setContextMenu(menu);
  }
}
