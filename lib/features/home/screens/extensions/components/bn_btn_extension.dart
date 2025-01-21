import 'package:blender_next/components/bn_sidebar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class BnBtnExtension extends StatelessWidget {
  final bool downloading;
  final bool downloaded;
  final Function? onDownload;
  final Function? onRemove;
  final double? borderRadius;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final AlignmentGeometry? alignment;
  final String? label;

  const BnBtnExtension({
    super.key,
    required this.downloading,
    required this.downloaded,
    this.onDownload,
    this.onRemove,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.alignment,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 150,
      child: BnSidebarButton(
        alignment: alignment,
        borderRadius: borderRadius ?? 10,
        backgroundColor: downloaded || downloading
            ? Theme.of(context).canvasColor
            : (backgroundColor ?? Theme.of(context).primaryColor),
        foregroundColor: downloaded || downloading
            ? null
            : (foregroundColor ?? Colors.white),
        label: downloaded && !downloading ? "Remove" : (label ?? "Download"),
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
                    onRemove?.call();
                  }
                : () {
                    onDownload?.call();
                  }),
      ),
    );
  }
}
