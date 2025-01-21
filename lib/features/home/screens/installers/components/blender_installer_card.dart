import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/features/home/screens/blender_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlenderInstallerCard extends StatelessWidget {
  const BlenderInstallerCard({
    super.key,
    required this.splashScreen,
    required this.installer,
    required this.progressSignal,
    required this.onUninstall,
    required this.onDownload,
    required this.onClick,
  });

  final SplashScreen? splashScreen;
  final BlenderVersion installer;
  final FlutterSignal<double>? progressSignal;
  final Function(BlenderVersion blender) onUninstall;
  final Function(BlenderVersion blender) onDownload;
  final Function(BlenderVersion blender) onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          onClick(installer);
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Theme.of(context).canvasColor,
                ),
                child: (splashScreen?.imageUrl != null)
                    ? Hero(
                        tag: installer.title,
                        child: Image.network(
                          splashScreen!.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )
                    : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${installer.title} ${installer.version}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    installer.date,
                    style: const TextStyle(
                        // fontSize: 9,
                        ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    progressSignal != null && !installer.installed
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 200,
                                  child: Watch(
                                    (context) => LinearProgressIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      value: progressSignal?.value ?? 0.0,
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                              const SizedBox(width: 10),
                              Watch(
                                (context) => Text(
                                  "${((progressSignal?.value ?? 0) * 100).floor()}%",
                                ),
                              )
                            ],
                          )
                        : Text(installer.variant),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: BnSidebarButton(
                      label: installer.installed
                          ? AppLocalizations.of(context)!.uninstall
                          : AppLocalizations.of(context)!.install,
                      onPressed: () {
                        if (installer.installed) {
                          onUninstall(installer);
                          return;
                        }
                        onDownload(installer);
                      },
                      icon: Icon(
                        installer.installed
                            ? LucideIcons.package_x
                            : LucideIcons.cloud_download,
                      ),
                      backgroundColor: Theme.of(context).canvasColor,
                      foregroundColor: installer.installed
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).primaryColor,
                      borderRadius: 50,
                    ),
                  ),
                  IconButton.filled(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => blenderInforDialog(
                          ctx,
                          installer,
                          progressSignal,
                          onDownload,
                          onUninstall,
                          splashScreen,
                        ),
                      );
                    },
                    icon: const Icon(
                      LucideIcons.info,
                    ),
                    color: Theme.of(context).colorScheme.onSurface,
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Theme.of(context).canvasColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
