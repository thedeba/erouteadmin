import 'package:erouteadmin/components/mytext_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssigningDialog extends StatefulWidget {
  final busNamecontroller;
  final placeNamecontroller;
  VoidCallback onOK;
  VoidCallback onExit;

  AssigningDialog({
    super.key,
    this.busNamecontroller,
    this.placeNamecontroller,
    required this.onOK,
    required this.onExit,
  });

  @override
  State<AssigningDialog> createState() => _AssigningDialogState();
}

class _AssigningDialogState extends State<AssigningDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 170),
      child: SingleChildScrollView(
        child: AlertDialog(
          scrollable: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .02),
          title: const Center(child: Text('Assign Bus')),
          titleTextStyle: TextStyle(
              color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 26),
          titlePadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: Colors.grey[900],
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: widget.onExit,
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
                TextButton(
                  onPressed: widget.onOK,
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
          ],
          content: Column(
            children: [
              MyTextField(
                obscureText: false,
                hintText: 'Bus name',
                controller: widget.busNamecontroller,
              ),
              MyTextField(
                obscureText: false,
                hintText: 'Route',
                controller: widget.placeNamecontroller,
              )
            ],
          ),
        ),
      ),
    );
  }
}
