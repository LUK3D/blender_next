import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ConfimationDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? child;
  final Function()? onConfirm;
  final Function()? onCancel;
  const ConfimationDialog(
      {super.key,
      required this.title,
      this.child,
      this.message,
      this.onConfirm,
      this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      LucideIcons.triangle_alert,
                      color: Colors.orange,
                      size: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (message != null) Text(message!),
                    const SizedBox(
                      height: 10,
                    ),
                    if (child != null) child!,
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text("Cancel"),
                    icon: const Icon(LucideIcons.x),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      if (onConfirm != null) {
                        onConfirm!();
                      }
                    },
                    icon: const Icon(LucideIcons.check),
                    label: const Text("Proceed"),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Dialog showConfirmationDialog(
  BuildContext context, {
  double? width,
  double? height,
  Widget? child,
  required String title,
  String? message,
  Function()? onConfirm,
  Function()? onCancel,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox(
          width: width ?? 700,
          height: height ?? 760,
          child: ConfimationDialog(
            title: title,
            message: message,
            onCancel: onCancel,
            onConfirm: onConfirm,
            child: child,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton.filled(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(LucideIcons.x),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).canvasColor,
            ),
          ),
        )
      ],
    ),
  );
}
