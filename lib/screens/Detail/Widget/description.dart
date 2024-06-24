import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String description;
  const Description({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
