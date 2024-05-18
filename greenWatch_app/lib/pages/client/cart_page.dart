import 'package:green_watch_app/components/my_button.dart';
import 'package:green_watch_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<Product> cartItems = [];
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  void _fetchCartItems() async {
    final userDoc =
        FirebaseFirestore.instance.collection('Users').doc(user.email);
    final cart = userDoc.collection('Cart');

    final cartSnapshot = await cart.get();

    setState(() {
      cartItems.clear();
      cartItems.addAll(cartSnapshot.docs
          .map((doc) => Product.fromMapClient(doc.data()))
          .toList());
    });
  }

  void removeItemFromCart(Product product) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          // Accept button with Firestore removal
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              cartItems.remove(product);
              setState(() {});

              // Remove from Firestore
              final userDocRef = FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user.email);
              final cartRef = userDocRef.collection('Cart');

              final productRef =
                  cartRef.where('name', isEqualTo: product.name).limit(1).get();
              productRef.then((querySnapshot) {
                if (querySnapshot.docs.isNotEmpty) {
                  querySnapshot.docs.first.reference.delete();
                } else {
                  // ignore: avoid_print
                  print('Product not found in cart (might be a rare case)');
                }
              });
            },
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }

  void payBtnPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("Payment processing..."),
      ),
    );

    if (true) {
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(user.email);
      final cartRef = userDocRef.collection('Cart');

      await cartRef.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        } // Delete each document
      });

      cartItems.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[600],
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Cart list with data fetching
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text("Your cart is empty..."))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.shade300,
                          child: ListTile(
                            title: Text(product.name),
                            subtitle: Text(product.price.toStringAsFixed(2)),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => removeItemFromCart(product),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ), // Pay button
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
            child: MyButton(
              onTap: cartItems.isEmpty ? null : () => payBtnPressed(context),
              text: "P A Y  N O W",
              enabled: cartItems.isNotEmpty,
            ),
          ),
        ],
      ),
    );
  }
}
