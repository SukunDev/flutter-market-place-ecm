//import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final String review;
  final String seller;
  final double price;
  // final List<Color> colors;
  final String category;
  int quantity;

  Product(
      {required this.id,
      required this.title,
      required this.review,
      required this.description,
      required this.image,
      required this.price,
      // required this.colors,
      required this.seller,
      required this.category,
      required this.quantity});
}

// produk
final List<Product> all = [
  //menu all 1 produk untuk 1 kategori
  Product(
    id: 1,
    title: "Daging Ayam",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/ayam/ayam.png",
    price: 100000,
    seller: "MeatMart",
    // colors: [
    //   Colors.black,
    //   Colors.blue,
    //   Colors.orange,
    // ],
    category: "Daging Ayam", // ayam
    review: "(20 Review)",
    quantity: 1,
  ),
  Product(
    id: 2,
    title: "Ribeye",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/sapi/Ribeye.jpg",
    price: 100000,
    seller: "MeatMart",
    // colors: [
    //   Colors.brown,
    //   Colors.deepPurple,
    //   Colors.pink,
    // ],
    category: "dagingsapi", // sapi
    review: "(32 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 3,
    title: "Kepiting",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/seafoot/kepiting.jpeg",
    price: 50000,
    seller: "MeatMart",
    // colors: [
    //   Colors.black,
    //   Colors.amber,
    //   Colors.purple,
    // ],
    category: "seafoot", //seafoot
    review: "(20 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 4,
    title: "Anggur",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/organik/anggur.jpeg",
    price: 155,
    seller: "MeatMart",
    // colors: [
    //   Colors.blueAccent,
    //   Colors.orange,
    //   Colors.green,
    // ],
    category: "organik", //organik
    review: "(20 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 5,
    title: "Bakso Ikan",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/olahan/baksoikan.jpeg",
    price: 1000,
    seller: "CEDEA",
    // colors: [
    //   Colors.lightBlue,
    //   Colors.orange,
    //   Colors.purple,
    // ],
    category: "olahan", //olahan
    review: "(100 Reviews)",
    quantity: 1,
  ),
];

final List<Product> dagingayam = [
  // kategori daging ayam
  Product(
    id: 1,
    title: "Daging Ayam",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/ayam/ayam.png",
    price: 100000,
    seller: "MeatMart",
    // colors: [
    //   Colors.black,
    //   Colors.blue,
    //   Colors.orange,
    // ],
    category: "dagingayam",
    review: "(20 Review)",
    quantity: 1,
  ),
  Product(
    id: 6,
    title: "Paha Ayam",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/ayam/paha.png",
    price: 100000,
    seller: "MeatMart",
    // colors: [
    //   Colors.brown,
    //   Colors.deepPurple,
    //   Colors.pink,
    // ],
    category: "dagingayam",
    review: "(32 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 7,
    title: "Dada Ayam",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/ayam/Dada.jpg",
    price: 500,
    seller: "MeatMart",
    // colors: [
    //   Colors.red,
    //   Colors.orange,
    //   Colors.greenAccent,
    // ],
    category: "dagingayam",
    review: "(100 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 8,
    title: "Sayap Ayam",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/ayam/sayap.png",
    price: 155,
    seller: "MeatMart",
    // colors: [
    //   Colors.deepPurpleAccent,
    //   Colors.orange,
    //   Colors.green,
    // ],
    category: "dagingayam",
    review: "(60 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 9,
    title: "Hati Ayam",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/ayam/hati.jpg",
    price: 1000,
    seller: "MeatMart",
    // colors: [
    //   Colors.blueAccent,
    //   Colors.orange,
    //   Colors.green,
    // ],
    category: "dagingayam",
    review: "(00 Reviews)",
    quantity: 1,
  ),
];

