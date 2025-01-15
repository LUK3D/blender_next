import 'package:blender_next/data/database/database.dart';
import 'package:blender_next/features/home/screens/extensions/components/bn_btn_extension.dart';
import 'package:blender_next/services/exntesions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:numeral/numeral.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BnExtensionCard extends StatefulWidget {
  final BnextExtension ext;
  final Function(BnextExtension selectedExtension) onSelect;
  const BnExtensionCard({super.key, required this.ext, required this.onSelect});

  @override
  State<BnExtensionCard> createState() => _BnExtensionCardState();
}

class _BnExtensionCardState extends State<BnExtensionCard> {
  final extensionsService = useExntesionsService();
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          widget.onSelect(widget.ext);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: widget.ext.cover == null ||
                        widget.ext.cover!.contains(".orgnull")
                    ? const SizedBox()
                    : Image.network(
                        widget.ext.cover ?? "",
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                widget.ext.name ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(widget.ext.description ?? ""),
              const Spacer(),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.cloud_download,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("${widget.ext.downloads?.numeral(digits: 1) ?? 0}"),
                    ],
                  ),
                  Row(
                    children: [
                      AnimatedRatingStars(
                        initialRating: widget.ext.stars ?? 0,
                        minRating: 0.0,
                        maxRating: 5.0,
                        filledColor: Colors.orange,
                        emptyColor: Theme.of(context).colorScheme.onSurface,
                        filledIcon: Icons.star,
                        halfFilledIcon: Icons.star_half,
                        emptyIcon: Icons.star_border,
                        onChanged: (double rating) {},
                        displayRatingValue: false,
                        interactiveTooltips: false,
                        customFilledIcon: Icons.star,
                        customHalfFilledIcon: Icons.star_half,
                        customEmptyIcon: Icons.star_border,
                        starSize: 10.0,
                        animationDuration: const Duration(milliseconds: 300),
                        animationCurve: Curves.easeInOut,
                        readOnly: true,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "(${widget.ext.reviewers?.numeral(digits: 1) ?? 0})",
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  BnextExtensionVersion? version;

                  if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                    version = extensionsService.makeVersion(widget.ext);
                  }
                  version ??= snapshot.data!.first;

                  extensionsService.extensionsDownloadQueue[
                      '${widget.ext.extId}-${version.version}'] ??= {};

                  final downloading = extensionsService.extensionsDownloadQueue[
                              '${widget.ext.extId}-${version.version}']
                          ["downloading"] ??
                      false;

                  return BnBtnExtension(
                    alignment: Alignment.center,
                    backgroundColor: Theme.of(context).canvasColor,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    width: double.infinity,
                    downloading: downloading,
                    label: "Download latest",
                    downloaded: version.instalationPath != null &&
                        version.instalationPath?.isNotEmpty == true,
                    onDownload: downloading || version.version == ''
                        ? null
                        : () {
                            extensionsService.downloadExtentionWithoutVesion(
                              widget.ext,
                              onDone: (file) {
                                setState(() {});
                              },
                            );
                            setState(() {});
                          },
                    onRemove: version.version == ''
                        ? null
                        : () {
                            extensionsService
                                .uninstallExtension(
                              version!,
                            )
                                .then((_) {
                              setState(() {});
                            });
                          },
                  );
                },
                future: extensionsService.db.database
                    .getExtensionVersionByExtensionId(widget.ext.id!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
