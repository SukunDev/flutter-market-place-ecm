import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecm/constants.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'Widget/home_app_bar.dart';
import 'Widget/image_slide.dart';
import 'Widget/product_cart.dart';
import 'Widget/search_bar.dart';

import '../../models/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<List<Product>>> _categoriesFuture;
  late Future<List<Category>> _categoriesListFuture;
  int currentSlider = 0;
  int selectedIndex = 0;

  final List<Category> categoriesList = [
    Category(title: "All", id: ""),
  ];

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _fetchAndGroupProducts();
    _categoriesListFuture = _fetchCategories();
  }

  Future<List<List<Product>>> _fetchAndGroupProducts() async {
    List<Product> products = await fetchProducts();
    return groupProductsByCategory(products);
  }

  Future<List<Product>> fetchProducts() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    return querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  }

  Future<List<Category>> _fetchCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('category').get();

    List<Category> categories =
        querySnapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();

    setState(() {
      categoriesList.addAll(categories);
    });

    return categories;
  }

  List<List<Product>> groupProductsByCategory(List<Product> products) {
    List<Product> all = [];
    Map<String, List<Product>> categoryMap = {};

    for (Product product in products) {
      all.add(product);
      if (!categoryMap.containsKey(product.category)) {
        categoryMap[product.category] = [];
      }
      categoryMap[product.category]!.add(product);
    }

    List<List<Product>> groupedProducts = [all];
    for (var category in categoriesList) {
      if (category.id.isNotEmpty) {
        groupedProducts.add(categoryMap[category.title] ?? []);
      }
    }

    return groupedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<List<Product>>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          List<List<Product>> selectcategories = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35),
                  // for custom appbar
                  const CustomAppBar(),
                  const SizedBox(height: 20),
                  // for search bar
                  const MySearchBAR(),
                  const SizedBox(height: 20),
                  ImageSlider(
                    currentSlide: currentSlider,
                    onChange: (value) {
                      setState(() {
                        currentSlider = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Untuk category selection
                  categoryItems(),
                  const SizedBox(height: 20),
                  const Text(
                    "Product",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // for shopping items
                  const SizedBox(height: 10),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: selectcategories[selectedIndex].length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: selectcategories[selectedIndex][index],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox categoryItems() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex =
                    index; // mengarah ke selected category yang ditekan
              });
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 7, 16, 0),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:
                    selectedIndex == index ? kprimaryColor : Colors.grey[100],
              ),
              child: Text(categoriesList[index].title,
                  style: TextStyle(
                    color: selectedIndex == index ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          );
        },
      ),
    );
  }
}
