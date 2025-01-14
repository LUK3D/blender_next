import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class BnBtnExtension extends StatelessWidget {
  final bool downloading;
  final bool downloaded;
  final Function onDownload;
  final Function onRemove;

  const BnBtnExtension({
    super.key,
    required this.downloading,
    required this.downloaded,
    required this.onDownload,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: BnSidebarButton(
        backgroundColor: Theme.of(context).canvasColor,
        label: downloaded && !downloading ? "Remove" : "Download",
        icon: downloading
            ? Padding(
                padding: const EdgeInsets.all(7.0),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              )
            : Icon(downloaded && !downloading
                ? LucideIcons.circle_x
                : LucideIcons.cloud_download),
        onPressed: downloading
            ? null
            : (downloaded && !downloading
                ? () {
                    onRemove();
                  }
                : () {
                    onDownload();
                  }),
      ),
    );
  }
}