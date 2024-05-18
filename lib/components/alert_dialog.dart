import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? message;
  const CustomAlertDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 50),
      backgroundColor: Colors.grey[800],
      title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Alert',
            style: TextStyle(color: Colors.red),
          )),
      content: Text(message ?? '', style: TextStyle(color: Colors.grey[200])),
      actions: [
        const SizedBox(
          height: 40,
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 9,
                backgroundColor: Colors.grey[900]),
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.grey[200]),
            ))
      ],
    );
  }
}
