import 'dart:convert';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:blender_next/components/video_player.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/features/home/screens/settings/Components/btn_row.dart';
import 'package:blender_next/services/exntesions_service.dart';
import 'package:blender_next/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:numeral/numeral.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExtensionDetailsScreen extends StatefulWidget {
  final BnextExtension bnextExtension;
  final Function onDismiss;
  const ExtensionDetailsScreen({
    super.key,
    required this.bnextExtension,
    required this.onDismiss,
  });

  @override
  State<ExtensionDetailsScreen> createState() => _ExtensionDetailsScreenState();
}

class _ExtensionDetailsScreenState extends State<ExtensionDetailsScreen> {
  final extService = useExntesionsService();
  final carouselController = CarouselSliderController();
  @override
  void initState() {
    super.initState();
    extService.getExtensionDetails(widget.bnextExtension);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: StreamBuilder<BnextExtension>(
                stream: extService.db.database
                    .getExtensionStreamById(widget.bnextExtension),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final ext = snapshot.data!;
                  final carouselItems = List<Map<String, dynamic>>.from(
                      jsonDecode(ext.mediaUrls ?? "[]"));

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: (ext.icon == null)
                                          ? null
                                          : Image.network(
                                              ext.icon!,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ext.name ?? "",
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(ext.description ?? ''),
                                        Row(
                                          children: [
                                            Icon(
                                              LucideIcons.user_round,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(ext.maintainer ?? ""),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: IconButton.filled(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  LucideIcons.external_link,
                                                  size: 15,
                                                ),
                                                style: IconButton.styleFrom(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .cardColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 80.0),
                                  child: TextButton.icon(
                                    onPressed: () {},
                                    label: Text(
                                        AppLocalizations.of(context)!.download),
                                    icon:
                                        const Icon(LucideIcons.cloud_download),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (carouselItems.isNotEmpty)
                          SizedBox(
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CarouselSlider(
                                    carouselController: carouselController,
                                    options: CarouselOptions(
                                      height: 400.0,
                                      viewportFraction: 1,
                                      // autoPlay: true,
                                    ),
                                    items: carouselItems.map<Widget>((item) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Material(
                                                color: Colors.black,
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        color: Colors.black,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: ((item["media_url"]
                                                                        as String?)
                                                                    ?.endsWith(
                                                                        ".mp4") ??
                                                                false)
                                                            ? BnVideoPlayer(
                                                                videoUrl: item[
                                                                    "media_url"],
                                                                thumbnailUrl: item[
                                                                    "thumbnail"],
                                                              )
                                                            : Image.network(
                                                                item["thumbnail"] ??
                                                                    "",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                      15,
                                    ),
                                  ),
                                  width: 100,
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: carouselItems
                                          .map<Widget>((e) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: SizedBox(
                                                  height: 70,
                                                  child: Material(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: InkWell(
                                                      onTap: () {
                                                        carouselController
                                                            .jumpToPage(
                                                                carouselItems
                                                                    .indexOf(
                                                                        e));
                                                      },
                                                      child: Stack(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child:
                                                                Image.network(
                                                              e["thumbnail_low_res"],
                                                            ),
                                                          ),
                                                          if ((e["media_url"]
                                                                  as String)
                                                              .endsWith(".mp4"))
                                                            SizedBox(
                                                              width: 100,
                                                              height: 70,
                                                              child: Material(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    carouselController
                                                                        .jumpToPage(
                                                                            carouselItems.indexOf(e));
                                                                  },
                                                                  child: Center(
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Theme.of(context)
                                                                              .canvasColor,
                                                                      child:
                                                                          Icon(
                                                                        LucideIcons
                                                                            .play,
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onSurface,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 280,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${ext.stars}",
                                        style: const TextStyle(
                                          fontSize: 100,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AnimatedRatingStars(
                                            initialRating: ext.stars ?? 0,
                                            minRating: 0.0,
                                            maxRating: 5.0,
                                            filledColor: Colors.orange,
                                            emptyColor: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            filledIcon: Icons.star,
                                            halfFilledIcon: Icons.star_half,
                                            emptyIcon: Icons.star_border,
                                            onChanged: (double rating) {},
                                            displayRatingValue: false,
                                            interactiveTooltips: false,
                                            customFilledIcon: Icons.star,
                                            customHalfFilledIcon:
                                                Icons.star_half,
                                            customEmptyIcon: Icons.star_border,
                                            starSize: 25.0,
                                            animationDuration: const Duration(
                                                milliseconds: 300),
                                            animationCurve: Curves.easeInOut,
                                            readOnly: true,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "(${ext.reviewers?.numeral(digits: 1) ?? 0})",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.developer}:"),
                                        input: Text(
                                          ext.maintainer ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.version}:"),
                                        input: Text(
                                          ext.version ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.lastUpdatedAt}:"),
                                        input: Text(
                                          ext.lastUpdateOn
                                                  .toString()
                                                  .split(" ")
                                                  .firstOrNull ??
                                              "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.publishedOn}:"),
                                        input: Text(
                                          ext.publishedOn
                                                  .toString()
                                                  .split(" ")
                                                  .firstOrNull ??
                                              "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.downloads}:"),
                                        input: Text(
                                          ext.downloads?.toString() ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.size}:"),
                                        input: Text(
                                          ext.size?.toString() ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.compatibility}:"),
                                        input: Text(
                                          "Blender ${ext.blenderMinVersion?.toString() ?? ''} and newer",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.licence}:"),
                                        input: Text(
                                          ext.licence ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.reportIssue}:"),
                                        input: Text(
                                          ellipseString(ext.supportUrl ?? "",
                                              maxLength: 40),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BnRow(
                                        height: 20,
                                        labelWith: 150,
                                        backgroundColor: Colors.transparent,
                                        label: Text(
                                            "${AppLocalizations.of(context)!.website}:"),
                                        input: Text(
                                          ellipseString(
                                            ext.website ?? "",
                                            maxLength: 40,
                                          ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
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
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "About",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Markdown(
                            shrinkWrap: true,
                            selectable: true,
                            data: ext.mdDescriptio ?? "",
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        Positioned(
            right: 16,
            child: IconButton.filled(
              onPressed: () {
                widget.onDismiss();
              },
              icon: const Icon(LucideIcons.x),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).canvasColor,
              ),
            ))
      ],
    );
  }
}
