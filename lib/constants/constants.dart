import 'package:erouteadmin/user_screen/mynavigationbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import '../pages/login_page.dart';
import '../user_screen/constant.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('eRouteAdmin'),
      titleTextStyle: const TextStyle(letterSpacing: 5),
      actions: [
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final User? user = snapshot.data;
              if (user != null) {
                // User is signed in, show logout button
                return IconButton(
                  onPressed: () async {
                    await logout(context); // Call the logout function
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Colors.grey[300],
                  ),
                );
              }
            }
            // User is not signed in, return an empty container
            return Container();
          },
        ),
      ],
    );
  }

  // Required for PreferredSizeWidget
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Logout function to sign out from Firebase and navigate to login page
Future<void> logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase

    // Navigate to the login page
    Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => MyNavigationBar()),
          (route) => false, // Removes all previous routes
    );
  } catch (e) {
    print("Error signing out: $e"); // Handle errors if needed
  }
}
