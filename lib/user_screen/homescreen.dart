// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dhanmondi_bus_name_screen.dart';
import 'mirpur_bus_name_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate item width based on screen width for responsive design
    double itemWidth = (screenWidth - 48) / 2; // 24 padding on each side

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7),
              buildRow(context, itemWidth, 'Mirpur', mirpurBusNameScreen(), 'Dhanmondi', dhanmondiBusNameScreen()),
              buildRow(context, itemWidth, 'Uttara', null, 'Tonggi', null),
              buildRow(context, itemWidth, 'Savar', null, 'Bypail', null),
              buildRow(context, itemWidth, 'Narayangonj', null, 'Mugdha', null),
              buildRow(context, itemWidth, 'Gazipur', null, 'Gulshan', null),
              buildRow(context, itemWidth, 'Mirpur', null, 'Dhanmondi', null),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(BuildContext context, double itemWidth, String leftText, Widget? leftScreen, String rightText, Widget? rightScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildItem(context, itemWidth, leftText, leftScreen),
        buildItem(context, itemWidth, rightText, rightScreen),
      ],
    );
  }

  Widget buildItem(BuildContext context, double itemWidth, String text, Widget? screen) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: screen != null
            ? () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          width: itemWidth,
          decoration: BoxDecoration(
            color: Colors.grey[700],
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[300], fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
