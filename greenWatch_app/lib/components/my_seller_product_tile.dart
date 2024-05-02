import 'package:green_watch_app/models/product.dart';
import 'package:flutter/material.dart';

class MySellerProductTile extends StatelessWidget {
  final Product product;
  final Function(String) deleteProduct;

  const MySellerProductTile({
    super.key,
    required this.product,
    required this.deleteProduct,
  });

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

              // Delete button
              IconButton(
                onPressed: () => showDeleteDialog(context, product.name),
                icon: const Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              deleteProduct(productId);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
