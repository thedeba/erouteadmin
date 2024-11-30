import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:erouteadmin/components/assigning_dialog.dart';
import 'package:erouteadmin/components/name_tile.dart';

class StudentBusService extends StatefulWidget {
  const StudentBusService({Key? key}) : super(key: key);

  @override
  State<StudentBusService> createState() => _StudentBusServiceState();
}

class _StudentBusServiceState extends State<StudentBusService> {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Student_Bus');
  TextEditingController busController = TextEditingController();
  TextEditingController busRouteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Student Bus Service'),
        backgroundColor: Colors.blueGrey[900],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        onPressed: assignNewBus,
        child: Icon(CupertinoIcons.add, color: Colors.grey[400]),
      ),
      body: FirebaseAnimatedList(
        query: databaseRef,
        itemBuilder: (context, snapshot, animation, index) {
          // Retrieve data from Firebase
          String busName = snapshot.child('Bus_Name').value.toString();
          String busRoute = snapshot.child('Bus_Route').value.toString();
          String? endTimeString = snapshot.child('End_Timestamp').value as String?;

          if (busName.isEmpty || busRoute.isEmpty || endTimeString == null) {
            return const SizedBox();
          }

          // Calculate remaining time using the stored End_Timestamp
          DateTime endTime = DateTime.parse(endTimeString);
          int remainingTime = endTime.difference(DateTime.now()).inSeconds;

          // If time has expired, delete the entry
          if (remainingTime <= 0) {
            deleteAssignedBus(busName);
            return const SizedBox();
          }

          return NameTile(
            name: busName,
            route: busRoute,
            remainingTime: remainingTime,
            deleteFunction: (context) => deleteAssignedBus(busName),
          );
        },
      ),
    );
  }

  /// Assign a new bus with a countdown timer
  void assignBus(int countdownInSeconds) async {
    String busName = busController.text.trim();
    String busRoute = busRouteController.text.trim();

    if (busName.isNotEmpty && busRoute.isNotEmpty) {
      try {
        DateTime endTime = DateTime.now().add(Duration(seconds: countdownInSeconds));

        // Save bus details and end timestamp in Firebase
        await databaseRef.child(busName).set({
          'Bus_Name': busName,
          'Bus_Route': busRoute,
          'End_Timestamp': endTime.toIso8601String(),
        });

        Fluttertoast.showToast(
          msg: "Bus assigned successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        print("Error assigning bus: $e");
        Fluttertoast.showToast(
          msg: "Failed to assign bus",
          backgroundColor: Colors.red,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please fill in all fields",
        backgroundColor: Colors.orange,
      );
    }

    busController.clear();
    busRouteController.clear();
  }

  /// Open dialog to assign a new bus
  void assignNewBus() {
    showDialog(
      context: context,
      builder: (context) {
        return AssigningDialog(
          busNamecontroller: busController,
          placeNamecontroller: busRouteController,
          onOK: () {
            int selectedTime = 600; // Example: 10 minutes in seconds
            assignBus(selectedTime);
            Navigator.of(context).pop();
          },
          onExit: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  /// Delete a bus from Firebase
  void deleteAssignedBus(String busName) async {
    await databaseRef.child(busName).remove().then((_) {
      Fluttertoast.showToast(
        msg: "Deleted successfully",
        backgroundColor: Colors.red,
      );
    }).catchError((error) {
      print("Error deleting item: $error");
      Fluttertoast.showToast(msg: "Failed to delete bus");
    });
  }
}
