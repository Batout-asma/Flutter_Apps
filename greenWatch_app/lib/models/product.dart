import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }

  factory Product.fromMapClient(Map<String, dynamic> data) {
    return Product(
      id: data['id'] as String,
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
    );
  }

  factory Product.fromMapSeller(Map<String, dynamic> data) {
    return Product(
      id: data['id']?.toString() ?? '',
      name: data['name']?.toString() ?? 'Unknown Product',
      price: double.tryParse(data['price']) ?? 0.0,
      description: data['description']?.toString() ?? '',
    );
  }

  factory Product.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Product(
      id: snapshot.id,
      name: data['name']?.toString() ?? 'Unknown Product',
      price: double.tryParse(data['price']) ?? 0.0,
      description: data['description']?.toString() ?? '',
    );
  }

  static Product fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Product.fromFirestore(doc);
  }
}
