import 'package:auth_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:auth_app/components/my_drawer.dart';
import 'package:auth_app/pages/profile_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToSettingsPage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to settings page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  }

  void goToProfilePage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to profile page

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Profile(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('Home'),
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSettingsTap: goToSettingsPage,
        onLogOutTap: signUserOut,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Text(
            "You are logged in our app as\n${user.email!}",
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
