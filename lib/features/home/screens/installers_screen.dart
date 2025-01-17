import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/data/local_db_access_layer.dart';
import 'package:blender_next/features/home/screens/blender_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstallersSreen extends StatelessWidget {
  final List<BlenderVersion> installers;
  final Function(String? value) onFilterChange;
  final Function(BlenderVersion blender) onDownload;
  final Function(BlenderVersion blender) onUninstall;
  final String filterValue;
  final bool isLoading;
  final Map<String, dynamic> blenderDownloadsTracker;
  const InstallersSreen({
    super.key,
    required this.installers,
    required this.onFilterChange,
    required this.filterValue,
    this.isLoading = false,
    required this.onDownload,
    required this.onUninstall,
    required this.blenderDownloadsTracker,
  });

  @override
  Widget build(BuildContext context) {
    final localDbAccess = useLocalDbAccessLayer();
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.cloud_download,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.blenderDownloadManager} (${installers.length})",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 180,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Watch((context) {
                      return DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: filterValue,
                        underline: const SizedBox(),
                        padding: const EdgeInsets.all(0),
                        items: [
                          DropdownMenuItem(
                              value: "",
                              child: Text(AppLocalizations.of(context)!.all)),
                          DropdownMenuItem(
                              value: "stable",
                              child:
                                  Text(AppLocalizations.of(context)!.stable)),
                          DropdownMenuItem(
                              value: "release candidate",
                              child: Text(AppLocalizations.of(context)!
                                  .releaseCandidate)),
                          DropdownMenuItem(
                            value: "alpha",
                            child: Text(AppLocalizations.of(context)!.alpha),
                          ),
                          DropdownMenuItem(
                            value: "beta",
                            child: Text(AppLocalizations.of(context)!.beta),
                          ),
                          DropdownMenuItem(
                            value: "installed",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  color: Theme.of(context)
                                      .dividerColor
                                      .withOpacity(0.5),
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(AppLocalizations.of(context)!.installed),
                              ],
                            ),
                          ),
                        ],
                        onChanged: onFilterChange,
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).dividerColor,
          ),
          Expanded(
            child: (isLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 20,
                    ),
                    itemCount: installers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 5 / 5,
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      final installer = installers[index];
                      final FlutterSignal<
                          double>? progressSignal = blenderDownloadsTracker[
                              "${installer.version}-${installer.variant}-${installer.architecture}"]
                          ?["progress"];

                      final splashScreen = localDbAccess
                          .getSplashScreenById(installer.splashScreen);
                      return Material(
                        color: Theme.of(context).cardColor,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    progressSignal != null &&
                                            !installer.installed
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: 200,
                                                  child: Watch(
                                                    (context) =>
                                                        LinearProgressIndicator(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      value:
                                                          progressSignal.value,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .cardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  )),
                                              const SizedBox(width: 10),
                                              Watch(
                                                (context) => Text(
                                                  "${(progressSignal.value * 100).floor()}%",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 40,
                                    child: BnSidebarButton(
                                      label: installer.installed
                                          ? AppLocalizations.of(context)!
                                              .uninstall
                                          : AppLocalizations.of(context)!
                                              .install,
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
                                      backgroundColor:
                                          Theme.of(context).canvasColor,
                                      foregroundColor: installer.installed
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSurface
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
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    style: IconButton.styleFrom(
                                      padding: const EdgeInsets.all(10),
                                      backgroundColor:
                                          Theme.of(context).canvasColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
