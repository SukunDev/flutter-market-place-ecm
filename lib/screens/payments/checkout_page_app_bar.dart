import 'package:flutter/material.dart';

import '../../../constants.dart';

class CheckoutPageAppBar extends StatelessWidget {
  final String title;
  const CheckoutPageAppBar({super.key, required this.title});

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
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20),
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
      ],
    );
  }
}
