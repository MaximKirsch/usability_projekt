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
    const width = 105.0;
    return SizedBox(
      width: width + 10,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              child: Image(
                image: buchBild,
                height: 150.0,
                width: width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
