import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:green_watch_app/components/my_drawer.dart';
import 'package:green_watch_app/main.dart';
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
  String lumValue = '0';
  DateTime? lastTempNotificationTime;
  DateTime? lastHumNotificationTime;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToSettingsPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Profile(),
      ),
    );
  }

  Future<void> showTempNotification(String temperature) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Temperature Alert',
      'The temperature is $temperature°C',
      platformChannelSpecifics,
      payload: 'HomePage',
    );
  }

  Future<void> showHumNotification(String humidity) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Humidity Alert',
      'The humidity is $humidity%',
      platformChannelSpecifics,
      payload: 'HomePage',
    );
  }

  Future<void> showLumNotification(String luminosity) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Luminosity Alert',
      'The humidity is $luminosity%',
      platformChannelSpecifics,
      payload: 'HomePage',
    );
  }

  Widget content() {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('UsersData');
    var userid = user.uid;
    final userUid = ref.child(userid.toString());
    final readings = userUid.child('readings');
    final temperature = readings.child('temperature');
    final humidity = readings.child('humidity');
    final luminosity = readings.child('luminosity');

    temperature.onValue.listen(
      (event) {
        setState(() {
          tempValue = event.snapshot.value.toString();
          if (double.tryParse(tempValue) != null &&
                  double.parse(tempValue) < 18 ||
              double.parse(tempValue) > 24) {
            final now = DateTime.now();
            if (lastTempNotificationTime == null ||
                now.difference(lastTempNotificationTime!) >=
                    const Duration(seconds: 30)) {
              showTempNotification(tempValue);
              lastTempNotificationTime = now;
            }
          }
        });
      },
    );

    humidity.onValue.listen(
      (event) {
        setState(() {
          humValue = event.snapshot.value.toString();
          if (double.tryParse(humValue) != null &&
                  double.parse(humValue) < 40 ||
              double.parse(humValue) > 80) {
            final now = DateTime.now();
            if (lastHumNotificationTime == null ||
                now.difference(lastHumNotificationTime!) >=
                    const Duration(seconds: 35)) {
              showHumNotification(humValue);
              lastHumNotificationTime = now;
            }
          }
        });
      },
    );
    luminosity.onValue.listen(
      (event) {
        setState(() {
          lumValue = event.snapshot.value.toString();
          if (double.tryParse(lumValue) != null &&
                  double.parse(lumValue) < 60 ||
              double.parse(lumValue) > 120) {
            final now = DateTime.now();
            if (lastHumNotificationTime == null ||
                now.difference(lastHumNotificationTime!) >=
                    const Duration(seconds: 25)) {
              showHumNotification(lumValue);
              lastHumNotificationTime = now;
            }
          }
        });
      },
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green[300],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        "GreenWatch Pro",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          "Welcome, ${user.email?.split("@")[0]}!",
          style: const TextStyle(
            fontSize: 22,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 30)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white24,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Temperature",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tempValue,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "°C",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(left: 50)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white24,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Humidity",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            humValue,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "%",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 30)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white24,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Luminosity",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lumValue,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "LUX",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(left: 50)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white24,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Soil Humidity",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'N/A',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "%",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
