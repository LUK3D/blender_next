import 'package:flutter/material.dart';

class SideMenuItem<T> {
  final T id;
  final String label;
  final IconData icon;

  SideMenuItem({
    required this.label,
    required this.icon,
    required this.id,
  });
}
