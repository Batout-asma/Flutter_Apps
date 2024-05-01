import 'package:flutter/material.dart';

import 'package:auth_app/pages/wrapper.dart';
// import 'package:auth_app/theme/dark_theme.dart';
import 'package:auth_app/theme/light_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // idk why i add this line
  WidgetsFlutterBinding.ensureInitialized();
  // end of line
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
