import 'package:flutter/material.dart';

import '../../../constants.dart';

class AdminProductAppBar extends StatelessWidget {
  final String title;
  const AdminProductAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 72),
          child: Text(
            title,
            style: const TextStyle(
              color: kprimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: 18),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/profile3.png"),
          ),
        ),
      ],
    );
  }
}
