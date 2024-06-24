import 'package:ecm/Provider/cart_provider.dart';
import 'package:ecm/constants.dart';
import 'package:ecm/models/product.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  final Product product;
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kprimaryColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              provider.toggleFavorite(widget.product);
              const snackBar = SnackBar(
                content: Text(
                  "Berhasil Ditambah",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Container(
              height: 55,
              alignment: Alignment.center,
              child: const Text(
                "Add to cart",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
