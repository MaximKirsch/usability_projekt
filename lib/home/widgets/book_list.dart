import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usability_projekt/common/constants.dart';
import 'package:usability_projekt/detail/detail_view.dart';
import 'package:usability_projekt/home/widgets/widgets.dart';

class BookList extends StatelessWidget {
  final Library library;
  final int limit;
  final ValueNotifier<int>? refresh;

  const BookList({
    required this.library,
    this.refresh,
    this.limit = 10,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: library.items
              ?.take(limit)
              .map(
                (e) => Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailView(book: e),
                          ),
                        );
                        refresh?.value++;
                      },
                      child: FutureBuilder(
                        future: isFavorite(e.isbn!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ImageTitle(
                              buchBild: AssetImage(e.cover!),
                              text: e.titel!,
                              isFavorite: snapshot.data as bool,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              )
              .toList() ??
          [
            Center(
              child: CircularProgressIndicator(
                color: Colors.grey[900],
              ),
            ),
          ],
    );
  }

  Future<bool> isFavorite(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(favoritesKey) ?? [];
    return favorites.contains(key);
  }
}