final List<Product> dagingsapi = [
  // kategori daging sapi
  Product(
    id: 10,
    title: "Tenderloin",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/sapi/Tenderloin.jpg",
    price: 50000,
    seller: "MeatMart",
    // colors: [
    //   Colors.black,
    //   Colors.amber,
    //   Colors.purple,
    // ],
    category: "dagingsapi",
    review: "(20 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 11,
    title: "Rump",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/sapi/Rump.jpg",
    price: 50000,
    seller: "MeatMart",
    // colors: [
    //   Colors.black,
    //   Colors.amber,
    //   Colors.purple,
    // ],
    category: "dagingsapi",
    review: "(20 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 2,
    title: "Ribeye",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/sapi/Ribeye.jpg",
    price: 155,
    seller: "MeatMart",
    // colors: [
    //   Colors.purpleAccent,
    //   Colors.pinkAccent,
    //   Colors.green,
    // ],
    category: "dagingsapi",
    review: "(99 Reviews)",
    quantity: 1,
  ),
];

final List<Product> seafoot = [
  //kategori seafoat
  Product(
    id: 3,
    title: "Kepiting",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/seafoot/kepiting.jpeg",
    price: 299,
    seller: "MeatMart",
    // colors: [
    //   Colors.grey,
    //   Colors.black54,
    //   Colors.purple,
    // ],
    category: "seafoot",
    review: "(25 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 12,
    title: "Udang",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/seafoot/udang.webp",
    price: 666,
    seller: "MeatMart",
    // colors: [
    //   Colors.black,
    //   Colors.orange,
    //   Colors.green,
    // ],
    category: "seafoot",
    review: "(100 Reviews)",
    quantity: 1,
  ),
];

final List<Product> olahan = [
  // kategori produk olahan berbahan daging ayam atau sapi
  Product(
    id: 5,
    title: "Bakso Ikan",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/olahan/baksoikan.jpeg",
    price: 3000,
    seller: "CEDEA",
    // colors: [
    //   Colors.amber,
    //   Colors.deepPurple,
    //   Colors.pink,
    // ],
    category: "olahan",
    review: "(320 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 13,
    title: "Bola Udang",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/olahan/bolaudang.jpeg",
    price: 300,
    seller: "CEDEA",
    // colors: [
    //   Colors.pink,
    //   Colors.orange,
    //   Colors.redAccent,
    // ],
    category: "olahan",
    review: "(100 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 14,
    title: "Bakso Daging",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/olahan/bsd.jpg",
    price: 155,
    seller: "MeatMart",
    // colors: [
    //   Colors.brown,
    //   Colors.purpleAccent,
    //   Colors.blueGrey,
    // ],
    category: "olahan",
    review: "(80 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 15,
    title: "Nuggets Ayam",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/olahan/nuggets.jpg",
    price: 5000,
    seller: "MeatMart",
    // colors: [
    //   Colors.blueAccent,
    //   Colors.orange,
    //   Colors.green,
    // ],
    category: "olahan",
    review: "(22 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 16,
    title: "Sosis Ayam",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/olahan/nuggets.jpg",
    price: 5000,
    seller: "MeatMart",
    // colors: [
    //   Colors.blueAccent,
    //   Colors.orange,
    //   Colors.green,
    // ],
    category: "olahan",
    review: "(22 Reviews)",
    quantity: 1,
  ),
];

final List<Product> organik = [
  // kategori organik berisi buah dan sayur
  Product(
    id: 4,
    title: "Anggur",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/organik/anggur.jpeg",
    price: 500,
    seller: "MeatMart",
    // colors: [
    //   Colors.brown,
    //   Colors.orange,
    //   Colors.blueGrey,
    // ],
    category: "organik",
    review: "(90 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 17,
    title: "Kentang",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/organik/kentang.jpg",
    price: 400,
    seller: "MeatMart",
    // colors: [
    //   Colors.black54,
    //   Colors.orange,
    //   Colors.green,
    // ],
    category: "organik",
    review: "(500 Reviews)",
    quantity: 1,
  ),
  Product(
    id: 18,
    title: "Strowberi",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/images/product/organik/strowberi.jpeg",
    price: 300,
    seller: "MeatMart",
    // colors: [
    //   Colors.pink,
    //   Colors.amber,
    //   Colors.green,
    // ],
    category: "organik",
    review: "(200 Reviews)",
    quantity: 1,
  ),
];
