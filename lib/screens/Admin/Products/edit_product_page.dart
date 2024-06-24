import 'dart:io';
import 'package:ecm/constants.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecm/models/product.dart';
import 'package:ecm/screens/Admin/Products/admin_product_app_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductPage extends StatefulWidget {
  final Product product;
  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
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
    _initEditFields();
  }

  void _initEditFields() {
    _titleController.text = widget.product.title;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
    _sellerController.text = widget.product.seller;
    _categoryController.text = widget.product.category;
    _reviewController.text = widget.product.review.toString();
    _quantityController.text = widget.product.quantity.toString();
    _imageUrl = widget.product.image;
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
        _imageUrl = null; // Clear previous image URL if any
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

  void _editProduct(BuildContext context) async {
    if (_isUploading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please wait for the image to finish uploading')),
      );
      return;
    }
    String title = _titleController.text;
    String description = _descriptionController.text;
    int? price = int.tryParse(_priceController.text);
    String seller = _sellerController.text;
    String category = _categoryController.text;
    int? review = int.tryParse(_reviewController.text);
    int? quantity = int.tryParse(_quantityController.text);

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('field price must be an number')),
      );
      return;
    }
    if (review == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('field review must be an number')),
      );
      return;
    }
    if (quantity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('field quantity must be an number')),
      );
      return;
    }

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        price != null &&
        seller.isNotEmpty &&
        category.isNotEmpty &&
        review != null &&
        quantity != null) {
      try {
        if (_image != null && _imageUrl == null) {
          await _uploadImage();
        }

        await _firestore.collection('products').doc(widget.product.id).update({
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
          const SnackBar(content: Text('Product updated successfully')),
        );
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update product')),
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
            const AdminProductAppBar(title: "Edit Product"),
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
                    value:
                        _categoryController.text, // Nilai default dari kategori
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _categoryController.text = newValue!;
                      });
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
                  _image != null
                      ? Image.file(
                          _image!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : _imageUrl != null
                          ? Image.network(
                              _imageUrl!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : const Text('No image selected.'),
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
                              backgroundColor: kprimaryColor),
                        ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_image != null && _imageUrl == null) {
                          await _uploadImage();
                        }
                        _editProduct(context);
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
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
      ),
    );
  }
}
