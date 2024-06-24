import 'package:ecm/constants.dart';
import 'package:ecm/screens/Admin/Home/admin_home_page.dart';
import 'package:ecm/screens/Admin/Products/admin_product_page.dart';
import 'package:ecm/screens/Admin/Profile/admin_profile_page.dart';
import 'package:ecm/screens/Admin/Users/admin_users_page.dart';
import 'package:flutter/material.dart';

class AdminBottomNavBar extends StatefulWidget {
  const AdminBottomNavBar({super.key});

  @override
  State<AdminBottomNavBar> createState() => _AdminBottomNavBarState();
}

class _AdminBottomNavBarState extends State<AdminBottomNavBar> {
  int cuttentIndex = 0;
  List screens = const [
    AdminHomePage(),
    AdminUsersPage(),
    AdminProductPage(),
    AdminProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentIndex = 0;
                });
              },
              icon: Icon(
                Icons.home,
                size: 30,
                color: cuttentIndex == 0 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentIndex = 1;
                });
              },
              icon: Icon(
                Icons.search,
                size: 30,
                color: cuttentIndex == 1 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentIndex = 2;
                });
              },
              icon: Icon(
                Icons.table_rows_rounded,
                size: 30,
                color: cuttentIndex == 2 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttentIndex = 3;
                });
              },
              icon: Icon(
                Icons.person,
                size: 30,
                color: cuttentIndex == 3 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[cuttentIndex],
    );
  }
}
