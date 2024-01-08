import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageTitle extends StatelessWidget {
  final ImageProvider buchBild;
  final String text;

  const ImageTitle({
    required this.buchBild,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: buchBild,
          height: 150.0,
          width: 105.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
            text,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
