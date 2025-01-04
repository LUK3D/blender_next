import 'package:flutter/material.dart';
import './flutter_multiselect_render_layout_box.dart';
import './flutter_multiselect_layout_delegate.dart';

/// This is just a normal [CustomMultiChildLayout] with
/// overrided [createRenderObject] to use custom [RenderCustomMultiChildLayoutBox]
class FlutterMultiselectLayout extends CustomMultiChildLayout {
  // ignore: prefer_const_constructors_in_immutables
  FlutterMultiselectLayout({
    super.key,
    required FlutterMultiselectLayoutDelegate super.delegate,
    super.children,
  });

  @override
  FlutterMultiselectRenderLayoutBox createRenderObject(BuildContext context) {
    return FlutterMultiselectRenderLayoutBox(
        delegate: delegate as FlutterMultiselectLayoutDelegate);
  }
}
