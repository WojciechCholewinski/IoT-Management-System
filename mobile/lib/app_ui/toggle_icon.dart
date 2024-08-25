import 'package:flutter/material.dart';

class ToggleIcon extends StatelessWidget {
  const ToggleIcon({
    super.key,
    required this.value,
    required this.onPressed,
    required this.onIcon,
    required this.offIcon,
  });

  final bool value;
  final Function() onPressed;
  final Widget onIcon;
  final Widget offIcon;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: value ? onIcon : offIcon,
        iconSize: 60,
      );
}
