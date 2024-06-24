import 'package:ecm/models/product.dart';
import 'package:ecm/screens/Admin/add_product_page.dart';
import 'package:ecm/screens/Admin/edit_product_page.dart';
import 'package:ecm/screens/Auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    setState(() {
      _isLoading = false;
    });
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductPage()),
    );
  }

  void _editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProductPage(product: product)),
    );
  }

  void _deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('products')
                          .orderBy('category')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('No products found.'));
                        }

                        final products = snapshot.data!.docs
                            .map((doc) => Product.fromFirestore(doc))
                            .toList();

                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey),
                              columns: const [
                                DataColumn(label: Text('No')),
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Price')),
                                DataColumn(label: Text('Category')),
                                DataColumn(label: Text('Action')),
                              ],
                              rows: List<DataRow>.generate(
                                products.length,
                                (index) {
                                  final product = products[index];

                                  return DataRow(
                                    cells: [
                                      DataCell(Text((index + 1).toString())),
                                      DataCell(Text(product.title)),
                                      DataCell(Text(product.price.toString())),
                                      DataCell(Text(product.category)),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () =>
                                                  _editProduct(product),
                                              color: Colors.blue,
                                              iconSize: 20,
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () =>
                                                  _deleteProduct(product.id),
                                              color: Colors.red,
                                              iconSize: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _addProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Add Product'),
                  ),
                ),
              ],
            ),
    );
  }
}
