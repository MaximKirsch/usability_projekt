import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageAuthors extends StatelessWidget {
  final ImageProvider autorBild;

  const ImageAuthors({
    required this.autorBild,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.0,
      child: CircleAvatar(
        backgroundImage: autorBild,
        radius: 40.0,
      ),
    );
  }
}
