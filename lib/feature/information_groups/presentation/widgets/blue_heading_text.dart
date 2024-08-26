import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';

Widget blusHeading(String name) {
  return Text(
    name,
    style: TextStyle(
        color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16.sp),
  );
}

Widget greynonBoldText(String name, {double? size}) {
  return Text(
    name,
    style: TextStyle(fontSize: size ?? 13.sp),
  );
}
