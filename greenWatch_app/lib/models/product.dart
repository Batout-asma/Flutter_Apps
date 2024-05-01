/*
class Product {
  String? name;
  String? description;
  double? price;

  Product();

  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'price': price};
  Product.fromSnapshot(snapshot)
      : name = snapshot.data()['name'],
        description = snapshot.data()['description'],
        price = snapshot.data()['price'];
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
    };
  }

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
    );
  }

  factory Product.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Product(
      name: data['Name']?.toString() ?? 'Unknown Product',
      price: double.tryParse(data['Price']) ?? 0.0,
      description: data['Description']?.toString() ?? '',
    );
  }
  static Product fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Product.fromFirestore(doc);
  }
}
