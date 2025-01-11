import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BnTextInput extends StatelessWidget {
  final Widget? icon;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final double width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final String? initialValue;
  final bool isNumeric;

  const BnTextInput({
    super.key,
    this.icon,
    this.hintText,
    this.controller,
    this.onChanged,
    this.width = 300,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.initialValue,
    this.isNumeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: width,
      height: height,
      child: TextFormField(
        inputFormatters:
            isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
        controller: controller,
        onChanged: onChanged,
        initialValue: initialValue,
        decoration: InputDecoration(
          fillColor: textColor,
          icon: icon,
          contentPadding: const EdgeInsets.only(bottom: 8),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
