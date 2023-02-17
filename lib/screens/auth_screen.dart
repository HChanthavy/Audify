import 'package:audify/screens/export_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (snapshot.hasData) {
            return const DisplayScreens();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            return const SignUpScreen();
          }
        },
      ),
    );
  }
}
