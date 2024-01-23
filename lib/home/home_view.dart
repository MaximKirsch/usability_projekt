import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:usability_projekt/common/colors.dart';
import 'package:usability_projekt/common/constants.dart';
import 'package:usability_projekt/detail/detail_view.dart';
import 'package:usability_projekt/home/widgets/book_list.dart';
import 'package:usability_projekt/home/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController nutzerEingabe = TextEditingController();
  Library? library;
  List<Items> suggestions = [];
  SearchController searchController = SearchController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<int> refresh = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: HomeDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Transform.flip(
          flipX: true,
          flipY: true,
          child: IconButton(
            icon: Icon(
              UniconsLine.list_ui_alt,
              color: orangeColor,
              size: 30.0,
            ),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            tooltip: 'Menü',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Ionicons.person_circle,
              color: orangeColor,
              size: 40.0,
            ),
          ),
        ],
        title: Text(
          'Home',
          style: TextStyle(
            color: blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 48),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 350,
                      height: 70.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SearchAnchor(
                          isFullScreen: false,
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
                              shape: MaterialStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(12),
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
                              FutureBuilder(
                                future: Future.delayed(
                                  const Duration(seconds: 1),
                                  () => suggestions,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Text(
                                          'Vorschläge',
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: suggestions.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title:
                                                  Text(suggestions[index].titel!),
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
                                                    builder: (context) =>
                                                        DetailView(
                                                      book: suggestions[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
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
                        ),
                      ),
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Text(
                //   'Medienarten',
                //   style: TextStyle(
                //     fontSize: 22.0,
                //     color: Colors.black,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(
                //   height: 15.0,
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   child: const Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       CustomChip(icon: Icons.book, text: 'Bücher'),
                //       SizedBox(
                //         width: 5.0,
                //       ),
                //       CustomChip(icon: Icons.games, text: 'Spiele'),
                //       SizedBox(
                //         width: 5.0,
                //       ),
                //       CustomChip(icon: Icons.movie, text: 'Filme')
                //     ],
                //   ),
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   padding: EdgeInsets.only(top: 15.0),
                //   child: Row(
                //     children: [
                //       CustomChip(icon: Icons.album, text: 'CDs'),
                //       SizedBox(
                //         width: 5.0,
                //       ),
                //       CustomChip(
                //         icon: Icons.library_books,
                //         text: 'Zeitschriften',
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   padding: EdgeInsets.only(top: 15.0),
                //   child: const Row(
                //     children: [
                //       CustomChip(icon: Icons.smartphone, text: 'eMedien'),
                //       SizedBox(
                //         width: 5.0,
                //       ),
                //       CustomChip(icon: Icons.disc_full, text: 'CD/DVD-ROMs'),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 32.0,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Row(
                    children: [
                      Text(
                        'Aktuelle Bücher-Trends',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ValueListenableBuilder(
                    valueListenable: refresh,
                    builder: (BuildContext context, int value, Widget? child) {
                      return BookList(
                          library: library ?? Library(), refresh: refresh);
                    },
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Text(
                  'Top-Autoren',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AuthorsList(),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                const Text(
                  'Zuletzt angesehen',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ValueListenableBuilder(
                    valueListenable: refresh,
                    builder: (BuildContext context, int value, Widget? child) {
                      return FutureBuilder(
                        future: _getRecentlyViewed(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return BookList(
                              library: snapshot.data as Library,
                              refresh: refresh,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Library> _getLibrary() async {
    String json = await rootBundle.loadString('assets/dummydata.json');
    return libraryFromJson(json);
  }

  @override
  void initState() {
    _handleSearchEvents();
    _getLibrary().then(
      (library) => {
        setState(() {
          this.library = library;
          this.library?.items?.shuffle();
        })
      },
    );
    super.initState();
  }

  void _handleSearchEvents() {
    searchController.addListener(() {
      setState(() {
        suggestions = _getSuggestions(searchController.text);
      });
    });
  }

  Future<Library> _getRecentlyViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recentlyViewed = prefs.getStringList(recentKey) ?? [];
    var lib = Library(
      items: library?.items
          ?.where((item) => recentlyViewed.contains(item.isbn!))
          .toList(),
    );
    return lib;
  }

  List<Items> _getSuggestions(String input) {
    List<Items> suggestionList = [];
    if (library != null && library!.items != null) {
      for (final item in library!.items!) {
        if (item.titel!.toLowerCase().contains(input.toLowerCase()) ||
            item.autor!.toLowerCase().contains(input.toLowerCase()) ||
            item.isbn!.toLowerCase().contains(input.toLowerCase()) ||
            item.jahr!.toLowerCase().contains(input.toLowerCase())) {
          suggestionList.add(item);
        }
      }
    }
    return suggestionList;
  }
}
