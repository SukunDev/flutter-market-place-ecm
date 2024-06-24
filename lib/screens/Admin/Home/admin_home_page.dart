import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecm/constants.dart';
import 'package:ecm/screens/Admin/admin_app_bar.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late List<Map<String, String>> admins;
  late String totalUser;
  late String totalProduct;

  @override
  void initState() {
    super.initState();
    admins = [];
    totalUser = "0";
    totalProduct = "0";
    getUsers();
    getProducts();
  }

  void getUsers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    for (var doc in querySnapshot.docs) {
      var name = "nama belum di isi";
      var email = "email belum di isi";
      if (doc.exists) {
        try {
          name = doc.get('name');
          email = doc.get('email');
        } catch (e) {
          email = doc.get('email');
        }
        if (doc.get('isAdmin')) {
          admins.add(
              {"name": name, "email": email, "avatar": "assets/profile3.png"});
        }
      }
    }
    setState(() {
      totalUser = querySnapshot.docs.length.toString();
    });
  }

  // Fetch all documents from 'products' collection
  void getProducts() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();
    setState(() {
      totalProduct = querySnapshot.docs.length.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            const AdminAppBar(
              title: "Home",
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDataProductCard(),
                  const SizedBox(height: 20),
                  _buildDataUsersCard(),
                  const SizedBox(height: 20),
                  _buildDataAdminCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataProductCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Product',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            totalProduct,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kprimaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Jumlah keseluruhan product',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildDataUsersCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Users',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            totalUser,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kprimaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Jumlah keseluruhan users',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildDataAdminCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Admin',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: admins.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(admins[index]['avatar']!),
                ),
                title: Text(
                  admins[index]['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kprimaryColor,
                  ),
                ),
                subtitle: Text(
                  admins[index]['email']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kprimaryColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
