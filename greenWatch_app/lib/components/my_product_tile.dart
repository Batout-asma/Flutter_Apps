import 'package:auth_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProductTile extends StatelessWidget {
  final Product product;

  const MyProductTile({
    super.key,
    required this.product,
  });

  void addToCart(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(currentUser.email);
    final cartRef = userDocRef.collection('Cart');

    // Check for existing cart collection (optional)
    final cartDocSnap = await userDocRef.get();
    if (!cartDocSnap.exists) {
      await userDocRef
          .set({'cart': []}); // Create cart collection if it doesn't exist
    }

    await cartRef.add(product.toMap());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${product.name}" added to cart!'),
      ),
    );
  }
  /*
  void addToCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to Cart'),
        content: Text(
            'Are you sure you want to add "${product.name}" to your cart?'),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          // Add button
          TextButton(
            onPressed: () async {
              final auth = Provider.of<FirebaseAuth>(context, listen: false);
              final currentUser = auth.currentUser;

              if (currentUser != null) {
                final userDocRef = FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser.email);
                final cartRef = userDocRef.collection('cart');

                await cartRef.add(product.toMap());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${product.name}" added to cart!'),
                  ),
                );
              } else {
                // Handle case when user is not signed in (optional)
                print('Cannot add to cart');
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: const Icon(Icons.favorite_border_outlined),
                ),
              ),

              const SizedBox(height: 25),

              // Product name
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 20),

              // Product description
              Text(
                product.description,
                style: TextStyle(
                  color: Colors.green[900],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Product price
              Text('${product.price.toStringAsFixed(2)} DZD'),

              // Add to cart btn
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  onPressed: () => addToCart(context),
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
