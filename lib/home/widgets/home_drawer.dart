import 'package:flutter/material.dart';
import 'package:usability_projekt/common/colors.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {


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
              color: orangeColor,
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
        ],
      ),
    );
  }
}
