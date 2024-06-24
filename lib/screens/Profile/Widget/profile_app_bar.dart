import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(left: 72),
          child: Text(
            'Profile',
            style: TextStyle(
              color: kprimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Spacer(),
        Padding(
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
