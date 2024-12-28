import 'package:blender_next/components/bn_logo.dart';
import 'package:blender_next/data/model/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:window_manager/window_manager.dart';

import 'bn_sidebar_button.dart';

class BnSidebar<T> extends StatelessWidget {
  final List<SideMenuItem<T>> items;
  final double gap;
  final Widget child;
  final Function(T)? onItemSelected;
  final T selectedItem;
  const BnSidebar({
    super.key,
    required this.child,
    this.items = const [],
    this.gap = 10.0,
    this.onItemSelected,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Container(
              width: 300,
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DragToMoveArea(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(16.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BnLogo(
                            type: BnLogoType.labeledColored,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        for (var btnItem in items)
                          Padding(
                            padding: EdgeInsets.only(bottom: gap),
                            child: BnSidebarButton(
                              isSelected: btnItem.id == selectedItem,
                              onPressed: () => onItemSelected?.call(btnItem.id),
                              label: btnItem.label,
                              icon: Icon(btnItem.icon),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ));
  }
}
