import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customImageCard extends StatelessWidget {
  final double? height;final double? width;final String imageUrl;
  const customImageCard({
    super.key, this.height, this.width, required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height?? 100.h,
      width:width?? 170.w,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
