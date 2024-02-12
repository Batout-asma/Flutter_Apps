import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:auth_app/components/my_button.dart';
import 'package:auth_app/components/my_textfield.dart';

class SignUp extends StatefulWidget {
  final Function()? onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //  Field controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

// sign user up method
  void signUserUp() async {
    // Loading circle
    showDialog(
      context: context,
      builder: (contest) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // check password match
    if (passwordController.text != confirmpasswordController.text) {
      // Loading circle
      Navigator.pop(context);
      // show the error
      showErrorMessage("Passwords don't match!");
      return;
    }

    // Create user
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Create 'Users' in the database
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user?.email)
          .set(
        {
          'First_Name': '',
          'Last_Name': '',
        },
      );

      // Loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException {
      // End Loading
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage('Try Again!');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('Sign Up'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),

                // Logo
                const Icon(
                  Icons.lock,
                  size: 60,
                ),
                const SizedBox(height: 15),

                // Title
                const Text(
                  'Sign up to GreenWatch Pro',
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

                // Password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Comfirm password field
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Comfirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 35),

                // Login Btn
                MyButton(
                  onTap: signUserUp,
                  text: 'Sign Up',
                ),

                const SizedBox(height: 25),

                // Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?  ",
                      style: TextStyle(color: Color.fromRGBO(117, 117, 117, 1)),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            color: Color.fromRGBO(46, 125, 50, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
