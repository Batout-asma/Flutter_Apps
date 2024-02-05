import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:auth_app/pages/sign_up_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

// sign user in method
  void signUserIn() async {
    // Loading circle
    showDialog(
      context: context,
      builder: (contest) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Check to log in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // End Loading
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // End Loading
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // wrongEmailMassage();
        // WRONG PASSWORD
      } else if (e.code == 'wrong-password') {
        // wrongPasswordMassage();
      }
    }
  }

  // void wrongEmailMassage() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           title: Text('Incorrect Email'),
  //         );
  //       });
  // }

  // void wrongPasswordMassage() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           title: Text('Incorrect Password'),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('Log in'),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: TextButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const Home()),
        //         );
        //       },
        //       style: ButtonStyle(
        //         side: const MaterialStatePropertyAll(BorderSide(
        //           color: Colors.white,
        //           width: 1.0,
        //         )),
        //         shape: MaterialStatePropertyAll(
        //           RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(8.0),
        //           ),
        //         ),
        //       ),
        //       child: const Text(
        //         'Home',
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(130.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  signUserIn();
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.only(left: 50.0, right: 50.0)),
                ),
                child: const Text('Log in'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
