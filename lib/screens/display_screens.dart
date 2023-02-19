import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'export_screens.dart';

class DisplayScreens extends StatefulWidget {
  const DisplayScreens({super.key});

  @override
  State<DisplayScreens> createState() => _DisplayScreensState();
}

class _DisplayScreensState extends State<DisplayScreens> {
  int _currentIndex = 0;
  List<Widget> navList = const [
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: navList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 18,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green.shade600,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            activeIcon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            activeIcon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bars),
              activeIcon: FaIcon(FontAwesomeIcons.bars),
              label: 'Library'),
        ],
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
