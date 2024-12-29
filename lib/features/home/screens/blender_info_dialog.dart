import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:blender_next/data/model/blender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:signals/signals_flutter.dart';

Dialog blenderInforDialog(
    BuildContext context,
    Blender blender,
    FlutterSignal<double>? signal,
    Function(Blender blender) onDownload,
    Function(Blender blender) onUninstall) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 600,
            height: 550,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    color: Theme.of(context).canvasColor,
                    clipBehavior: Clip.antiAlias,
                    child: blender.splashscreen?.imageUrl != null
                        ? Image.network(
                            blender.splashscreen?.imageUrl ?? "",
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (signal != null)
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Watch(
                          (context) => LinearProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                            value: signal.value,
                            backgroundColor: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
                        const SizedBox(width: 10),
                        Watch(
                          (context) => Text(
                            "${(signal.value * 100).floor()}%",
                          ),
                        )
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Text(
                      "${blender.title} ${blender.version}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.variant,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          AppLocalizations.of(context)!.architecture,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          AppLocalizations.of(context)!.date,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          AppLocalizations.of(context)!.reference,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blender.variant,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          blender.architecture,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          blender.date,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          blender.reference,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: BnSidebarButton(
                        label: blender.installed
                            ? AppLocalizations.of(context)!.uninstall
                            : AppLocalizations.of(context)!.install,
                        onPressed: () {
                          if (blender.installed) {
                            onUninstall(blender);
                            return;
                          }
                          onDownload(blender);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          blender.installed
                              ? LucideIcons.package_x
                              : LucideIcons.cloud_download,
                        ),
                        backgroundColor: blender.installed
                            ? Theme.of(context).canvasColor
                            : Theme.of(context).primaryColor,
                        foregroundColor: blender.installed
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.white,
                        borderRadius: 50,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        IconButton.filled(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LucideIcons.x),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).canvasColor,
          ),
        )
      ],
    ),
  );
}
