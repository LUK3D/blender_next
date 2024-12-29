import 'package:flutter/material.dart';

class BnSidebarButton extends StatelessWidget {
  final Widget? icon;
  final String label;
  final bool isSelected;
  final Function()? onPressed;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const BnSidebarButton({
    super.key,
    this.icon,
    required this.label,
    this.onPressed,
    this.isSelected = false,
    this.borderRadius = 10,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton.icon(
        onPressed: onPressed,
        label: Text(label),
        icon: icon,
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          foregroundColor:
              foregroundColor ?? Theme.of(context).colorScheme.onSurface,
          backgroundColor: isSelected
              ? backgroundColor ?? Theme.of(context).canvasColor
              : backgroundColor ?? Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
