import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_chip.dart';
import 'image_title.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: suchFunktion(),
    ));

class suchFunktion extends StatefulWidget {
  @override
  State<suchFunktion> createState() => _suchFunktionState();
}

class _suchFunktionState extends State<suchFunktion> {
  final TextEditingController nutzerEingabe = TextEditingController();

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
      body: Padding(
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
                                Color.fromRGBO(229, 229, 234, 1.0)),
                            controller: controller,
                            padding: MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 16.0)),
                            hintText: 'Titel, Autor, Begriff, ISBN, Jahr',
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              controller.openView();
                            },
                            leading: Icon(Icons.search),
                            trailing: <Widget>[],
                          );
                        },
                        suggestionsBuilder: (BuildContext context,
                            SearchController controller) {
                          return List<ListTile>.generate(5, (int index) {
                            final String item = 'item $index';
                            return ListTile(
                              title: Text(item),
                              onTap: () {
                                setState(() {
                                  controller.closeView(item);
                                });
                              },
                            );
                          });
                        }),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Medienarten',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomChip(icon: Icons.book, text: 'Bücher'),
                  SizedBox(
                    width: 8.0,
                  ),
                  CustomChip(icon: Icons.games, text: 'Spiele'),
                  SizedBox(
                    width: 8.0,
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
                    width: 8.0,
                  ),
                  CustomChip(icon: Icons.library_books, text: 'Zeitschriften'),
                  SizedBox(
                    width: 8.0,
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
                    width: 8.0,
                  ),
                  CustomChip(icon: Icons.disc_full, text: 'CD/DVD-ROMs'),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: const Row(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Aktuelle Bücher-Trends',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ImageTitle(
                      buchBild: AssetImage('assets/book1_loss-of-reason.jpg'),
                      text: 'LOSS OF REASON'),
                  SizedBox(
                    width: 20.0,
                  ),
                  ImageTitle(
                      buchBild: AssetImage('assets/book1_loss-of-reason.jpg'),
                      text: 'LOSS OF REASON'),
                  SizedBox(
                    width: 20.0,
                  ),
                  ImageTitle(
                      buchBild: AssetImage('assets/book1_loss-of-reason.jpg'),
                      text: 'LOSS OF REASON'),
                  SizedBox(
                    width: 20.0,
                  ),
                  ImageTitle(
                      buchBild: AssetImage('assets/book1_loss-of-reason.jpg'),
                      text: 'LOSS OF REASON'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
