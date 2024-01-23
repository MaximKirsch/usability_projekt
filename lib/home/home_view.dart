import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:usability_projekt/common/colors.dart';
import 'package:usability_projekt/common/constants.dart';
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
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ColoredBox(
          color: whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HomeSearchBar(
                  library: library,
                ),
              ),
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
                      library: library ?? Library(),
                      refresh: refresh,
                    );
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
              const SizedBox(
                height: 32.0,
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
}
