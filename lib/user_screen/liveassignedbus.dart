import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'tile.dart';

class LiveAssignedBus extends StatefulWidget {
  const LiveAssignedBus({super.key});

  @override
  State<LiveAssignedBus> createState() => _LiveAssignedBusState();
}

class _LiveAssignedBusState extends State<LiveAssignedBus> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref('Student_Bus');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Live Assigned Buses'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: FirebaseAnimatedList(
        query: dbRef,
        itemBuilder: (context, snapshot, animation, index) {
          if (snapshot.value == null) {
            print("Snapshot value is null");
            return const SizedBox.shrink();
          }

          // Debug: Print the raw snapshot data
          print("Snapshot: ${snapshot.value}");

          // Use the `as Map` cast to safely access the data if it's a Map
          Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

          // Check if the data map is null or missing keys
          if (data == null) {
            print("Data map is null");
            return const SizedBox.shrink();
          }

          // Retrieve data with null checks
          String? busName = data['Bus_Name']?.toString();
          String? busRoute = data['Bus_Route']?.toString();
          int? remainingTime = int.tryParse(data['Remaining_Time']?.toString() ?? '0');

          // Debug: Print individual values
          print("Bus Name: $busName, Bus Route: $busRoute, Remaining Time: $remainingTime");

          // Ensure values are not null
          if (busName == null || busRoute == null || remainingTime == null) {
            print("One of the values is null. Skipping entry.");
            return const SizedBox.shrink();
          }

          // Build the Tile widget to display bus information
          return Tile(
            name: busName,
            route: busRoute,
            remainingTime: remainingTime,
          );
        },
      ),
    );
  }
}
