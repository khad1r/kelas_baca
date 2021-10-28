import 'package:flutter/material.dart';
import './student_home.dart';

// 1
class StudentApp extends StatefulWidget {
  @override
  _StudentAppState createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> {
  // 7
  int _selectedIndex = 0;

  // 8
  static List<Widget> pages = <Widget>[
    StudentHome(),
  ];

  // 9
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      // 4
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: Theme.of(context).textTheme.bodyText1,
        unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
        // 5
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        // 10
        currentIndex: _selectedIndex,
        // 11
        onTap: _onItemTapped,
        // 6
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
