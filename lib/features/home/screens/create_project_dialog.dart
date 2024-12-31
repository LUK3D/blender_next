import 'package:blender_next/components/bn_select.dart';
import 'package:blender_next/components/bn_text_input.dart';
import 'package:blender_next/components/bn_toggle_button.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';

class CreateProjectDialog extends StatefulWidget {
  const CreateProjectDialog({super.key});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog>
    with SignalsMixin {
  final blenderService = useBlenderService();
  late Signal<BlenderVersion?> blenderVersionSelectedValue = createSignal(null);

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
        title: const Text("New Project"),
      ),
      body: SingleChildScrollView(
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
                      hintText: "Project Name",
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 200,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
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
                                future: blenderService.db.getLatestBuilds(),
                                builder: (context, snapshot) {
                                  return Watch((context) =>
                                      DropdownButton<BlenderVersion>(
                                        borderRadius: BorderRadius.circular(10),
                                        value:
                                            blenderVersionSelectedValue.value ??
                                                snapshot.data?.firstOrNull,
                                        underline: const SizedBox(),
                                        padding: const EdgeInsets.all(0),
                                        items: (snapshot.data ?? [])
                                            .where((b) =>
                                                b.installationPath
                                                    ?.isNotEmpty ??
                                                false)
                                            .map((blender) => DropdownMenuItem(
                                                value: blender,
                                                child: Text(
                                                    "Blender Version: ${blender.version}")))
                                            .toList(),
                                        onChanged: (val) {
                                          blenderVersionSelectedValue.value =
                                              val;
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
              const Text("Template"),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BnToggleButton(
                      icon: const Icon(
                        LucideIcons.box,
                        size: 30,
                      ),
                      label: const Text("Modeling"),
                      color: Theme.of(context).primaryColor,
                      onClick: () {},
                      selected: false,
                    ),
                    BnToggleButton(
                      icon: const Icon(
                        LucideIcons.file_video,
                        size: 30,
                      ),
                      label: const Text("Animation"),
                      color: Theme.of(context).primaryColor,
                      onClick: () {},
                      selected: false,
                    ),
                    BnToggleButton(
                      icon: const Icon(
                        LucideIcons.paintbrush,
                        size: 30,
                      ),
                      label: const Text("Texturing"),
                      color: Theme.of(context).primaryColor,
                      onClick: () {},
                      selected: false,
                    ),
                    BnToggleButton(
                      icon: const Icon(
                        LucideIcons.bone,
                        size: 30,
                      ),
                      label: const Text("Riging"),
                      color: Theme.of(context).primaryColor,
                      onClick: () {},
                      selected: false,
                    ),
                    BnToggleButton(
                      icon: const Icon(
                        LucideIcons.pencil,
                        size: 30,
                      ),
                      label: const Text("2D Animation"),
                      color: Theme.of(context).primaryColor,
                      onClick: () {},
                      selected: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      value: false,
                      onChanged: (val) {},
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
                  const Text("Use version control")
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
                      value: true,
                      onChanged: (val) {},
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
                  const Text("Clear extensions")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Include Extensions:"),
              const SizedBox(
                height: 10,
              ),
              const BnSelect()
            ],
          ),
        ),
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
