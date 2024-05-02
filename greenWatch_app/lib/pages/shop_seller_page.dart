import 'package:green_watch_app/components/my_drawer.dart';
import 'package:green_watch_app/components/my_seller_product_tile.dart';
import 'package:green_watch_app/models/product.dart';
import 'package:green_watch_app/pages/add_product.dart';
import 'package:green_watch_app/pages/profile_page.dart';
import 'package:green_watch_app/pages/settings_page.dart' as my_settings;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShopSeller extends StatefulWidget {
  const ShopSeller({super.key});

  @override
  State<ShopSeller> createState() => _ShopSellerState();
}

class _ShopSellerState extends State<ShopSeller> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Product> products = [];

  void deleteProduct(String productId) async {
    // Get a reference to the product document in Firestore
    final productRef = FirebaseFirestore.instance.collection('Products').doc();

    try {
      // Delete the product document
      await productRef.delete();

      setState(() {
        products.removeWhere((product) => product.name == true);
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product deleted successfully!'),
        ),
      );
    } catch (e) {
      print('Error deleting product: $e');
      // ignore: use_build_context_synchronously
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
      products = querySnapshot.docs
          .map((doc) => Product.fromMapSeller(doc.data()))
          .toList();
    });
    print('this is the products list: $products');
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

            // product list (modified)
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
                        ); // Use MyProductTile here
                      },
                    ),
            ),
          ],
        ));
  }
}
