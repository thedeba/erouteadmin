import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NameTile extends StatefulWidget {
  final String name;
  final String route;
  final Function(BuildContext)? deleteFunction;
  final DocumentReference documentReference;

  const NameTile({
    Key? key,
    required this.name,
    required this.route,
    this.deleteFunction,
    required this.documentReference,
  }) : super(key: key);

  @override
  State<NameTile> createState() => _NameTileState();
}

class _NameTileState extends State<NameTile> {
  late Timer _timer;
  int _secondsRemaining = 630;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel(); // Cancel the timer when it reaches 0
          // Automatically delete the tile when timer reaches zero
          if (widget.deleteFunction != null) {
            widget.deleteFunction!(context);
          }
        }
      });
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          if (widget.deleteFunction != null) {
            widget.deleteFunction!(context);
            // Delete the Firestore document when timer reaches 0
            widget.documentReference.delete();
          }
        }
      });
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
              GestureDetector(
                onTap: () {
                  // Implement custom time setting if needed
                },
                child: Container(
                  child: Column(
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
                ),
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
