import 'package:flutter/material.dart';
import 'package:recipe_checked/pages/favourites.dart';
import 'package:recipe_checked/pages/homepage.dart';
import 'package:recipe_checked/pages/store.dart';
import 'package:recipe_checked/utils/constants.dart';

class Navbar extends StatefulWidget {
  int selectedIndex;

  Navbar({super.key, this.selectedIndex = 1});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final double iconSize = 30;

  final List<Widget> _pages = [
    const Favourites(),
    const Homepage(),
    const Store()
  ];

  void onTappedBar(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  Future printUsername() async {
    // var currentUserID =
    // await AuthenticationController().getCurrUserFromFirestore();
    //var currentUserID = await AuthenticationController().getCurrUserFromFirebase();
    //print('Username is: ' + currentUserID.displayName + '' + currentUserID.email + '' + currentUserID.uid);
    // print('Username is ' + currentUserID);
  }

  @override
  Widget build(BuildContext context) {
    printUsername();

    return Scaffold(
      body: _pages[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          selectedItemColor: kOrange,
          onTap: onTappedBar,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite,
                    size: iconSize,
                    color: Theme.of(context).colorScheme.secondary),
                label: 'Favourites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo,
                    size: iconSize,
                    color: Theme.of(context).colorScheme.secondary),
                label: 'Upload Ingredients'),
            BottomNavigationBarItem(
                icon: Icon(Icons.kitchen,
                    size: iconSize,
                    color: Theme.of(context).colorScheme.secondary),
                label: 'Store')
          ]),
    );
  }
}
