import 'package:auth_app/components/my_button.dart';
import 'package:auth_app/models/product.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<Product> cart = [];

  void removeItemFromCart(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
        actions: [
          // cancel
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          // accept
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              cart.remove(product);
              setState(() {}); // Update UI after removing item
            },
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }

  void payBtnPressed(BuildContext context) async {
    // Implement actual payment logic here based on your cart data
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("Payment processing..."),
      ),
    );

    if (true) {
      // Show payment success dialog (optional)
      cart.clear(); // Clear cart after successful payment
      setState(() {}); // Update UI after clearing cart
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
          // Cart list
          Expanded(
            child: cart.isEmpty
                ? const Center(child: Text("Your cart is empty..."))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      // Get an item in cart
                      final item = cart[index];

                      // Return as cart tile with product information
                      return ListTile(
                        title: Text(item.name), // Use null-aware operator
                        subtitle: Text(item.price.toStringAsFixed(2)),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => removeItemFromCart(item),
                        ),
                      );
                    },
                  ),
          ),
          // Pay button
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
            child: MyButton(
              onTap: () => payBtnPressed(context),
              text: "P A Y  N O W",
            ),
          ),
        ],
      ),
    );
  }
}
