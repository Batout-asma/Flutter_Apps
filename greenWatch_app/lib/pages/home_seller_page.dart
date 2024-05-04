import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_watch_app/components/my_drawer.dart';
import 'package:green_watch_app/components/my_seller_product_tile.dart';
import 'package:green_watch_app/models/product.dart';
import 'package:green_watch_app/pages/settings_page.dart' as my_settings;
import 'package:flutter/material.dart';

import 'package:green_watch_app/pages/profile_page.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeSeller extends StatefulWidget {
  const HomeSeller({super.key});

  @override
  State<HomeSeller> createState() => _HomeSellerState();
}

class _HomeSellerState extends State<HomeSeller> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Product> products = [];

  void deleteProduct(Product product) async {
    // Get a reference to the specific product document
    final productRef =
        FirebaseFirestore.instance.collection('Products').doc(product.id);

    try {
      // Delete the product document
      await productRef.delete();

      // Update the local product list efficiently
      setState(() {
        products.removeWhere((item) => item.id == product.id);
      });

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product deleted successfully!'),
        ),
      );
    } catch (e) {
      print('Error deleting product: $e');
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting product: $e'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserProducts();
  }

  void fetchUserProducts() async {
    final userDoc = FirebaseFirestore.instance.collection('Products');
    final querySnapshot =
        await userDoc.where('userEmail', isEqualTo: user.email).get();

    setState(() {
      products =
          querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
        body: ListView(
          children: [
            const SizedBox(height: 25),
            // shop subtitle
            Center(
              child: Text(
                "Your products list",
                style: TextStyle(color: Colors.green[900], fontSize: 16),
              ),
            ),

            // Product list with efficient deletion
            SizedBox(
              height: 550,
              child: products.isEmpty
                  ? const Center(child: Text("No products found"))
                  : ListView.builder(
                      itemCount: products.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(15),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return MySellerProductTile(
                          product: product,
                          deleteProduct: deleteProduct,
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}
