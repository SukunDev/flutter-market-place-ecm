import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecm/models/user.dart';
import 'package:ecm/screens/Admin/admin_app_bar.dart';
import 'package:flutter/material.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            const AdminAppBar(title: "Users"),
            const SizedBox(height: 30),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No products found.'));
                }

                final products = snapshot.data!.docs
                    .map((doc) => User.fromFirestore(doc))
                    .toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Phone Number')),
                        DataColumn(label: Text('Type')),
                      ],
                      rows: List<DataRow>.generate(
                        products.length,
                        (index) {
                          final product = products[index];
                          return DataRow(
                            cells: [
                              DataCell(Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                              DataCell(Text(
                                product.email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              )),
                              DataCell(Text(
                                product.phoneNumber,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              )),
                              DataCell(Text(
                                product.isAdmin ? "Admin" : "Users",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              )),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
