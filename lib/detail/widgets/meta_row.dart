import 'dart:math';

import 'package:flutter/material.dart';

class MetaRow extends StatelessWidget {

  final int sites;

  const MetaRow({required this.sites, super.key});

  @override
  Widget build(BuildContext context) {
    double duration = (sites * 2) / 60;
    duration = double.parse((duration).toStringAsFixed(1));

    // Random double between 3.5 and 4.9
    double rating = Random().nextDouble() * (4.9 - 3.5) + 3.5;
    rating = double.parse((rating).toStringAsFixed(1));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MetaItem(text: 'Rating', value: rating.toString()),
        MetaItem(text: 'Seiten', value: sites.toString()),
        MetaItem(text: 'Sprache', value: 'DE'),
        MetaItem(text: 'Audio', value: duration.toString() + ' Std.'),
      ],
    );
  }

  Widget MetaItem({required String text, required String value}) {
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white54,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

}
