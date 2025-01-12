import 'package:flutter/material.dart';

class BnRow extends StatelessWidget {
  final Widget label;
  final Widget input;
  final double? labelWith;
  final double? inputWidth;
  final double? inputMaxWidth;
  final Color? backgroundColor;
  final double? height;

  const BnRow({
    super.key,
    required this.label,
    required this.input,
    this.labelWith,
    this.inputWidth,
    this.inputMaxWidth,
    this.backgroundColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWith,
            height: height ?? 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                label,
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: inputWidth,
            height: height ?? 40,
            decoration: BoxDecoration(
              color:
                  backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: input,
          ),
        ],
      ),
    );
  }
}
