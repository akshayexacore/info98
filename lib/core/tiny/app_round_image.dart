import 'package:flutter/material.dart';

Widget circle_image(String avatarUrl, {Function? onTap, double radius = 18}) {
  return InkWell(
    onTap: () {
      if (onTap != null) {
        onTap();
      }
    },
    child: CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(avatarUrl),
    ),
  );
}
