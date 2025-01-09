import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/features/home/screens/extensions/details_screen.dart';
import 'package:blender_next/services/exntesions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:logger/logger.dart';
import 'package:numeral/numeral.dart';

class ExtensionsMainScreen extends StatefulWidget {
  const ExtensionsMainScreen({super.key});

  @override
  State<ExtensionsMainScreen> createState() => _ExtensionsMainScreenState();
}

class _ExtensionsMainScreenState extends State<ExtensionsMainScreen> {
  final extensionsService = useExntesionsService();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int currentPage = 1;
  BnextExtension? selectedExtension;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // Check if the user is 80% of the way down the scrollable content
      if (_scrollController.position.pixels >=
              0.8 * _scrollController.position.maxScrollExtent &&
          !isLoading) {
        if (currentPage < extensionsService.lastPage || currentPage == 1) {
          // setState(() {
          //   currentPage += 1;
          //   isLoading = true;
          // });
          // extensionsService.getExtensions(page: currentPage).then((val) {
          //   setState(() {
          //     isLoading = false;
          //   });
          // });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
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
                            LucideIcons.blocks,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)!.extensions,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ],
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 180,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: StreamBuilder<List<BnextExtension>>(
                      stream: extensionsService.db.database.top5Extensions(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error loading top 5 extensions"),
                          );
                        }
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 100.0,
                            viewportFraction: 1,
                            autoPlay: true,
                          ),
                          items: (snapshot.data ?? []).map((ext) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Material(
                                      color: Colors.black,
                                      clipBehavior: Clip.antiAlias,
                                      borderRadius: BorderRadius.circular(20),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedExtension = ext;
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: ShaderMask(
                                                shaderCallback: (rect) {
                                                  return const LinearGradient(
                                                    begin:
                                                        Alignment.centerRight,
                                                    end: Alignment.centerLeft,
                                                    colors: [
                                                      Colors.black,
                                                      Colors.transparent
                                                    ],
                                                  ).createShader(Rect.fromLTRB(
                                                    0,
                                                    0,
                                                    rect.width,
                                                    rect.height,
                                                  ));
                                                },
                                                blendMode: BlendMode.dstIn,
                                                child: Container(
                                                  color: Colors.black,
                                                  height: 200,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Image.network(
                                                    ext.cover ?? "",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: SizedBox(
                                                height: 200,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ext.name ?? "",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(ext.description ??
                                                          ""),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            );
                          }).toList(),
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: StreamBuilder<List<BnextExtension>>(
                        stream:
                            extensionsService.db.database.getExtensionsStream(),
                        builder: (context, snapshot) {
                          print(snapshot.data?.length);

                          return GridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 2 / 2.4),
                            itemCount: (snapshot.data ?? []).length,
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (context, index) {
                              final ext = snapshot.data![index];

                              return Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    setState(() {
                                      selectedExtension = ext;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 140,
                                          width: double.infinity,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ext.cover == null ||
                                                  ext.cover!
                                                      .contains(".orgnull")
                                              ? const SizedBox()
                                              : Image.network(
                                                  ext.cover ?? "",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Text(
                                          ext.name ?? "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(ext.description ?? ""),
                                        const Spacer(),
                                        Divider(
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  LucideIcons.cloud_download,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                    "${ext.downloads?.numeral(digits: 1) ?? 0}"),
                                              ],
                                            ),
                                            Row(
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
                                                  halfFilledIcon:
                                                      Icons.star_half,
                                                  emptyIcon: Icons.star_border,
                                                  onChanged: (double rating) {},
                                                  displayRatingValue: false,
                                                  interactiveTooltips: false,
                                                  customFilledIcon: Icons.star,
                                                  customHalfFilledIcon:
                                                      Icons.star_half,
                                                  customEmptyIcon:
                                                      Icons.star_border,
                                                  starSize: 10.0,
                                                  animationDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  animationCurve:
                                                      Curves.easeInOut,
                                                  readOnly: true,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "(${ext.reviewers?.numeral(digits: 1) ?? 0})",
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 40,
                                          child: TextButton.icon(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  Theme.of(context).canvasColor,
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                            label: const Text("Download"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }))
              ],
            ),
            floatingActionButton: !isLoading
                ? SizedBox()
                : CircleAvatar(
                    backgroundColor: Theme.of(context).canvasColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
        ),
        if (selectedExtension != null)
          ExtensionDetailsScreen(
            bnextExtension: selectedExtension!,
            onDismiss: () {
              setState(() {
                selectedExtension = null;
              });
            },
          ),
      ],
    );
  }
}
