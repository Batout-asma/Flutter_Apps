import 'package:green_watch_app/pages/chatbox_page.dart';
import 'package:green_watch_app/pages/home_client_page.dart';
import 'package:green_watch_app/pages/home_seller_page.dart';
import 'package:green_watch_app/pages/shop_client_page.dart';
import 'package:green_watch_app/pages/shop_seller_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late User? currentUser;
  late String? occupation;
  int currentIndex = 0;
  int usertype = 0;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser?.email)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        occupation = docSnapshot.data()?['Occupation'];
        setState(() {
          if (occupation == 'Seller') {
            usertype = 1;
            screens = [
              const HomeSeller(),
              const ChatBox(),
              const ShopSeller(),
            ];
          } else {
            screens = [
              const HomeClient(),
              const ChatBox(),
              const ShopClient(),
            ];
          }
        });
      } else {
        // Document does not exist
      }
    }).catchError((error) {
      // ignore: avoid_print
      print("Error getting document: $error");
    });

    screens = [
      const Center(child: CircularProgressIndicator()),
      const ChatBox(),
      const ShopClient(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green[600],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        iconSize: 35,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'ChatBox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Shop',
          ),
        ],
      ),
    );
  }
}
