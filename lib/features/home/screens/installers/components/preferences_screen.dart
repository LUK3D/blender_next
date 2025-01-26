import 'package:blender_next/components/bn_select.dart';
import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:signals/signals_flutter.dart';

// ignore: library_prefixes
import '../../settings/Components/bn_select.dart' as bnSelect;

class BlenderPreferencesScreen extends StatefulWidget {
  final BlenderVersion blenderVersion;
  final List<BnextExtension> selectedExtensions;
  final Map<String, BnextExtensionVersion> selectedVesions;
  final Function onSaveExtensions;
  final Function(List<BnextExtension> extensions,
      Map<String, BnextExtensionVersion> versions) onExtensionsChange;
  final Function(List<int> extensionIds) onRemove;
  const BlenderPreferencesScreen({
    super.key,
    required this.blenderVersion,
    required this.onExtensionsChange,
    required this.selectedExtensions,
    required this.selectedVesions,
    required this.onSaveExtensions,
    required this.onRemove,
  });

  @override
  State<BlenderPreferencesScreen> createState() =>
      _BlenderPreferencesScreenState();
}

class _BlenderPreferencesScreenState extends State<BlenderPreferencesScreen>
    with SignalsMixin {
  final blenderService = useBlenderService();
  late var selectedVesions =
      createSignal<Map<String, BnextExtensionVersion>>(widget.selectedVesions);

  List<BnSelectItem> makeItems(List<BnextExtension> selectedExtensions) {
    return selectedExtensions.map((e) {
      return BnSelectItem(
          id: e.id!,
          name: "",
          searchTerms: "${e.name} ${e.tags}",
          nameWidget: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 200, child: Text(e.name!)),
                FutureBuilder(
                    future: blenderService.db.database
                        .getExtensionVersionByExtensionId(e.id!),
                    builder: (ctx, snapshot) {
                      final data = snapshot.data ?? [];

                      if (data.isEmpty) {
                        return const SizedBox();
                      }
                      if (widget.selectedVesions[e.extId!] == null) {
                        selectedVesions.value[e.extId!] = data.first;
                        widget.onExtensionsChange(
                            widget.selectedExtensions, selectedVesions.value);
                      }

                      return SizedBox(
                          width: 200,
                          height: 40,
                          child: Watch(
                            (ctx) => bnSelect.BnSelect(
                                onChanged: (val) {
                                  selectedVesions.value = {
                                    ...selectedVesions.value,
                                    e.extId!: data.firstWhere(
                                        (element) => element.version == val)
                                  };
                                  widget.onExtensionsChange(
                                      widget.selectedExtensions,
                                      selectedVesions.value);
                                },
                                selectedValue:
                                    selectedVesions.value[e.extId!]!.version,
                                items: data
                                    .map((v) => bnSelect.BnSelectItem(
                                        label: v.version, value: v.version))
                                    .toList()),
                          ));
                    }),
                Text("Blender version: ${e.blenderMinVersion}"),
              ],
            ),
          ),
          icon: e.icon == null
              ? const SizedBox(
                  width: 40,
                  height: 40,
                )
              : Image.network(
                  e.icon!,
                  width: 40,
                  height: 40,
                ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.blocks,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Third party extensions:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text("${AppLocalizations.of(context)!.includeExtensions}: "),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Column(
              children: [
                FutureBuilder<List<BnextExtension>>(
                  future: blenderService.db.database
                      .getExtensionSteamsByBlenderMajorVersion(
                          widget.blenderVersion.version),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Text("No extensions installed");
                    }
                    return Focus(
                      autofocus: false,
                      canRequestFocus: false,
                      child: BnSelect(
                        initialitems: makeItems(widget.selectedExtensions),
                        items: makeItems(snapshot.data ?? []),
                        onRemove: widget.onRemove,
                        onChange: (ids) {
                          final result = snapshot.data!.where((e) {
                            return ids.contains(e.id);
                          }).toList();
                          widget.onExtensionsChange(
                              result, selectedVesions.value);
                        },
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 200,
                        child: BnSidebarButton(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                          icon: const Icon(LucideIcons.save),
                          label: "Save",
                          onPressed: () {
                            widget.onSaveExtensions();
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
