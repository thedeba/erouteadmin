import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String? Name;
  final VoidCallback? onPressed;
  const MyButton({super.key, required this.Name, required this.onPressed});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50,),
            backgroundColor: Colors.grey[800],
            side: BorderSide(
              color: Colors.grey.shade600
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            )
          ),
          child: Text(
            widget.Name ?? '',
            style:
                TextStyle(color: Colors.grey[400],fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
