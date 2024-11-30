import 'dart:async';
import 'package:erouteadmin/components/assigning_dialog.dart';
import 'package:erouteadmin/components/name_tile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/constants.dart';

class FacultyBusService extends StatefulWidget {
  const FacultyBusService({Key? key}) : super(key: key);

  @override
  State<FacultyBusService> createState() => _FacultyBusServiceState();
}

class _FacultyBusServiceState extends State<FacultyBusService> {
  // Creating database reference for the buses
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Faculty_Bus');

  TextEditingController busController = TextEditingController();
  TextEditingController busRouteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> assignBus() async {
    if (busController.text.isNotEmpty && busRouteController.text.isNotEmpty) {
      String busName = busController.text;
      DateTime now = DateTime.now();

      // Set bus details in Realtime Database using bus name as key
      await databaseRef.child(busName).set({
        'Bus_Name': busName,
        'Bus_Route': busRouteController.text,
        'Timestamp': now.toUtc().millisecondsSinceEpoch,
        'timer': 600, // Initial timer of 10 minutes in seconds
      });

      Fluttertoast.showToast(
        msg: "Added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Fields were empty',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    busController.clear();
    busRouteController.clear();
  }

  void assignNewBus() {
    showDialog(
      context: context,
      builder: (context) {
        return AssigningDialog(
          busNamecontroller: busController,
          placeNamecontroller: busRouteController,
          onOK: () {
            assignBus();
            Navigator.of(context).pop();
          },
          onExit: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteAssignedBus(String busName) async {
    await databaseRef.child(busName).remove().then((_) {
      Fluttertoast.showToast(
        msg: "Deleted successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }).catchError((error) {
      Fluttertoast.showToast(msg: 'Failed to delete item');
      print("Error deleting item: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: MyAppBar(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.grey[800],
        onPressed: assignNewBus,
        child: Icon(
          CupertinoIcons.add,
          color: Colors.grey[400],
          size: 30,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseRef,
              itemBuilder: (context, snapshot, animation, index) {
                String busName = snapshot.child('Bus_Name').value.toString();
                String busRoute = snapshot.child('Bus_Route').value.toString();
                int remainingTime = snapshot.child('timer').value as int? ?? 0;

                return NameTile(
                  name: busName,
                  route: busRoute,
                  remainingTime: remainingTime,
                  deleteFunction: (context) => deleteAssignedBus(busName),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
