import 'package:flutter/material.dart';

import 'package:auth_app/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ignore: unused_local_variable
  var db = FirebaseFirestore.instance;

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
    return const MaterialApp(
      home: Home(),
    );
  }
}
