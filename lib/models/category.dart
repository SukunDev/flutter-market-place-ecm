import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String title;

  Category({
    required this.id,
    required this.title,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Category(
      id: doc.id,
      title: data['title'] ?? 'No title',
    );
  }
}
