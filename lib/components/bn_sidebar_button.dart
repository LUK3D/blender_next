import 'package:flutter/material.dart';

class BnSidebarButton extends StatelessWidget {
  final Widget? icon;
  final String label;
  final bool isSelected;
  final Function()? onPressed;
  const BnSidebarButton({
    super.key,
    this.icon,
    required this.label,
    this.onPressed,
    this.isSelected = false,
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
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.onSurface.withOpacity(0.2)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
