import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?)? onChanged;
  final String? subtitle;

  const CustomCheckbox({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue[700],
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
