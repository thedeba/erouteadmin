import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_database/firebase_database.dart';

class NameTile extends StatefulWidget {
  final String name;
  final String route;
  final int remainingTime;
  final Function(BuildContext)? deleteFunction;

  const NameTile({
    Key? key,
    required this.name,
    required this.route,
    required this.remainingTime,
    this.deleteFunction,
  }) : super(key: key);

  @override
  State<NameTile> createState() => _NameTileState();
}

class _NameTileState extends State<NameTile> {
  late Timer _timer;
  int _secondsRemaining;
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref('Student_Bus');

  _NameTileState() : _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.remainingTime;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });

        // Update the remaining time in Firebase
        await dbRef.child(widget.name).update({
          'Remaining_Time': _secondsRemaining,
        });
      } else {
        _timer.cancel();

        // Delete the bus entry when the timer reaches zero
        await dbRef.child(widget.name).remove();

        // Call delete function if provided
        if (widget.deleteFunction != null) {
          widget.deleteFunction!(context);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.auto_delete,
              backgroundColor: Colors.red.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            border: Border.all(),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.bus,
                    color: Colors.blueAccent[400],
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Within',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    '${_secondsRemaining ~/ 60} : ${_secondsRemaining % 60}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_road,
                    color: Colors.green[400],
                    size: 30,
                  ),
                  Text(
                    widget.route,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
