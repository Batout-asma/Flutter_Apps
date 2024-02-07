import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

// import 'package:auth_app/pages/log_in_page.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: TextButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const LogIn()),
        //         );
        //       },
        // style: ButtonStyle(
        //   side: const MaterialStatePropertyAll(BorderSide(
        //     color: Colors.white,
        //     width: 1.0,
        //   )),
        //   shape: MaterialStatePropertyAll(
        //     RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //   ),
        // ),
        // child: const Text(
        //   'Log In',
        //   style: TextStyle(color: Colors.white),
        // ),
        //     ),
        //   ),
        // ],
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
