import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecm/screens/Admin/admin_nav_bar_screen.dart';
import 'package:ecm/screens/Auth/login_page.dart';
import 'package:ecm/screens/nav_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          final User? user = snapshot.data;
          if (user == null) {
            return const LoginPage();
          } else {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  final isAdmin = snapshot.data?.get('isAdmin') ?? false;
                  if (isAdmin) {
                    return const AdminBottomNavBar();
                  } else {
                    return const BottomNavBar();
                  }
                }
              },
            );
          }
        }
      },
    );
  }
}
