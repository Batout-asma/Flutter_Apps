import 'package:flutter/material.dart';

import 'package:green_watch_app/services/wrapper.dart';
// import 'package:auth_app/theme/dark_theme.dart';
import 'package:green_watch_app/theme/light_theme.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String databaseURL =
      'https://auth-app-9678a-default-rtdb.europe-west1.firebasedatabase.app';
  String appId = '1:701147182658:android:df1fa6147043d6b57a5fdb';
  String apiKey = 'AIzaSyDgA0NPV3-oko7FMIl_0pPCce62entTUik';
  String messagingSenderId = '701147182658';
  String projectId = 'auth-app-9678a';
  await Firebase.initializeApp(
    options: FirebaseOptions(
      appId: appId,
      apiKey: apiKey,
      databaseURL: databaseURL,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
    ),
  );
  runApp(
    const MyApp(),
  );
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
