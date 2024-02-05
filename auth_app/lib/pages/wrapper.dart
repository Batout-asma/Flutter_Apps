import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:auth_app/pages/home_page.dart';
import 'package:auth_app/pages/log_in_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in:
            if (snapshot.hasData) {
              return Home();
            }
            //user is NOT logged in:
            else {
              return const LogIn();
            }
          }),
    );
  }
}
