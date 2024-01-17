import 'package:flutter/material.dart';
import 'package:usability_projekt/common/snackbars.dart';
import 'package:usability_projekt/detail/widgets/widgets.dart';
import 'package:usability_projekt/library.dart';

class DetailView extends StatefulWidget {
  final Items book;

  const DetailView({
    required this.book,
    super.key,
  });

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white70,
              size: 34.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(
                !isFavorite ? Icons.bookmark_border_outlined : Icons.bookmark,
                color: Colors.white70,
                size: 34.0,
              ),
              onPressed: () {
                onFavoritePressed();
              },
            ),
          ),
        ],
      ),
      body: ColoredBox(
        color: Colors.blueGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: 235.0,
                width: 170,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(widget.book.cover!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48.0,
              ),
              child: TitleRow(
                title: widget.book.titel!,
                subtitle: widget.book.autor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: MetaRow(
                sites: widget.book.umfang!,
              ),
            )
          ],
        ),
      ),
    );
  }

  void onFavoritePressed() {
    setState(() {
      isFavorite = !isFavorite;
    });
    showSuccessSnackBar(
      context,
      message: isFavorite
          ? 'Buch wurde zu Favoriten hinzugefügt.'
          : 'Buch wurde aus Favoriten entfernt.',
    );
  }
}
