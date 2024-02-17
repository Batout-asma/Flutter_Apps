import 'package:flutter/material.dart';

import 'package:auth_app/pages/wrapper.dart';
// import 'package:auth_app/theme/dark_theme.dart';
import 'package:auth_app/theme/light_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  // idk why i add this line
  WidgetsFlutterBinding.ensureInitialized();
  // end of line
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

  // var db = FirebaseFirestore.instance;

  /*
  WRITING IN DATABASE:

  final user = <String, dynamic>{
    "name": "Asma",
    "age": 20,
  };

  db.collection("users").add(user).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));
  */

  /*
  READING FROM DATABASE:

  await db.collection("users").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
  */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // darkTheme: darkTheme,
      home: const Wrapper(),
    );
  }
}
