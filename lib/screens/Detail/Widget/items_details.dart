import 'package:ecm/models/product.dart';
import 'package:flutter/material.dart';

class ItemsDetails extends StatelessWidget {
  final Product product;
  const ItemsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rp.${product.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Seller: \n",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text: product.seller,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
