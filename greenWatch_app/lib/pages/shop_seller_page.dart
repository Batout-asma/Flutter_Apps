import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_watch_app/components/my_drawer.dart';
import 'package:green_watch_app/models/product.dart';
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
  final currentUser = FirebaseAuth.instance.currentUser;
  late Future<List<Product>>
      requestsFuture; // Use 'late' for non-nullable Future

  @override
  void initState() {
    super.initState();
    requestsFuture = _fetchRequests();
  }

  Future<List<Product>> _fetchRequests() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Requests').get();
      return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    } catch (error) {
      // Handle error gracefully
      print('Error fetching requests: $error');
      throw error; // Rethrow the error to notify FutureBuilder
    }
  }

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToSettingsPage() {
    // Pop menu drawer
    Navigator.pop(context);

    // Go to settings page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const my_settings.Settings(),
      ),
    );
  }

  void goToProfilePage() {
    // Pop menu drawer
    Navigator.pop(context);

    // Go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Profile(),
      ),
    );
  }

  void goToFormPage() {
    // Go to cart page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProduct(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
      body: FutureBuilder<List<Product>>(
        future: requestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("There is no request..."));
          }

          final requests = snapshot.data!;

          return ListView(
            children: [
              const SizedBox(height: 25),
              // Shop subtitle
              Center(
                child: Text(
                  "The requests list",
                  style: TextStyle(color: Colors.green[900], fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              // Request list with data fetching
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade300,
                      child: ListTile(
                        title: Text(request.name),
                        subtitle: Text(request.price.toStringAsFixed(2)),
                        trailing: IconButton(
                          icon: const Icon(Icons.chat_rounded),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
