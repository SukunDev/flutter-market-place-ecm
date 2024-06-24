import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final bool isAdmin;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.isAdmin,
    required this.email,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? 'Nama Belum di Setting',
      phoneNumber: data['phone_number'] ?? 'Phone Number Belum di setting',
      isAdmin: data['isAdmin'],
      email: data['email'] ?? 'Email Belum di setting',
    );
  }
}
