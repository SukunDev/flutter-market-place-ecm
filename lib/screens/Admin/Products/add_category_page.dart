import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecm/constants.dart';
import 'package:ecm/screens/Admin/Products/admin_product_app_bar.dart';
import 'package:flutter/material.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _titleController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  void _addCategory(BuildContext context) async {
    String title = _titleController.text;

    if (title.isNotEmpty) {
      await _firestore.collection('category').add({
        'title': title,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category added successfully')),
      );
      Navigator.pop(context);
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
            const AdminProductAppBar(title: "Add Category"),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: <Widget>[
                  _buildTextField(
                    controller: _titleController,
                    label: 'Title',
                    hint: 'Enter product title',
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        _addCategory(context);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: const Text('Add Category',
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
