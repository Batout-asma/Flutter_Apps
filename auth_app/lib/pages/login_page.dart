import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:auth_app/components/my_button.dart';
import 'package:auth_app/components/my_textfield.dart';

import 'package:auth_app/pages/sign_up_page.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  //  Field controllers
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
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 30),

              // Title
              const Text(
                'Login to GreenWatch Pro',
                style: TextStyle(
                  color: Color.fromRGBO(60, 60, 60, 1),
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 25),

              // Email field
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password field
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Login Btn
              MyButton(onTap: signUserIn),

              const SizedBox(height: 25),

              //not a member? Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Color.fromRGBO(117, 117, 117, 1)),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                        const SizedBox(width: 25);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromRGBO(46, 125, 50, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
