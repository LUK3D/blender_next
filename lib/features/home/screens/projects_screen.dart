import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key, required this.isLoading});

  final bool isLoading;

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
                      "${AppLocalizations.of(context)!.projectManager})",
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
                    onPressed: () {},
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 5 / 5,
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return Material(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {},
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
                                  child: Image.network(
                                    "https://i.pinimg.com/736x/c8/c1/19/c8c1195229120baef9f643b8d25eb345.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Project title goes here",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                LucideIcons.ellipsis)))
                                  ],
                                ),
                                const Expanded(
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      "union include pencil sea center than pole cloth hang powerful cook wool crack themselves headed certain putting thick threw composed riding anywhere soldier neck",
                                      style:
                                          TextStyle(fontSize: 14, height: 1.1),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
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
                                        const Text(
                                          "2024-12-24",
                                          style: TextStyle(
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
                                        "Blender 3.4.0-Beta",
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
