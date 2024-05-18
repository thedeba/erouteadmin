import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erouteadmin/components/assigning_dialog.dart';
import 'package:erouteadmin/components/name_tile.dart';
import 'package:erouteadmin/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FacultyBusService extends StatefulWidget {
  const FacultyBusService({Key? key});

  @override
  State<FacultyBusService> createState() => _FacultyBusServiceState();
}

class _FacultyBusServiceState extends State<FacultyBusService> {
  // Creating database references
  final DatabaseReference databaseRef =
  FirebaseDatabase.instance.ref('Faculty_Bus');
  final CollectionReference<Map<String, dynamic>> _timerRef =
  FirebaseFirestore.instance.collection('timers');

  TextEditingController busController = TextEditingController();
  TextEditingController busRouteController = TextEditingController();

  void _onOk() {
    assignBus();
  }

  void _onExit() {
    Navigator.of(context).pop();
  }

  void assignBus() async {
    if (busController.text.isNotEmpty && busRouteController.text.isNotEmpty) {
      String key = databaseRef.push().key!; // Generate a unique key
      DateTime now = DateTime.now();
      await databaseRef.child(key).set({
        'Bus_Name': busController.text,
        'Bus_Route': busRouteController.text,
        'Timestamp': now.toUtc().millisecondsSinceEpoch, // Add timestamp
      });
      updateTimer(key); // Start the timer countdown for this bus

      Fluttertoast.showToast(
        msg: "Added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
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
    Navigator.of(context).pop();
  }



  void assignNewBus() {
    showDialog(
      context: context,
      builder: (context) {
        return AssigningDialog(
          busNamecontroller: busController,
          placeNamecontroller: busRouteController,
          onOK: _onOk,
          onExit: _onExit,
        );
      },
    );
  }

  void deleteAssignedBus(String key) async {
    databaseRef.child(key).remove().then((_) {
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

  // Method to update the timer countdown in Firestore
  void updateTimer(String key) {
    DocumentReference<Map<String, dynamic>> documentRef = _timerRef.doc(key);

    documentRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        Timer.periodic(Duration(seconds: 1), (timer) {
          int timestamp = docSnapshot['Timestamp']; // Get timestamp from Firestore
          int currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;
          int elapsedTime = (currentTime - timestamp) ~/ 1000; // Convert milliseconds to seconds
          int remainingTime = 600 - elapsedTime; // 10 minutes = 600 seconds

          if (remainingTime <= 0) {
            // Timer expired, delete the tile and cancel the timer
            documentRef.delete().then((_) {
              timer.cancel();
            }).catchError((error) {
              print("Error deleting document: $error");
            });
          }

          documentRef.update({
            'timer': remainingTime, // Update remaining time in Firestore
          }).then((_) {
            // Timer updated successfully
          }).catchError((error) {
            print("Error updating timer: $error");
            timer.cancel(); // Cancel the timer if there's an error
          });
        });
      } else {
        print("Document does not exist in Firestore for key: $key");
      }
    }).catchError((error) {
      print("Error fetching document from Firestore: $error");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: MyAppBar,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
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
                String key = snapshot.key!;
                DocumentReference<Map<String, dynamic>> documentReference =
                _timerRef.doc(key);
                return NameTile(
                  name: snapshot.child('Bus_Name').value.toString(),
                  route: snapshot.child('Bus_Route').value.toString(),
                  deleteFunction: (context) => deleteAssignedBus(key),
                  documentReference: documentReference,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
