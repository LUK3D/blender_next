import 'package:blender_next/utils/utils.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

enum BnDialogType {
  file(0),
  files(2),
  dialog(3);

  final int val;

  const BnDialogType(this.val);
}

class BnFileDialogInput<T> extends StatelessWidget {
  final BnDialogType dialogType;
  final List<XTypeGroup> acceptedTypeGroups;
  final String? initialDirectory;
  final String? confirmButtonText;
  final String? label;
  final String? inputStringValue;
  final Function(T? val) onSelected;

  const BnFileDialogInput({
    super.key,
    required this.dialogType,
    this.acceptedTypeGroups = const <XTypeGroup>[],
    this.initialDirectory,
    this.confirmButtonText,
    required this.onSelected,
    this.label,
    this.inputStringValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            if (dialogType == BnDialogType.dialog) {
              final String? directoryPath = await getDirectoryPath();
              onSelected(directoryPath as T?);
              return;
            }

            if (dialogType == BnDialogType.files) {
              final List<XFile> files = await openFiles(
                acceptedTypeGroups: acceptedTypeGroups,
                confirmButtonText: confirmButtonText,
                initialDirectory: initialDirectory,
              );
              onSelected(files as T?);

              return;
            }

            final XFile? file = await openFile(
              acceptedTypeGroups: acceptedTypeGroups,
              confirmButtonText: confirmButtonText,
              initialDirectory: initialDirectory,
            );
            onSelected(file as T?);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: Text(ellipseString(label ?? inputStringValue ?? "",
                        maxLength: 40))),
                if (label != null)
                  Text(
                    ellipseString(
                      (inputStringValue ?? "").split(":").elementAtOrNull(1) ??
                          "...",
                      maxLength: 37,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
