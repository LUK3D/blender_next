import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/data/local_db_access_layer.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/blender_installer_card.dart';
import 'components/blender_version_details.dart';

class InstallersSreen extends StatefulWidget {
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
  State<InstallersSreen> createState() => _InstallersSreenState();
}

class _InstallersSreenState extends State<InstallersSreen> {
  final selectedBlenderVersion = signal<BlenderVersion?>(null);
  final localDbAccess = useLocalDbAccessLayer();
  @override
  Widget build(BuildContext context) {
    return Watch((ctx) => Scaffold(
          body: (selectedBlenderVersion.value != null)
              ? BlenderVersionDetail(
                  bVersion: selectedBlenderVersion.value!,
                )
              : Column(
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
                                "${AppLocalizations.of(context)!.blenderDownloadManager} (${widget.installers.length})",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Watch((context) {
                                return DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  value: widget.filterValue,
                                  underline: const SizedBox(),
                                  padding: const EdgeInsets.all(0),
                                  items: [
                                    DropdownMenuItem(
                                        value: "",
                                        child: Text(
                                            AppLocalizations.of(context)!.all)),
                                    DropdownMenuItem(
                                        value: "stable",
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .stable)),
                                    DropdownMenuItem(
                                        value: "release candidate",
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .releaseCandidate)),
                                    DropdownMenuItem(
                                      value: "alpha",
                                      child: Text(
                                          AppLocalizations.of(context)!.alpha),
                                    ),
                                    DropdownMenuItem(
                                      value: "beta",
                                      child: Text(
                                          AppLocalizations.of(context)!.beta),
                                    ),
                                    DropdownMenuItem(
                                      value: "installed",
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          Text(AppLocalizations.of(context)!
                                              .installed),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onChanged: widget.onFilterChange,
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
                      child: (widget.isLoading)
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
                              itemCount: widget.installers.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 5 / 5,
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                final installer = widget.installers[index];
                                final FlutterSignal<
                                    double>? progressSignal = widget
                                            .blenderDownloadsTracker[
                                        "${installer.version}-${installer.variant}-${installer.architecture}"]
                                    ?["progress"];

                                useBlenderService().isInstalled(installer);

                                final splashScreen =
                                    localDbAccess.getSplashScreenById(
                                        installer.splashScreen);
                                return BlenderInstallerCard(
                                  splashScreen: splashScreen,
                                  installer: installer,
                                  progressSignal: progressSignal,
                                  onUninstall: widget.onUninstall,
                                  onDownload: widget.onDownload,
                                  onClick: (blender) {
                                    selectedBlenderVersion.value = blender;
                                    useBlenderService()
                                        .getReleaseNotes(blender);
                                  },
                                );
                              }),
                    ),
                  ],
                ),
        ));
  }
}
