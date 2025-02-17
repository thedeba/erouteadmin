import 'package:erouteadmin/constants/constants.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {

  static final List<Widget> _navigationItem = <Widget>[
    HomePage(),
    Text('Search'),
    Text('Profile'),
  ];

  var selectedIndex=0;
  void onTabItem(index){
    setState(() {
      selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: MyAppBar(),
      body: _navigationItem[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabItem,
        currentIndex: selectedIndex,
        backgroundColor: Colors.grey[800],
        selectedItemColor: Colors.blueAccent,
        unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        showSelectedLabels: false,
        showUnselectedLabels: false,

        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
      ],
        
      ),
    );
  }
}
