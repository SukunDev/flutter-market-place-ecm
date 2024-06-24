import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecm/constants.dart';
import 'package:ecm/screens/Auth/login_page.dart';
import 'package:ecm/screens/Profile/Widget/profile_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = "";
  String email = "";
  String phoneNumber = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        name = userDoc['name'];
        email = userDoc['email'];
        phoneNumber = userDoc['phone_number'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                "assets/profile3.png",
                fit: BoxFit.cover,
                height: size.height * 0.6,
                width: size.width,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 35),
              const ProfileAppBar(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: kcontentColor,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Profile",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text("Email",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          )),
                                      SizedBox(height: 20),
                                      Text("Phone Number",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ))
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 22),
                                      Text(email,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          )),
                                      const SizedBox(height: 22),
                                      Text(phoneNumber,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                          ))
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                            // Navigasi ke layar login atau tindakan lain setelah logout
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kprimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
