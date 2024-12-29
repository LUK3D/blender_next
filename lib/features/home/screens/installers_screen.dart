import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:blender_next/data/model/blender.dart';
import 'package:blender_next/features/home/screens/blender_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';

class InstallersSreen extends StatelessWidget {
  final List<Blender> installers;
  final Function(String? value) onFilterChange;
  final Function(Blender blender) onDownload;
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
    required this.blenderDownloadsTracker,
  });

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      "Blender Download Manager",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 180,
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
                      items: const [
                        DropdownMenuItem(value: "", child: Text("All")),
                        DropdownMenuItem(
                            value: "stable", child: Text("Stable")),
                        DropdownMenuItem(
                            value: "release candidate",
                            child: Text("Release Candidate")),
                        DropdownMenuItem(
                          value: "alpha",
                          child: Text("Alpha"),
                        ),
                        DropdownMenuItem(
                          value: "beta",
                          child: Text("Beta"),
                        ),
                      ],
                      onChanged: onFilterChange,
                    );
                  }),
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
                                child:
                                    (installer.splashscreen?.imageUrl != null)
                                        ? Hero(
                                            tag: installer.title,
                                            child: Image.network(
                                              installer.splashscreen!.imageUrl,
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
                                    blenderDownloadsTracker[
                                                "${installer.version}-${installer.variant}-${installer.architecture}"] !=
                                            null
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
                                                      value: blenderDownloadsTracker[
                                                                  "${installer.version}-${installer.variant}-${installer.architecture}"]
                                                              ["progress"]
                                                          .value,
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
                                                  "${(blenderDownloadsTracker["${installer.version}-${installer.variant}-${installer.architecture}"]["progress"].value * 100).floor()}%",
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
                                      label: "Install",
                                      onPressed: () {
                                        onDownload(installer);
                                      },
                                      icon: const Icon(
                                          LucideIcons.cloud_download),
                                      backgroundColor:
                                          Theme.of(context).canvasColor,
                                      foregroundColor:
                                          Theme.of(context).primaryColor,
                                      borderRadius: 50,
                                    ),
                                  ),
                                  IconButton.filled(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => blenderInforDialog(
                                              ctx, installer));
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
