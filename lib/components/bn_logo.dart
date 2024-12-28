import 'package:flutter/material.dart';

/// ## BnLogoType
/// Enum for the type of logo to display
enum BnLogoType {
  colored(0),
  white(1),
  black(2),
  labeledColored(3),
  labeledWhite(4),
  labeledBlack(5);

  const BnLogoType(this.value);

  final int value;
}

/// ## BnLogo
/// A widget that displays the Blender Next logo
/// - [type] : The type of logo to display
/// - [width] : The width of the logo
/// - [height] : The height of the logo
class BnLogo extends StatelessWidget {
  final BnLogoType type;
  final double? width;
  final double? height;

  const BnLogo(
      {super.key, this.type = BnLogoType.colored, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (type == BnLogoType.colored) {
      return SizedBox(
        width: width ?? 50,
        height: height ?? 50,
        child: Image.asset(
          "assets/blender-next-colored.png",
        ),
      );
    }

    if (type == BnLogoType.white) {
      return Image.asset(
        "assets/blender-next-white.png",
        width: width ?? 50,
        height: height,
      );
    }

    if (type == BnLogoType.black) {
      return Image.asset(
        "assets/blender-next-black.png",
        width: width ?? 50,
        height: height,
        fit: BoxFit.contain,
      );
    }
    if (type == BnLogoType.labeledColored) {
      return Image.asset(
        "assets/blender-next-labeled-colored.png",
        width: width ?? 50,
        height: height,
        fit: BoxFit.contain,
      );
    }
    if (type == BnLogoType.labeledWhite) {
      return Image.asset(
        "assets/blender-next-labeled-white.png",
        width: width ?? 50,
        height: height,
        fit: BoxFit.contain,
      );
    }

    return Image.asset("assets/blender-next-labeled-black.png",
        width: width ?? 50, height: height, fit: BoxFit.contain);
  }
}
