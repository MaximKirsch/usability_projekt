import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usability_projekt/library.dart';

class DetailScreen extends StatelessWidget {
  final Items book;

  const DetailScreen({
    required this.book,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
              size: 30.0,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: FractionallySizedBox(
          heightFactor: 0.65,
          widthFactor: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 235.0,
                    width: 170,
                    child: Image(
                      image: AssetImage(book.cover!),
                      height: 235.0,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  book.titel!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
