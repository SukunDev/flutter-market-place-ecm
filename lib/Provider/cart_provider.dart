import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  final CollectionReference _cartCollection =
      FirebaseFirestore.instance.collection('carts');

  void toggleFavorite(Product product) {
    if (_cart.contains(product)) {
      for (Product element in _cart) {
        element.quantity++;
      }
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

  void incrementQtn(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  void decrementQtn(int index) {
    if (_cart[index].quantity <= 1) {
      return;
    }
    _cart[index].quantity--;
    notifyListeners();
  }

  double totalPrice() {
    double total1 = 0.0;
    for (Product element in _cart) {
      total1 += element.price * element.quantity;
    }
    return total1;
  }

  Future<void> saveCartToDatabase(String userId) async {
    List<Map<String, dynamic>> cartData = _cart
        .map((product) => {
              'id': product.id,
              'title': product.title,
              'price': product.price,
              'quantity': product.quantity,
              'description': product.description,
              'seller': product.seller,
              'category': product.category,
              'image': product.image,
              'review': product.review,
            })
        .toList();

    try {
      await _cartCollection.doc(userId).set({'cartItems': cartData});
      print('Cart data has been written successfully');
    } catch (error) {
      print('Failed to write cart data: $error');
    }
  }

  Future<void> loadCartFromDatabase(String userId) async {
    try {
      DocumentSnapshot cartSnapshot = await _cartCollection.doc(userId).get();

      if (cartSnapshot.exists) {
        List<dynamic> cartData = cartSnapshot.get('cartItems');

        _cart.clear();
        cartData.forEach((item) {
          _cart.add(Product(
            id: item['id'],
            title: item['title'],
            price: item['price'],
            quantity: item['quantity'],
            description: item['description'],
            seller: item['seller'],
            category: item['category'],
            image: item['image'],
            review: item['review'],
          ));
        });

        notifyListeners();
      }
    } catch (error) {
      print('Failed to load cart data: $error');
    }
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }
}
