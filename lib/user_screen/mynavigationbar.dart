import 'package:flutter/material.dart';

import 'constant.dart';
import 'homescreen.dart';
import 'liveassignedbus.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({
    super.key,
  });

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  static final List<Widget> _bottomOptions = <Widget>[
    const HomeScreen(),
    const LiveAssignedBus(),
    const Text('Search'),
  ];

  int _selectedIndex = 0;

  void _onItemTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        body: _bottomOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTap,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.grey[800],
          selectedItemColor: Colors.blueAccent,
          unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live'),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
          ],
        ));
  }
}
