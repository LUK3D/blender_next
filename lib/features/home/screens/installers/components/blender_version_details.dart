import 'dart:convert';

import 'package:blender_next/components/bn_markdown_video_element_builder.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/services/blender_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BlenderVersionDetail extends StatelessWidget {
  final BlenderVersion bVersion;
  const BlenderVersionDetail({super.key, required this.bVersion});

  @override
  Widget build(BuildContext context) {
    final blenderServices = useBlenderService();
    final splashScreenshot =
        blenderServices.db.getSplashScreenById(bVersion.splashScreen);
    return Scaffold(
      body: Stack(
        children: [
          if (splashScreenshot != null)
            Image.network(
              splashScreenshot.imageUrl,
              fit: BoxFit.cover,
            ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black,
                Colors.transparent,
              ],
            )),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DefaultTabController(
                length: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Blender ${bVersion.version} \n${bVersion.variant}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            height: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(bVersion.date),
                      const SizedBox(
                        height: 20,
                      ),
                      if (splashScreenshot != null)
                        Column(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.network(
                                splashScreenshot.imageUrl,
                              ),
                            ),
                            Text(
                                "${splashScreenshot.author} - ${splashScreenshot.license}")
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 1200,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .canvasColor
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                                child: TabBar(
                                    dividerColor:
                                        Theme.of(context).dividerColor,
                                    splashBorderRadius:
                                        BorderRadius.circular(10),
                                    tabs: const [
                                      Tab(
                                        text: "Release notes",
                                      ),
                                      Tab(
                                        text: "Extensions",
                                      ),
                                    ]),
                              ),
                              StreamBuilder(
                                stream: blenderServices.db.database
                                    .getBlenderVersionStreamById(bVersion),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null ||
                                      (snapshot.data?.description
                                              .trim()
                                              .isEmpty ??
                                          true)) {
                                    return const Text("Loading...");
                                  }

                                  final data = List<Map<String, dynamic>>.from(
                                      jsonDecode(snapshot.data!.description));

                                  return ExpansionPanelList(
                                    dividerColor:
                                        Theme.of(context).dividerColor,
                                    materialGapSize: 4,
                                    expansionCallback:
                                        (panelIndex, isExpanded) {},
                                    children: data.map((e) {
                                      return ExpansionPanel(
                                          headerBuilder: (BuildContext context,
                                              bool isExpanded) {
                                            return ListTile(
                                              title: Text(e["title"]!),
                                            );
                                          },
                                          isExpanded: true,
                                          body: ListTile(
                                            subtitle: Markdown(
                                              data: e['description'],
                                              shrinkWrap: true,
                                              builders: {
                                                'a': BnMarkdownVideoElementBuilder(
                                                    "https://developer.blender.org/docs/release_notes/${bVersion.version.substring(0, 3)}/"), // Add the custom builder for video
                                              },
                                              imageBuilder: (uri, title, alt) {
                                                if (uri
                                                        .toString()
                                                        .split(".")
                                                        .last ==
                                                    "svg") {
                                                  return const SizedBox();
                                                }
                                                final imageUrl =
                                                    "https://developer.blender.org/docs/release_notes/${bVersion.version.substring(0, 3)}/${uri.toString().split("..").last.split('//').join('/')}";
                                                return Image.network(imageUrl);
                                              },
                                            ),
                                          ));
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
