import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecm/constants.dart';
import 'package:ecm/models/category.dart';
import 'package:ecm/screens/Admin/Products/admin_product_app_bar.dart';
import 'package:flutter/material.dart';

class EditCategoryPage extends StatefulWidget {
  final Category category;
  const EditCategoryPage({super.key, required this.category});

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final TextEditingController _titleController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _initEditFields();
  }

  void _initEditFields() {
    _titleController.text = widget.category.title;
  }

  void _editCategory(BuildContext context) async {
    String title = _titleController.text;
    if (title.isNotEmpty) {
      try {
        await _firestore
            .collection('category')
            .doc(widget.category.id)
            .update({'title': title});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category updated successfully')),
        );
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update category')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            const AdminProductAppBar(title: "Edit Category"),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _titleController,
                    label: 'Title',
                    hint: 'Enter product title',
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        _editCategory(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      label: const Text('Update Product',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kprimaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
      ),
    );
  }
}
