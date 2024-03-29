import 'package:auth_app/components/my_drawer.dart';
import 'package:auth_app/pages/chatbox_page.dart';
import 'package:auth_app/pages/home_page.dart';
import 'package:auth_app/pages/profile_page.dart';
import 'package:auth_app/pages/settings_page.dart';
import 'package:auth_app/pages/shop_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex = 0;
  final screens = [
    const Home(),
    const ChatBox(),
    const Shop(),
  ];
  final titles = [
    'Home',
    'ChatBox',
    'Shop',
  ];
  final texts = [
    'H O M E',
    'C H A T B O X',
    'S H O P',
  ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text(titles[currentIndex]),
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSettingsTap: goToSettingsPage,
        onLogOutTap: signUserOut,
        text: (texts[currentIndex]),
      ),
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
