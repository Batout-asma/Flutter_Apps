import 'package:flutter/material.dart';
import 'package:auth_app/log_in_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogIn()),
                );
              },
              style: ButtonStyle(
                side: const MaterialStatePropertyAll(BorderSide(
                  color: Colors.white,
                  width: 1.0,
                )),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: Text('This is the home page ! Click up to Sign In.',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              )),
        ),
      ),
    );
  }
}
