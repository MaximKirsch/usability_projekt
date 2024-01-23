import 'package:flutter/material.dart';
import 'package:usability_projekt/home/widgets/widgets.dart';

class AuthorsList extends StatelessWidget {
  const AuthorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageAuthors(
          autorBild: AssetImage('assets/autoren/erhard.jpeg'),
        ),
        ImageAuthors(
          autorBild: AssetImage('assets/autoren/George_Orwell.jpg'),
        ),
        ImageAuthors(
          autorBild: AssetImage('assets/autoren/JK.jpg'),
        ),
        ImageAuthors(
          autorBild:
          AssetImage('assets/autoren/John_Katzenbach.jpg'),
        ),
        ImageAuthors(
          autorBild:
          AssetImage('assets/autoren/Sascha_Feuchert.jpg'),
        ),
      ],
    );
  }
}
