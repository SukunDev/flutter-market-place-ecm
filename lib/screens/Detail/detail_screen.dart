import 'package:ecm/constants.dart';
import 'package:ecm/models/product.dart';
import 'package:ecm/screens/Detail/Widget/addto_cart.dart';
import 'package:ecm/screens/Detail/Widget/description.dart';
import 'package:ecm/screens/Detail/Widget/detail_app_bar.dart';
import 'package:ecm/screens/Detail/Widget/image_slide.dart';
import 'package:ecm/screens/Detail/Widget/items_details.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentImage = 0;
  int currentColor = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kcontentColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              DetailAppBar(
                product: widget.product,
              ),
              // for detail image slider
              MyImageSlider(
                image: widget.product.image,
                onChange: (index) {
                  setState(() {
                    currentImage = index;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => AnimatedContainer(
                    duration: const Duration(microseconds: 300),
                    width: currentImage == index ? 15 : 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentImage == index
                          ? Colors.black
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemsDetails(product: widget.product),
                    const SizedBox(height: 25),
                    // for description
                    Description(
                      description: widget.product.description,
                    ),
                    const SizedBox(height: 15),
                    AddToCart(product: widget.product)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
