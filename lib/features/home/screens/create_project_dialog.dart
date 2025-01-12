import 'package:blender_next/components/bn_select.dart';
import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:blender_next/components/bn_text_input.dart';
import 'package:blender_next/components/bn_toggle_button.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:blender_next/services/project_manager_service.dart';
import 'package:blender_next/services/settings_service.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProjectDialog extends StatefulWidget {
  const CreateProjectDialog({super.key});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog>
    with SignalsMixin {
  final blenderService = useBlenderService();
  late Signal<Map<String, dynamic>> project =
      createSignal({"dir": useSettingsService().getProjectsFolder()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: Icon(
          LucideIcons.box,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(AppLocalizations.of(context)!.newProject),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BnTextInput(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            icon: const Icon(LucideIcons.text_cursor_input),
                            hintText: AppLocalizations.of(context)!.projectName,
                            onChanged: (val) {
                              project.value = {...project.value, "name": val};
                            },
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 200,
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Image.asset(
                                        "assets/blender-logo-white.png",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FutureBuilder(
                                      future:
                                          blenderService.db.getLatestBuilds(),
                                      builder: (context, snapshot) {
                                        final builds = (snapshot.data ?? [])
                                            .where((b) =>
                                                b.installationPath
                                                    ?.isNotEmpty ??
                                                false)
                                            .toList();

                                        if (builds.isEmpty) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .noBlenderFound),
                                          );
                                        }

                                        if (project.value["blender_version"] ==
                                            null) {
                                          project.value = {
                                            ...project.value,
                                            "blender_version": builds.first
                                          };
                                        }

                                        return Watch((context) =>
                                            DropdownButton<BlenderVersion>(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              value: project
                                                  .value["blender_version"],
                                              underline: const SizedBox(),
                                              padding: const EdgeInsets.all(0),
                                              items: builds
                                                  .map((blender) =>
                                                      DropdownMenuItem(
                                                          value: blender,
                                                          child: Text(
                                                              "Blender Version: ${blender.version}-${blender.variant.split(" ").map((e) => e[0]).join("").toLowerCase()}")))
                                                  .toList(),
                                              onChanged: (val) {
                                                project.value = {
                                                  ...project.value,
                                                  "blender_version": val
                                                };
                                              },
                                            ));
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            final String? directoryPath =
                                await getDirectoryPath();
                            if (directoryPath == null) {
                              // Operation was canceled by the user.
                              return;
                            }
                            project.value = {
                              ...project.value,
                              "dir": directoryPath
                            };
                            useSettingsService()
                                .setProjectsFolder(directoryPath);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    margin: const EdgeInsets.only(right: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                        "${AppLocalizations.of(context)!.projectDir}:")),
                                Watch((ctx) =>
                                    Text(project.value["dir"] ?? "...")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(AppLocalizations.of(context)!.template),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        child: Watch(
                      (ctx) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: getTemplates(context)
                              .map((e) => BnToggleButton(
                                    icon: Icon(
                                      e.icon,
                                      size: 30,
                                    ),
                                    label: Text(
                                      e.label,
                                      style: TextStyle(
                                        color:
                                            project.value["template"] == e.label
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : null,
                                      ),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onClick: () {
                                      project.value = {
                                        ...project.value,
                                        "template": e.label,
                                      };
                                    },
                                    selected:
                                        project.value["template"] == e.label,
                                  ))
                              .toList()),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: Watch(
                            (ctx) => Checkbox(
                              value: project.value["using_version_control"] ??
                                  false,
                              onChanged: (val) {
                                project.value = {
                                  ...project.value,
                                  "using_version_control": val
                                };
                              },
                              side: BorderSide(
                                width: 3,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(AppLocalizations.of(context)!.useVersionControl)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: project.value["clear_extentions"] ?? false,
                            onChanged: (val) {
                              project.value = {
                                ...project.value,
                                "clear_extentions": val
                              };
                            },
                            side: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(AppLocalizations.of(context)!.clearExtensions)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        "${AppLocalizations.of(context)!.includeExtensions}: (${project.value['extensions']?.length ?? 0})"),
                    const SizedBox(
                      height: 10,
                    ),
                    BnSelect(
                      items: [
                        BnSelectItem(id: 1, name: "Cycles Render Engine"),
                        BnSelectItem(id: 2, name: "FBX format"),
                        BnSelectItem(id: 3, name: "glTF"),
                        BnSelectItem(id: 4, name: "Node wrangler"),
                        BnSelectItem(id: 5, name: "OCD"),
                        BnSelectItem(id: 6, name: "Rigify"),
                        BnSelectItem(id: 7, name: "Scalable Vector Graphic"),
                        BnSelectItem(id: 8, name: "UV Layout"),
                      ],
                      onChange: (ids) {
                        project.value = {...project.value, "extensions": ids};
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 130,
                  child: BnSidebarButton(
                    icon: const Icon(LucideIcons.plus),
                    label: AppLocalizations.of(context)!.create,
                    backgroundColor: Theme.of(context).primaryColor,
                    borderRadius: 100,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      useProjectManagerService().createProject(BnexProject(
                        name: project.value["name"],
                        blenderVersion:
                            project.value['blender_version'].version,
                        template: project.value['template'],
                        usingVersionControl:
                            project.value['using_version_control'],
                        clearExtentions: project.value['clear_extentions'],
                        dir: project.value["dir"],
                        unlisted: false,
                        blenderVariant:
                            project.value['blender_version'].variant,
                      ));
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Dialog showCreateProjectDialog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        const SizedBox(width: 700, height: 760, child: CreateProjectDialog()),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton.filled(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(LucideIcons.x),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).canvasColor,
            ),
          ),
        )
      ],
    ),
  );
}

List<BlenderNextTemplate> getTemplates(BuildContext context) {
  return [
    BlenderNextTemplate(
      label: AppLocalizations.of(context)!.modeling,
      icon: LucideIcons.box,
    ),
    BlenderNextTemplate(
      label: "3D - ${AppLocalizations.of(context)!.animation}",
      icon: LucideIcons.file_video,
    ),
    BlenderNextTemplate(
      label: "2D - ${AppLocalizations.of(context)!.animation}",
      icon: LucideIcons.file_video,
    ),
    BlenderNextTemplate(
      label: AppLocalizations.of(context)!.riging,
      icon: LucideIcons.bone,
    ),
    BlenderNextTemplate(
      label: AppLocalizations.of(context)!.texturing,
      icon: LucideIcons.brush,
    ),
  ];

  // List<Map<String, dynamic>> testData = [
  //   {"id": 1, "name": "Cycles Render Engine"},
  //   {"id": 2, "name": "FBX format"},
  //   {"id": 3, "name": "glTF"},
  //   {"id": 4, "name": "Node wrangler"},
  //   {"id": 5, "name": "OCD"},
  //   {"id": 6, "name": "Rigify"},
  //   {"id": 7, "name": "Scalable Vector Graphic"},
  //   {"id": 8, "name": "UV Layout"}
  // ];
}

class BlenderNextTemplate {
  final String label;
  final IconData icon;

  BlenderNextTemplate({required this.label, required this.icon});
}
