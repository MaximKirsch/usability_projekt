import 'dart:async';

import 'package:flutter/material.dart';
import 'package:usability_projekt/common/colors.dart';
import 'package:usability_projekt/detail/detail_view.dart';
import 'package:usability_projekt/home/widgets/widgets.dart';

class HomeSearchBar extends StatefulWidget {
  final Library? library;

  const HomeSearchBar({
    required this.library,
    Key? key,
  }) : super(key: key);

  @override
  _HomeSearchBarState createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  List<String> searchFilterTypes = [];
  SearchController searchController = SearchController();
  StreamController<List<Items>> streamController = StreamController.broadcast();
  List<Items> suggestions = [];

  @override
  void initState() {
    _handleSearchEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      viewTrailing: [],
      isFullScreen: true,
      searchController: searchController,
      builder: (
        BuildContext context,
        SearchController controller,
      ) {
        return SearchBar(
          onTap: () {
            searchController.openView();
          },
          elevation: MaterialStatePropertyAll<double>(0.0),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12),
              side: BorderSide(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll<Color>(
            greyWhiteColor,
          ),
          padding: MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 10.0),
          ),
          hintText: 'Titel, Autor, Begriff, ISBN, Jahr',
          hintStyle: MaterialStatePropertyAll<TextStyle>(
            TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
          leading: Icon(
            Icons.search,
            color: blackColor,
          ),
        );
      },
      suggestionsBuilder: (context, controller) {
        return [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              14.0,
              0.0,
              14.0,
              14.0,
            ),
            child: Wrap(
              spacing: 10,
              children: [
                CustomChip(
                  icon: Icons.book,
                  text: 'Bücher',
                  onPressed: () {
                    setState(() {
                      updateSearchFilter('books');
                    });
                  },
                  active: _isSearchFilterActive('books'),
                ),
                CustomChip(
                  icon: Icons.games,
                  text: 'Spiele',
                  onPressed: () {
                    setState(() {
                      updateSearchFilter('games');
                    });
                  },
                  active: _isSearchFilterActive('games'),
                ),
                CustomChip(
                  icon: Icons.movie,
                  text: 'Filme',
                  onPressed: () {
                    setState(() {
                      updateSearchFilter('movie');
                    });
                  },
                  active: _isSearchFilterActive('movie'),
                ),
                CustomChip(
                  icon: Icons.album,
                  text: 'CDs',
                  onPressed: () {
                    setState(() {
                      updateSearchFilter('cd');
                    });
                  },
                  active: _isSearchFilterActive('cd'),
                ),
                CustomChip(
                  icon: Icons.library_books,
                  text: 'Zeitschriften',
                  onPressed: () {
                    setState(() {
                      updateSearchFilter('newspaper');
                    });
                  },
                  active: _isSearchFilterActive('newspaper'),
                ),
                CustomChip(
                  icon: Icons.smartphone,
                  text: 'eMedien',
                  onPressed: () {
                    setState(() {
                      updateSearchFilter('media');
                    });
                  },
                  active: _isSearchFilterActive('media'),
                ),
                CustomChip(
                  icon: Icons.disc_full,
                  text: 'CD/DVD-ROMs',
                  onPressed: () {
                    setState(() {
                      updateSearchFilter('cd');
                    });
                  },
                  active: _isSearchFilterActive('cd'),
                ),
                searchFilterTypes.isEmpty
                    ? Container()
                    : CustomChip(
                        icon: Icons.clear,
                        text: 'Filter löschen',
                        onPressed: () {
                          setState(() {
                            searchFilterTypes.clear();
                          });
                        },
                        ignoreSelection: true,
                      ),
              ],
            ),
          ),
          StreamBuilder(
            initialData: widget.library!.items!,
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        suggestions[index].titel!,
                      ),
                      horizontalTitleGap: 16.0,
                      minVerticalPadding: 24.0,
                      leading: Image.asset(
                        suggestions[index].cover!,
                        width: 50,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailView(
                              book: suggestions[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
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
        ];
      },
    );
  }

  void _handleSearchEvents() {
    searchController.addListener(() {
      setState(() {
        _loadSuggestions(searchController.text);
      });
    });
  }

  void updateSearchFilter(String filter) {
    if (searchFilterTypes.contains(filter)) {
      searchFilterTypes.remove(filter);
    } else {
      searchFilterTypes.add(filter);
    }
    _loadSuggestions(searchController.text);
  }

  bool _isSearchFilterActive(String filter) {
    return searchFilterTypes.contains(filter);
  }

  Future<void> _loadSuggestions(String input) async {
    List<Items> suggestionList = [];
    if (widget.library != null && widget.library!.items != null) {
      if (input.isEmpty) {
        // return all items
        suggestionList = widget.library!.items!;
      } else {
        // search for query
        for (final item in widget.library!.items!) {
          if (item.titel!.toLowerCase().contains(input.toLowerCase()) ||
              item.autor!.toLowerCase().contains(input.toLowerCase()) ||
              item.isbn!.toLowerCase().contains(input.toLowerCase()) ||
              item.jahr!.toLowerCase().contains(input.toLowerCase())) {
            suggestionList.add(item);
          }
        }
      }
    }
    suggestionList = suggestionList.where((element) {
      if (searchFilterTypes.isEmpty) {
        return true;
      } else {
        return searchFilterTypes.contains(element.type!);
      }
    }).toList();
    setState(() {
      suggestions = suggestionList;
    });
    streamController.add(suggestions);
    return Future.value();
  }
}
