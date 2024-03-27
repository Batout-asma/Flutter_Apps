import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:auth_app/pages/layout_page.dart';
import 'package:auth_app/pages/Login_or_register_page.dart';

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
              return const Layout();
            }
            //user is NOT logged in:
            else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
