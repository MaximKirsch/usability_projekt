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
  GlobalKey<FormState> customScrollViewKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        key: customScrollViewKey,
        slivers: [
          SliverAppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            primary: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            backgroundColor: Colors.blueGrey,
            floating: false,
            pinned: true,
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
                    !isFavorite
                        ? Icons.bookmark_border_outlined
                        : Icons.bookmark,
                    color: Colors.white70,
                    size: 34.0,
                  ),
                  onPressed: () {
                    onFavoritePressed();
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Container(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48.0,
                            ),
                            child: TitleRow(
                              title: widget.book.titel!,
                              subtitle: widget.book.autor,
                            ),
                          ),
                          SizedBox(height: 32),
                          MetaRow(
                            sites: widget.book.umfang!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48.0,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Worum geht es?',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.book.beschreibung!,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
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
