import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('Profile'),
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 50,
          ),
          // profile picture
          Icon(
            Icons.person,
            size: 70,
          )
          // user email

          // first name

          // last name
        ],
      ),
    );
  }
}
