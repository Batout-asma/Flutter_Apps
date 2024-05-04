import 'package:green_watch_app/components/my_drawer.dart';
import 'package:green_watch_app/pages/add_product.dart';
import 'package:green_watch_app/pages/profile_page.dart';
import 'package:green_watch_app/pages/settings_page.dart' as my_settings;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShopSeller extends StatefulWidget {
  const ShopSeller({super.key});

  @override
  State<ShopSeller> createState() => _ShopSellerState();
}

class _ShopSellerState extends State<ShopSeller> {
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
        builder: (context) => const my_settings.Settings(),
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

  void goToFormPage() {
    // go to cart page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.green[600],
          title: const Text(
            "Shop",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () => goToFormPage(),
                icon: const Icon(Icons.add_circle_rounded),
              ),
            )
          ],
        ),
        drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSettingsTap: goToSettingsPage,
          onLogOutTap: signUserOut,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 25),
            // shop subtitle
            Center(
              child: Text(
                "The requests list",
                style: TextStyle(color: Colors.green[900], fontSize: 16),
              ),
            ),
          ],
        ));
  }
}
