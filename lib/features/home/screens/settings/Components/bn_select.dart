import 'package:flutter/material.dart';

class BnSelectItem<T> {
  final String label;
  final String value;
  final T? data;

  BnSelectItem({
    required this.label,
    required this.value,
    this.data,
  });
}

class BnSelect extends StatelessWidget {
  final List<BnSelectItem> items;
  final String selectedValue;
  final Function(String val) onChanged;
  final bool disabled;

  const BnSelect({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final values = items.map((e) => e.value).toList();
    String value = selectedValue;

    if (!values.contains(value)) {
      value = values.first;
    }

    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      value: value,
      underline: const SizedBox(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      icon: const SizedBox(),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item.value,
          child: Text(
            item.label,
          ),
        );
      }).toList(),
      onChanged: disabled
          ? null
          : (val) {
              if (val != null) {
                onChanged(val);
              }
            },
    );
  }
}
