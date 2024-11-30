import 'package:erouteadmin/user_screen/tile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class LiveFacultyBus extends StatefulWidget {
  const LiveFacultyBus({super.key});

  @override
  State<LiveFacultyBus> createState() => _LiveFacultyBusState();
}

class _LiveFacultyBusState extends State<LiveFacultyBus> {
  final dbRef = FirebaseDatabase.instance.ref('Faculty_Bus');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Intercept the back button press
      onWillPop: () async {
        // When back button is pressed, update pageNotifier to "Faculty" to show InkWell again
        pageNotifier.value = "Faculty"; // Make InkWell visible again
        return true; // Allow the pop to happen
      },
      child: Scaffold(
        appBar: myAppBar,
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (context, snapshot, animation, index) {
                  String busName = snapshot.child('Bus_Name').value.toString();
                  String busRoute = snapshot.child('Bus_Route').value.toString();
                  int initialRemainingTime = snapshot.child('timer').value as int? ?? 0;

                  // Pass the bus details and remaining time to the Tile widget
                  return Tile(
                    name: busName,
                    route: busRoute,
                    remainingTime: initialRemainingTime,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
