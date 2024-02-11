import 'package:auth_app/components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //user that is logged in
  final currentUser = FirebaseAuth.instance.currentUser!;

  // edit field
  Future<void> editField(String field) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          // profile picture
          const Icon(
            Icons.person,
            size: 72,
          ),

          const SizedBox(
            height: 10,
          ),

          // user email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[800]),
          ),

          const SizedBox(
            height: 50,
          ),

          // user infos
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          // first name
          MyTextBox(
            text: '',
            sName: 'First Name',
            onPressed: () => editField('Batout'),
          ),
          // last name
          MyTextBox(
            text: '',
            sName: 'Last Name',
            onPressed: () => editField('Atbake'),
          ),
        ],
      ),
    );
  }
}
