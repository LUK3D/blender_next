import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:blender_next/data/model/blender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

Dialog blenderInforDialog(BuildContext context, Blender blender) {
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Variant:",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Architecture:",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Date:",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Reference:",
                          style: TextStyle(fontSize: 18),
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
                        label: "Download",
                        icon: const Icon(
                          LucideIcons.cloud_download,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        borderRadius: 50,
                        onPressed: () {},
                      ),
                    )
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
