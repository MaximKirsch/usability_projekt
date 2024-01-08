import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String text;

  const CustomChip({
    required this.icon,
    required this.text,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: CupertinoColors.systemGrey5,
      ),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      icon: Icon(
        icon,
        color: iconColor ?? Colors.black,
      ),
    );
  }
}
