import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecm/constants.dart';
import 'package:ecm/models/category.dart';
import 'package:ecm/models/product.dart';
import 'package:ecm/screens/Admin/Products/add_category_page.dart';
import 'package:ecm/screens/Admin/Products/add_product_page.dart';
import 'package:ecm/screens/Admin/Products/edit_category_page.dart';
import 'package:ecm/screens/Admin/admin_app_bar.dart';
import 'package:ecm/screens/Admin/Products/edit_product_page.dart';
import 'package:flutter/material.dart';

class AdminProductPage extends StatefulWidget {
  const AdminProductPage({super.key});

  @override
  State<AdminProductPage> createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0;
  final List<String> _tabSelector = ["Product", "Category"];

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProductPage()),
    );
  }

  void _addCategory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCategoryPage()),
    );
  }

  void _editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProductPage(product: product)),
    );
  }

  void _editCategory(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditCategoryPage(category: category)),
    );
  }

  void _deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  void _deleteCategory(String categoryId) async {
    await _firestore.collection('category').doc(categoryId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            const AdminAppBar(title: "Product"),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: categoryItems(),
            ),
            const SizedBox(height: 10),
            if (_selectedIndex == 0) buildProductStreamBuilder(),
            if (_selectedIndex == 1) buildCategoryStreamBuilder(),
            const SizedBox(
              height: 30,
            ),
            if (_selectedIndex == 0)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 18,
                  ),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: _addProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kprimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Add Product',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            if (_selectedIndex == 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 18,
                  ),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: _addCategory,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kprimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Add Category',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> buildProductStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('products').orderBy('category').snapshots(),
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
            .map((doc) => Product.fromFirestore(doc))
            .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Seller')),
                DataColumn(label: Text('Qty')),
                DataColumn(label: Text('Action')),
              ],
              rows: List<DataRow>.generate(
                products.length,
                (index) {
                  final product = products[index];

                  return DataRow(
                    cells: [
                      DataCell(Text(product.title)),
                      DataCell(Text(product.price.toString())),
                      DataCell(Text(product.category)),
                      DataCell(Text(product.seller)),
                      DataCell(Text(product.quantity.toStringAsFixed(0))),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editProduct(product);
                              },
                              color: Colors.black38,
                              iconSize: 20,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteProduct(product.id);
                              },
                              color: Colors.red,
                              iconSize: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot> buildCategoryStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('category').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No categories found.'));
        }

        final categories = snapshot.data!.docs
            .map((doc) => Category.fromFirestore(doc))
            .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Action')),
              ],
              rows: List<DataRow>.generate(
                categories.length,
                (index) {
                  final category = categories[index];

                  return DataRow(
                    cells: [
                      DataCell(Text(category.title)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editCategory(category);
                              },
                              color: Colors.black38,
                              iconSize: 20,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteCategory(category.id);
                              },
                              color: Colors.red,
                              iconSize: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox categoryItems() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _tabSelector.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index; // Update the selected index
              });
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 7, 16, 0),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:
                    _selectedIndex == index ? kprimaryColor : Colors.grey[100],
              ),
              child: Text(
                _tabSelector[index],
                style: TextStyle(
                  color: _selectedIndex == index ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
