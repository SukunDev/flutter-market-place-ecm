import 'package:ecm/Provider/favorite_provider.dart';
import 'package:ecm/constants.dart';
import 'package:ecm/models/product.dart';
import 'package:ecm/screens/Detail/detail_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth * 1;
        double cardHeight = constraints.maxHeight * 1;
        double imageHeight = cardHeight * 0.6;
        double fontSize = MediaQuery.of(context).size.width * 0.04;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(product: product),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                width: cardWidth,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: product.image,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          product.image,
                          width: cardWidth,
                          height: imageHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Rp.${product.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize + 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      provider.toggleFavorite(product);
                    },
                    child: Icon(
                      provider.isExist(product)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
