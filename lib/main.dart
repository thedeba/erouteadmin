import 'package:erouteadmin/firebase_options.dart';
import 'package:erouteadmin/user_screen/constant.dart';
import 'package:erouteadmin/user_screen/mynavigationbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eRoute',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 9,
          //shadowColor: Colors.grey[300],
          color: Colors.grey[800],
          titleTextStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey[300]
          )
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        disabledColor: Colors.white,
      ),
      navigatorKey: navigatorKey,
      home: const MyNavigationBar(),
    );
  }
}
