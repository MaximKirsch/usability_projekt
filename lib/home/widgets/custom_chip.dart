import 'package:flutter/material.dart';
import 'package:usability_projekt/common/colors.dart';

class CustomChip extends StatefulWidget {
  final IconData icon;
  final Color? iconColor;
  final String text;
  final VoidCallback? onPressed;
  final bool? ignoreSelection;
  final bool active;

  const CustomChip({
    required this.icon,
    required this.text,
    this.onPressed,
    this.iconColor,
    this.ignoreSelection,
    this.active = false,
    super.key,
  });

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      surfaceTintColor: orangeColor,
      label: Text(widget.text),
      labelStyle: TextStyle(
        color: widget.iconColor ?? Colors.black,
        fontSize: 14.0,
      ),
      avatar: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          widget.icon,
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
      selectedColor: orangeColor.withOpacity(0.5),
      pressElevation: 0.0,
      onSelected: (bool selected) {
        widget.onPressed?.call();
      },
      selected: widget.active ?? false,
    );
  }
}
