import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;
  final String? subtitle;

  const CustomSwitch({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue[700],
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
