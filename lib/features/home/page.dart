import 'package:blender_next/components/bn_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: BnLogo(
          type: BnLogoType.labeledColored,
          width: 200,
        ),
      ),
    );
  }
}
