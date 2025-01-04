import 'dart:io';

import 'package:blender_next/components/bn_confirmation_dialog.dart';
import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/services/project_manager_service.dart';
import 'package:blender_next/utils/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:signals/signals_flutter.dart';
import 'create_project_dialog.dart';

class ProjectsScreen extends StatefulWidget {
  final List<BnexProject> projects;
  const ProjectsScreen({
    super.key,
    required this.isLoading,
    required this.projects,
  });

  final bool isLoading;

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  File getFile(String filePath) {
    return File(filePath);
  }

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
                      LucideIcons.box,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.projectManager}(${widget.projects.length})",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 180,
                  child: BnSidebarButton(
                    label: "New Project",
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    borderRadius: 100,
                    icon: const Icon(LucideIcons.plus),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => showCreateProjectDialog(context),
                      );
                    },
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
                    itemCount: widget.projects.length,
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 20,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 5 / 5,
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      final project = widget.projects[index];
                      final cover = project.cover != null
                          ? getFile(project.cover!)
                          : null;
                      return Material(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            useProjectManagerService()
                                .runProject(project)
                                .then((res) {
                              setState(() {});
                            });
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
                                  child: (cover != null && cover.existsSync())
                                      ? Image.memory(
                                          cover.readAsBytesSync(),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      project.name,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Material(
                                        clipBehavior: Clip.antiAlias,
                                        color: Theme.of(context).canvasColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            onChanged: (value) {
                                              final checkedSignal =
                                                  signal(false);
                                              if (value == "delete") {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      showConfirmationDialog(
                                                          context,
                                                          height: 300,
                                                          title:
                                                              "Deleting Project",
                                                          message:
                                                              "You ara about to delete ${project.name}. Are you sure?",
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Watch(
                                                                  (ctx) =>
                                                                      Checkbox(
                                                                        value: checkedSignal
                                                                            .value,
                                                                        onChanged:
                                                                            (val) {
                                                                          checkedSignal.value =
                                                                              val ?? false;
                                                                          print(
                                                                              "Checked");
                                                                        },
                                                                      )),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              const Text(
                                                                "Delete all files from disk",
                                                              ),
                                                            ],
                                                          ), onConfirm: () {
                                                    useProjectManagerService()
                                                        .deleteProject(
                                                      project,
                                                      deleteAllFiles:
                                                          checkedSignal.value,
                                                    );
                                                  }),
                                                );
                                              }
                                            },
                                            customButton: Container(
                                              color:
                                                  Theme.of(context).cardColor,
                                              child: Icon(
                                                LucideIcons.ellipsis,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                            ),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: "edit",
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      LucideIcons.pen,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const Text("Edit"),
                                                  ],
                                                ),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: "delete",
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      LucideIcons.trash,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const Text("Delete"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              width: 160,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Theme.of(context)
                                                    .canvasColor,
                                              ),
                                              offset: const Offset(0, 8),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      project.description ?? "",
                                      style: const TextStyle(
                                          fontSize: 14, height: 1.1),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Divider(
                                    height: 1,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Size: ${project.size ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.calendar,
                                          size: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          getProjectDate(project.createdAt),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 1,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Text(
                                        "Blender ${project.blenderVersion}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
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
