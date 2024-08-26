import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSpcaeBetweenText extends StatelessWidget {
  final String rightText;
  final String leftText;
  const CustomSpcaeBetweenText({
    super.key,
    required this.rightText,
    required this.leftText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Text(
            leftText,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.sp,
            ),
          ),
          const Spacer(),
          Text(
            rightText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
