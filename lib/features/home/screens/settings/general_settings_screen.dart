import 'package:blender_next/components/bn_text_input.dart';
import 'package:blender_next/services/settings_service.dart';
import 'package:blender_next/utils/blender_scripts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Components/bn_file_dialog_input.dart';
import 'Components/bn_select.dart';
import 'Components/bn_row.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsService = useSettingsService();
    const inputWidth = 250.0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.settings,
                    size: 25,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.generalSettings,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BnRow(
                labelWith: inputWidth,
                inputWidth: 300,
                label: Text(
                    "${AppLocalizations.of(context)!.closeButtonBehaviour}:"),
                input: Watch((ctx) {
                  return BnSelect(
                    selectedValue:
                        "${settingsService.closeButtonBehaviour.value}",
                    items: [
                      BnSelectItem(
                        label: AppLocalizations.of(context)!.exitApp,
                        value: "0",
                      ),
                      BnSelectItem(
                        label:
                            AppLocalizations.of(context)!.minimizeToSystemtry,
                        value: "1",
                      ),
                    ],
                    onChanged: (val) {
                      settingsService.setCloseButtonBehaviour(int.parse(val));
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              BnRow(
                labelWith: inputWidth,
                inputWidth: 300,
                label: Text("${AppLocalizations.of(context)!.language}:"),
                input: Watch((ctx) {
                  return BnSelect(
                    selectedValue: settingsService.locale.value,
                    items: [
                      BnSelectItem(
                        label: AppLocalizations.of(context)!.english,
                        value: "en",
                      ),
                      BnSelectItem(
                        label: AppLocalizations.of(context)!.portuguese,
                        value: "pt",
                      ),
                    ],
                    onChanged: (val) {
                      settingsService.setLocale(val);
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              BnRow(
                labelWith: inputWidth,
                inputWidth: 300,
                label: Text("${AppLocalizations.of(context)!.themeMode}:"),
                input: Watch((ctx) {
                  return BnSelect(
                    disabled: true,
                    selectedValue: "dark",
                    items: [
                      BnSelectItem(
                        label: AppLocalizations.of(context)!.datkMode,
                        value: "dark",
                      ),
                      BnSelectItem(
                        label: AppLocalizations.of(context)!.lightMode,
                        value: "light",
                      ),
                    ],
                    onChanged: (val) {},
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              BnRow(
                labelWith: inputWidth,
                inputWidth: 300,
                label: Text(
                    "${AppLocalizations.of(context)!.defaultInstallationDir}:"),
                input: Watch(
                  (ctx) => BnFileDialogInput<String?>(
                    inputStringValue:
                        settingsService.defaultInstallationDir.value,
                    dialogType: BnDialogType.dialog,
                    onSelected: (val) {
                      settingsService.setInstallersFolder(val);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BnRow(
                labelWith: inputWidth,
                inputWidth: 300,
                label: const Text("Extension installation dir:"),
                input: Watch(
                  (ctx) => BnFileDialogInput<String?>(
                    inputStringValue: settingsService.extentionsDir.value,
                    dialogType: BnDialogType.dialog,
                    onSelected: (val) {
                      settingsService.setExtensionsDir(val);
                    },
                  ),
                ),
              ),
              Divider(
                height: 40,
                color: Theme.of(context).dividerColor,
              ),
              Row(
                children: [
                  Icon(
                    LucideIcons.camera,
                    size: 25,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.thumbnailRendering,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BnRow(
                labelWith: inputWidth,
                inputWidth: 300,
                label:
                    Text("${AppLocalizations.of(context)!.renderingEngine}:"),
                input: Watch((ctx) => BnSelect(
                        items: [
                          BnSelectItem(
                            label: "Workbench",
                            value: BlenderEngines.workbench,
                          ),
                          BnSelectItem(
                            label: "Cycles",
                            value: BlenderEngines.cycles,
                          ),
                          BnSelectItem(
                            label: "EEVEE",
                            value: BlenderEngines.eevee,
                          ),
                        ],
                        selectedValue:
                            settingsService.thumbnailRenderingEngine.value,
                        onChanged: (val) {
                          settingsService.setDefaultRenderingEngine(val);
                        })),
              ),
              const SizedBox(
                height: 10,
              ),
              Watch(
                (ctx) => BnRow(
                  labelWith: inputWidth,
                  inputWidth: 300,
                  label: Text("${AppLocalizations.of(context)!.size}:"),
                  input: Row(
                    children: [
                      Expanded(
                        child: BnTextInput(
                          isNumeric: true,
                          initialValue:
                              "${settingsService.thumbnailSize.value.width}"
                                  .split(".")
                                  .first,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          icon: const Text(
                            "W:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "",
                          onChanged: (val) {
                            if (val.isEmpty) {
                              return;
                            }
                            settingsService.setThumbnailSize(
                              width: double.tryParse(val),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: BnTextInput(
                          isNumeric: true,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          initialValue:
                              "${settingsService.thumbnailSize.value.height}"
                                  .split(".")
                                  .first,
                          icon: const Text(
                            "H:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          hintText: "",
                          onChanged: (val) {
                            if (val.isEmpty) {
                              return;
                            }
                            settingsService.setThumbnailSize(
                              height: double.tryParse(val),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BnRow(
                labelWith: inputWidth,
                inputWidth: 300,
                label: Text("${AppLocalizations.of(context)!.samples}:"),
                input: Watch(
                  (ctx) => BnTextInput(
                    isNumeric: true,
                    initialValue: "${settingsService.thumbnailSamples.value}"
                        .split(".")
                        .first,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    hintText: "",
                    onChanged: (val) {
                      if (val.trim().isEmpty) {
                        return;
                      }
                      settingsService.setThumbnailSamples(double.tryParse(val));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BnRow(
                labelWith: inputWidth,
                inputWidth: 300,
                label: Text("${AppLocalizations.of(context)!.frame}:"),
                input: Watch(
                  (ctx) => BnTextInput(
                    isNumeric: true,
                    initialValue: "${settingsService.thumbnailFrame.value}"
                        .split(".")
                        .first,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    hintText: "",
                    onChanged: (val) {
                      if (val.trim().isEmpty) {
                        return;
                      }
                      settingsService.setThumbnailFrame(int.tryParse(val));
                    },
                  ),
                ),
              ),
              Divider(
                height: 40,
                color: Theme.of(context).dividerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
