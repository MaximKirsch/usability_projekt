import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usability_projekt/custom_chip.dart';
import 'package:usability_projekt/detail/detail_view.dart';
import 'package:usability_projekt/image_authors.dart';
import 'package:usability_projekt/image_title.dart';
import 'package:usability_projekt/library.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black,
              size: 40.0,
            ),
            Spacer(),
            Text(
              'Home',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.account_circle_sharp,
              color: Colors.black,
              size: 40.0,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                              Color.fromRGBO(240, 240, 240, 1.0),
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
                              color: Colors.grey[600],
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
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: suggestions.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(suggestions[index].titel!),
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
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Medienarten',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomChip(icon: Icons.book, text: 'Bücher'),
                    SizedBox(
                      width: 5.0,
                    ),
                    CustomChip(icon: Icons.games, text: 'Spiele'),
                    SizedBox(
                      width: 5.0,
                    ),
                    CustomChip(icon: Icons.movie, text: 'Filme')
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: const Row(
                  children: [
                    CustomChip(icon: Icons.album, text: 'CDs'),
                    SizedBox(
                      width: 5.0,
                    ),
                    CustomChip(
                      icon: Icons.library_books,
                      text: 'Zeitschriften',
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    CustomChip(icon: Icons.music_note, text: 'Noten'),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: const Row(
                  children: [
                    CustomChip(icon: Icons.smartphone, text: 'eMedien'),
                    SizedBox(
                      width: 5.0,
                    ),
                    CustomChip(icon: Icons.disc_full, text: 'CD/DVD-ROMs'),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
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
                child: Row(
                  children: library?.items
                          ?.take(10)
                          .map(
                            (e) => Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailView(book: e),
                                      ),
                                    );
                                  },
                                  child: ImageTitle(
                                    buchBild: AssetImage(e.cover!),
                                    text: e.titel!,
                                  ),
                                ),
                                const SizedBox(width: 20),
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
                ),
              ),
              const SizedBox(
                height: 15.0,
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
                child: Row(
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
                ),
              ),
            ],
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
