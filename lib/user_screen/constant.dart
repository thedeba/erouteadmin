import 'package:flutter/material.dart';
import 'package:erouteadmin/pages/auth_page.dart';
import 'live_faculty_bus.dart'; // Assuming this is already defined elsewhere

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final ValueNotifier<String> pageNotifier = ValueNotifier<String>("Faculty");

var myAppBar = AppBar(
  backgroundColor: Colors.grey[800],
  title: const Text('eRoute'),
  titleTextStyle: TextStyle(
    color: Colors.grey[400],
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  ),
  actions: [
    ValueListenableBuilder(
      valueListenable: pageNotifier,
      builder: (context, value, child) {
        return InkWell(
          onTap: value.isNotEmpty
              ? () {
            // Toggle between Faculty and Student pages
            if (value == "Faculty") {
              pageNotifier.value = ""; // Hide the InkWell
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (context) => const LiveFacultyBus()),
              );
            }
          }
              : null, // Disable onTap when the value is empty
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        );
      },
    ),
    TextButton(
      onPressed: () {
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => const AuthPage()),
        );
      },
      child: Icon(Icons.person, color: Colors.grey[400]),
    ),
  ],
);