import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info_91_proj/core/config/app_styles.dart';

Text greyContentText(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
        color: AppColors.text.withOpacity(.75),
        fontWeight: FontWeight.w400,
        fontSize: 13.sp),
  );
}

Text greyBoldText(String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          fontSize: 15.sp,
          color: AppColors.black.withOpacity(.75),
          fontWeight: FontWeight.w500));
}
