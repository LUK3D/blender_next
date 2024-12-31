import 'package:flutter/rendering.dart';
import 'flutter_multiselect_layout_delegate.dart';

/// Got inspiration from below, but did not want to override a bunch of things
/// https://gist.github.com/slightfoot/0ddf14dd0f77e5be4c6b8904d3a2df67
class FlutterMultiselectRenderLayoutBox
    extends RenderCustomMultiChildLayoutBox {
  FlutterMultiselectRenderLayoutBox({
    super.children,
    required FlutterMultiselectLayoutDelegate super.delegate,
  });

  @override
  void performLayout() {
    super.performLayout();

    //* Set the parent size here
    size = (delegate as FlutterMultiselectLayoutDelegate).parentSize;
  }
}
