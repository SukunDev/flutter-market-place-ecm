import 'package:flutter/material.dart';

class MySearchBAR extends StatelessWidget {
  const MySearchBAR({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.black45)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.black54,
            size: 24,
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search...", border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
