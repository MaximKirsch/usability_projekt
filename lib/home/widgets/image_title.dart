import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ImageTitle extends StatelessWidget {
  final ImageProvider buchBild;
  final String text;

  final bool isFavorite;

  const ImageTitle({
    required this.buchBild,
    required this.text,
    this.isFavorite = false,
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
              child: Stack(
                children: [
                  Image(
                    image: buchBild,
                    height: 150.0,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                  isFavorite
                      ? Positioned(
                          top: 5,
                          right: 5,
                          child: const Icon(
                            Ionicons.heart,
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                ],
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
