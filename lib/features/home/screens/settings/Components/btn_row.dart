import 'package:flutter/material.dart';

class BnRow extends StatelessWidget {
  final Widget label;
  final Widget input;
  final double? labelWith;
  final double? inputWidth;
  final double? inputMaxWidth;

  const BnRow({
    super.key,
    required this.label,
    required this.input,
    this.labelWith,
    this.inputWidth,
    this.inputMaxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          SizedBox(
            width: labelWith,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: input,
          ),
        ],
      ),
    );
  }
}
