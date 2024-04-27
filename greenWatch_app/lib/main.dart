import 'package:auth_app/models/shop.dart';
import 'package:flutter/material.dart';

import 'package:auth_app/pages/wrapper.dart';
// import 'package:auth_app/theme/dark_theme.dart';
import 'package:auth_app/theme/light_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  // idk why i add this line
  WidgetsFlutterBinding.ensureInitialized();
  // end of line
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
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
