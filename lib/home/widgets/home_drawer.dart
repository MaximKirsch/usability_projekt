import 'package:flutter/material.dart';
import 'package:usability_projekt/common/colors.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  Color iconColor = orangeColor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: greyWhiteColor,
      surfaceTintColor: blackColor,
      shadowColor: greyMidColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListView(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: iconColor,
              size: 30.0,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: blackColor,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book,
              color: iconColor,
              size: 30.0,
            ),
            title: Text(
              'Bücher',
              style: TextStyle(
                color: blackColor,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.games,
              color: iconColor,
              size: 30.0,
            ),
            title: Text(
              'Spiele',
              style: TextStyle(
                color: blackColor,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.movie,
              color: iconColor,
              size: 30.0,
            ),
            title: Text(
              'Filme',
              style: TextStyle(
                color: blackColor,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.album,
              color: iconColor,
              size: 30.0,
            ),
            title: Text(
              'CDs',
              style: TextStyle(
                color: blackColor,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.library_books,
              color: iconColor,
              size: 30.0,
            ),
            title: Text(
              'Zeitschriften',
              style: TextStyle(
                color: blackColor,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.music_note,
              color: iconColor,
              size: 30.0,
            ),
            title: Text(
              'Noten',
              style: TextStyle(
                color: blackColor,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
