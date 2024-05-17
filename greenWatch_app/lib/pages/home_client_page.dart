import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:green_watch_app/components/my_drawer.dart';
import 'package:green_watch_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

import 'package:green_watch_app/pages/profile_page.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeClient extends StatefulWidget {
  const HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  final user = FirebaseAuth.instance.currentUser!;
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String tempValue = '0';
  String humValue = '0';
  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToSettingsPage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to settings page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  }

  void goToProfilePage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to profile page

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Profile(),
      ),
    );
  }

  Widget content() {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('UsersData');
    var userid = user.uid;
    final userUid = ref.child(userid.toString());
    final readings = userUid.child('readings');
    final temperature = readings.child('temperature');
    final humidity = readings.child('humidity');
    temperature.onValue.listen(
      (event) {
        setState(() {
          tempValue = event.snapshot.value.toString();
        });
      },
    );
    humidity.onValue.listen(
      (event) {
        setState(() {
          humValue = event.snapshot.value.toString();
        });
      },
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Temperature: $tempValue",
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Center(
          child: Text(
            "Humidity: $humValue",
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[600],
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSettingsTap: goToSettingsPage,
        onLogOutTap: signUserOut,
      ),
      body: FutureBuilder(
        future: _fApp,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something wrong with firebase");
          } else if (snapshot.hasData) {
            return content();
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}



/* Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Text(
            "Welcome our Client\n${user.email!}",
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),*/