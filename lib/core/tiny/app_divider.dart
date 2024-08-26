import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';

Padding customDivider({EdgeInsets? padding, double? thickness}) {
  return Padding(
      padding: padding ??
          EdgeInsets.only(left: 80.0.w), // Adjust this value for more space
      child: Divider(
        color: AppColors.white, // Color of the divider
        thickness: thickness ?? .6, // Thickness of the divider
      ));
}
