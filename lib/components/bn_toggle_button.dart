import 'package:flutter/material.dart';

class BnToggleButton extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final Color color;
  final bool selected;
  final Function() onClick;
  const BnToggleButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.selected = false,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 100,
        minHeight: 90,
      ),
      child: IconButton.outlined(
          color: Theme.of(context).colorScheme.primary,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            side: BorderSide(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).canvasColor,
              width: 3,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
          ),
          onPressed: onClick,
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                height: 4,
              ),
              Opacity(opacity: 0.5, child: label),
            ],
          )),
    );
  }
}
