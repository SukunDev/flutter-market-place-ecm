import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final int review;
  final String seller;
  final int price;
  final String category;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.review,
    required this.description,
    required this.image,
    required this.price,
    required this.seller,
    required this.category,
    required this.quantity,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      title: data['title'] ?? 'No title',
      description: data['description'] ?? 'No description',
      image: data['image'] ?? 'No image',
      review: data['review']?.toInt() ?? 'No review',
      seller: data['seller'] ?? 'No seller',
      price: data['price']?.toInt() ?? 0,
      category: data['category'] ?? 'No category',
      quantity: data['quantity']?.toInt() ?? 0,
    );
  }
}
