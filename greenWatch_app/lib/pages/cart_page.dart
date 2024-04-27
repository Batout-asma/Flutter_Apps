import 'package:auth_app/components/my_button.dart';
import 'package:auth_app/models/product.dart';
import 'package:auth_app/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  void removeItemFromCart(BuildContext context, Product product) {
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

              context.read<Shop>().removeFromCart(product);
            },
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }

  void payBtnPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("User payed successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
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
          // cart list
          Expanded(
            child: cart.isEmpty
                ? const Center(child: Text("Your cart is empty..."))
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      // get an item in cart
                      final item = cart[index];
                      // return as cart tile
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.price.toStringAsFixed(2)),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => removeItemFromCart(context, item),
                        ),
                      );
                    },
                  ),
          ),
          // pay btn
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
            child: MyButton(
                onTap: () => payBtnPressed(context), text: "P A Y  N O W"),
          ),
        ],
      ),
    );
  }
}
