import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usability_projekt/common/colors.dart';

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
    return ActionChip(
      label: Text(text),
      labelStyle: TextStyle(
        color: iconColor ?? Colors.black,
        fontSize: 14.0,
      ),
      avatar: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: orangeColor,
          size: 20.0,
        ),
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 2.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.grey[300],
      onPressed: () {},
      pressElevation: 0.0,
    );
  }
}
