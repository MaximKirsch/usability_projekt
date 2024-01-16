import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usability_projekt/detailScreen.dart';
import 'package:usability_projekt/image_authors.dart';
import 'package:usability_projekt/library.dart';

import 'custom_chip.dart';
import 'image_title.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    ));

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController nutzerEingabe = TextEditingController();
  Library? library;
  List<String> suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
                        builder: (BuildContext context,
                            SearchController controller) {
                          return SearchBar(
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(12),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromRGBO(235, 235, 234, 1.0)),
                            controller: controller,
                            padding: MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 16.0)),
                            hintText: 'Titel, Autor, Begriff, ISBN, Jahr',
                            onChanged: (input) {
                              setState(() {
                                suggestions.clear();
                                suggestions = _getSuggestions(input);
                                controller.openView();
                              });
                            },
                            leading: Icon(Icons.search),
                          );
                        },
                        suggestionsBuilder: (BuildContext context,
                            SearchController controller) {
                          return suggestions
                              .map((e) => ListTile(
                                    title: Text(e),
                                    onTap: () {
                                      setState(() {
                                        controller.closeView(e);
                                      });
                                    },
                                  ))
                              .toList();
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
                        icon: Icons.library_books, text: 'Zeitschriften'),
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
                                                DetailScreen(book: e)));
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
                        autorBild: AssetImage('assets/autoren/erhard.jpeg')),
                    ImageAuthors(
                        autorBild:
                            AssetImage('assets/autoren/George_Orwell.jpg')),
                    ImageAuthors(
                        autorBild: AssetImage('assets/autoren/JK.jpg')),
                    ImageAuthors(
                        autorBild:
                            AssetImage('assets/autoren/John_Katzenbach.jpg')),
                    ImageAuthors(
                        autorBild:
                            AssetImage('assets/autoren/Sascha_Feuchert.jpg')),
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

  List<String> _getSuggestions(String input) {
    List<String> suggestionList = [];
    if (library != null && library!.items != null) {
      for (var item in library!.items!) {
        if (item.titel!.toLowerCase().contains(input.toLowerCase()) ||
            item.autor!.toLowerCase().contains(input.toLowerCase()) ||
            item.isbn!.toLowerCase().contains(input.toLowerCase()) ||
            item.jahr!.toLowerCase().contains(input.toLowerCase())) {
          suggestionList.add(item.titel!);
        }
      }
    }

    return suggestionList;
  }
}
