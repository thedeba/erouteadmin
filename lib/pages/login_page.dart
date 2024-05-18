import 'package:erouteadmin/components/alert_dialog.dart';
import 'package:erouteadmin/components/my_button.dart';
import 'package:erouteadmin/components/mytext_field.dart';
import 'package:erouteadmin/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  // Password visibility function
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: MyAppBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image asset
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: Image.asset(
                  'assets/images/login.png',
                  scale: 2,
                ),
              ),

              // Text
              Column(
                children: [
                  Text(
                    'Sign in',
                    style: TextStyle(color: Colors.grey[400], fontSize: 26),
                  ),
                  Text(
                    'to continue eRouteAdmin',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),

              // Email field
              MyTextField(
                hintText: 'Email',
                prefixIcon: const Icon(
                  CupertinoIcons.mail,
                  color: Colors.grey,
                ),
                obscureText: false,
                controller: _emailController,
              ),

              // Password field
              MyTextField(
                hintText: 'Password',
                prefixIcon: const Icon(
                  Icons.key,
                  color: Colors.grey,
                ),
                suffixIcon: GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
                    _isPasswordVisible
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: Colors.grey,
                  ),
                ),
                obscureText: !_isPasswordVisible,
                controller: _passController,
              ),

              // Password forgot
              Padding(
                padding: const EdgeInsets.only(right: 5.0, top: 7),
                child: GestureDetector(
                  onTap: () {},
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot password',
                        style: TextStyle(color: Colors.blueAccent),
                      )),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Login button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => const CustomAlertDialog(
                          message:
                              "You cann't sign up for admin. This is only for authorized."),
                    ),
                    child: const Text(
                      'Register now',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  MyButton(
                      Name: 'Login',
                      onPressed: () async {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passController.text)
                            .then((value) => Fluttertoast.showToast(
                                  msg: 'Login success',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                ));
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Has membership or not
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You will agree',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    CupertinoIcons.signature,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text('to our', style: TextStyle(color: Colors.grey[400])),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'Terms',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '&',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'Conditions',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'when login.',
                    style: TextStyle(color: Colors.grey[400]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
