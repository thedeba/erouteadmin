import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var MyAppBar = AppBar(
  title: const Text('eRouteAdmin'),
  titleTextStyle: const TextStyle(letterSpacing: 5),
  actions: [
    IconButton(
        onPressed: () {
          print('tapped');
        },
        icon: Icon(
          CupertinoIcons.text_alignright,
          color: Colors.grey[300],
        ))
  ],
);
