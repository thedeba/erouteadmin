import 'package:erouteadmin/components/mynavigationbar.dart';
import 'package:erouteadmin/pages/home_page.dart';
import 'package:erouteadmin/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MyNavigationBar();
          } else {
            return const LoginPage();
          }
        });
  }
}
