import 'package:auth_app/components/my_button.dart';
import 'package:auth_app/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  //user that is logged in
  final currentUser = FirebaseAuth.instance.currentUser;

  //  Field controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  // add product
  void addProduct() async {
    final String productId = const Uuid().v4();
    // Create 'Products' in the database
    await FirebaseFirestore.instance.collection("Products").doc(productId).set(
      {
        'Name': nameController.text,
        'Description': descriptionController.text,
        'Price': priceController.text,
        'userEmail': currentUser?.email,
      },
    );
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[600],
        title: const Text(
          'Add Item',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Title
              const Text(
                'Add a new product',
                style: TextStyle(
                  color: Color.fromRGBO(60, 60, 60, 1),
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 25),

              // name field
              MyTextField(
                controller: nameController,
                hintText: 'Product Name',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // description field
              MyTextField(
                controller: descriptionController,
                hintText: 'Description',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // description field
              MyTextField(
                controller: priceController,
                hintText: 'Price',
                obscureText: false,
              ),

              const SizedBox(height: 20),

              // Login Btn
              MyButton(
                onTap: addProduct,
                text: 'A D D',
                enabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
