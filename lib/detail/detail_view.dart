import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:usability_projekt/common/colors.dart';
import 'package:usability_projekt/common/constants.dart';
import 'package:usability_projekt/common/snackbars.dart';
import 'package:usability_projekt/detail/widgets/widgets.dart';
import 'package:usability_projekt/home/widgets/library.dart';

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
  Color primaryBackgroundColor = blueColor;
  Color? primaryTextColor = null;

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
            backgroundColor: primaryBackgroundColor,
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
                  Navigator.pop(context, isFavorite);
                },
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(
                    !isFavorite
                        ? Ionicons.heart_outline
                        : Ionicons.heart,
                    color: !isFavorite ? Colors.white70 : Colors.red[600],
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
                      padding: const EdgeInsets.only(top: 20),
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
                              color: _isLightColor(primaryBackgroundColor)
                                  ? blackColor
                                  : null,
                            ),
                          ),
                          SizedBox(height: 32),
                          MetaRow(
                            sites: widget.book.umfang!,
                            textColor: _isLightColor(primaryBackgroundColor)
                                ? blackColor
                                : null,
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
                          color: blackColor,
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
                      SizedBox(height: 40),
                      Text(
                        'Informationen',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      InfoRow(
                        icon: Ionicons.barcode_sharp,
                        text: widget.book.isbn!,
                      ),
                      SizedBox(height: 20),
                      // author
                      InfoRow(
                        icon: Ionicons.person,
                        text: widget.book.autor!,
                      ),
                      SizedBox(height: 20),
                      // publish date
                      InfoRow(
                        icon: Ionicons.calendar,
                        text: widget.book.jahr!,
                      ),
                      SizedBox(height: 20),
                      // original title
                      InfoRow(
                        icon: Ionicons.bookmark,
                        text: widget.book.orginaltitel!,
                      ),
                      SizedBox(height: 20),
                      // anmerkung
                      InfoRow(
                        icon: Ionicons.pencil,
                        text: widget.book.anmerkung!,
                      ),
                      SizedBox(height: 20),
                      // interessenkreis
                      InfoRow(
                        icon: Ionicons.bookmark,
                        text: widget.book.interessenkreis!,
                      ),
                      SizedBox(height: 20),
                      // verlagsort
                      InfoRow(
                        icon: Ionicons.location,
                        text: widget.book.verlagsort!,
                      ),
                      // kopien
                      SizedBox(height: 40),
                      LocationsRow(
                        locations: widget.book.kopien!,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
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

  Future<void> _uploadPrimaryBackgroundColor() async {
    final Image image = Image.asset(widget.book.cover!);
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      image.image,
    );
    setState(() {
      primaryBackgroundColor = generator.mutedColor!.color;
    });
  }

  @override
  void initState() {
    _uploadPrimaryBackgroundColor();
    initFavoriteState();
    updateRecentBooks();
    super.initState();
  }

  bool _isLightColor(Color color) {
    return color.computeLuminance() > 0.5;
  }

  Future<void> initFavoriteState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> favorites =
        prefs.getStringList(favoritesKey) ?? <String>[];
    setState(() {
      isFavorite = favorites.contains(widget.book.isbn!);
    });
  }

  Future<void> updateRecentBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> recentBooks =
        prefs.getStringList(recentKey) ?? <String>[];
    if (recentBooks.contains(widget.book.isbn!)) {
      recentBooks.remove(widget.book.isbn!);
    }
    recentBooks.insert(0, widget.book.isbn!);
    await prefs.setStringList(recentKey, recentBooks);
  }

  Future<void> onFavoritePressed() async {
    setState(() {
      isFavorite = !isFavorite;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> favorites =
        prefs.getStringList(favoritesKey) ?? <String>[];
    if (isFavorite) {
      favorites.add(widget.book.isbn!);
    } else {
      favorites.remove(widget.book.isbn!);
    }
    await prefs.setStringList(favoritesKey, favorites);
    showSuccessSnackBar(
      context,
      message: isFavorite
          ? 'Buch wurde zu Favoriten hinzugefügt.'
          : 'Buch wurde aus Favoriten entfernt.',
    );
  }
}
