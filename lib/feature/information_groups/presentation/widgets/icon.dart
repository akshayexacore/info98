import 'package:flutter/material.dart';

Widget clickebleIcon(String image,VoidCallback onTap){return InkWell(onTap: onTap,child: Image.asset(image),);}