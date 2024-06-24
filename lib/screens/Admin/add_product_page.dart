import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sellerController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;
  String? _imageUrl;
  bool _isUploading = false;
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    QuerySnapshot snapshot = await _firestore.collection('category').get();
    List<String> categories =
        snapshot.docs.map((doc) => doc['title'].toString()).toList();
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;
    setState(() {
      _isUploading = true;
    });
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('product/${_categoryController.text}/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _imageUrl = downloadUrl;
      _isUploading = false;
    });
  }

  void _addProduct(BuildContext context) async {
    if (_isUploading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please wait for the image to finish uploading')),
      );
      return;
    }
    String title = _titleController.text;
    String description = _descriptionController.text;
    double? price = double.tryParse(_priceController.text);
    String seller = _sellerController.text;
    String category = _categoryController.text;
    int? review = int.tryParse(_reviewController.text);
    int? quantity = int.tryParse(_quantityController.text);

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        _imageUrl != null &&
        price != null &&
        seller.isNotEmpty &&
        category.isNotEmpty &&
        review != null &&
        quantity != null) {
      await _firestore.collection('products').add({
        'title': title,
        'description': description,
        'image': _imageUrl,
        'price': price,
        'seller': seller,
        'category': category,
        'review': review,
        'quantity': quantity,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
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
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              _buildTextField(
                controller: _titleController,
                label: 'Title',
                hint: 'Enter product title',
              ),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter product description',
                maxLines: 3,
              ),
              _buildTextField(
                controller: _priceController,
                label: 'Price',
                hint: 'Enter product price',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _sellerController,
                label: 'Seller',
                hint: 'Enter seller name',
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  hintText: 'Select product category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  _categoryController.text = newValue!;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _reviewController,
                label: 'Review',
                hint: 'Enter product review',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _quantityController,
                label: 'Quantity',
                hint: 'Enter product quantity',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!, height: 150),
              const SizedBox(height: 10),
              _isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      label: const Text('Pick Image',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                    ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_image != null && _imageUrl == null) {
                      await _uploadImage();
                    }
                    _addProduct(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text('Add Product',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
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
