import 'package:auth_app/components/my_drawer.dart';
import 'package:auth_app/components/my_product_tile.dart';
import 'package:auth_app/pages/cart_page.dart';
import 'package:auth_app/pages/profile_page.dart';
import 'package:auth_app/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_app/models/shop.dart';

class ShopClient extends StatefulWidget {
  const ShopClient({super.key});

  @override
  State<ShopClient> createState() => _ShopClientState();
}

class _ShopClientState extends State<ShopClient> {
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

  void goToCartPage() {
    // go to cart page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Cart(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Shop>().shop;
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
                onPressed: () => goToCartPage(),
                icon: const Icon(Icons.shopping_cart_rounded),
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
                "Visit your cart to valid payment",
                style: TextStyle(color: Colors.green[900], fontSize: 16),
              ),
            ),

            // product list
            SizedBox(
              height: 550,
              child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return MyProductTile(product: product);
                },
              ),
            ),
          ],
        ));
  }
}
