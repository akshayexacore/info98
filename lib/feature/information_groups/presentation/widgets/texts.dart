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

Text greyBoldText(String text, {FontWeight? fontWeight,double? size,Color? color,double? height}) {
  return Text(text,
      style: GoogleFonts.poppins(
          fontSize:size??15.sp,
          color:color?? AppColors.black.withOpacity(.75),
          fontWeight: fontWeight ?? FontWeight.w500));
}

Widget blusHeading(String name) {
  return Text(
    name,
    style: GoogleFonts.poppins(
        color: AppColors.primary, fontWeight: FontWeight.w500, fontSize: 15.sp),
  );
}

Widget greynonBoldText(String name, {double? size}) {
  return Text(
    name,
    style: TextStyle(fontSize: size ?? 13.sp),
  );
}
 TextStyle chatTextstyle= GoogleFonts.poppins(
                                  fontSize: 15.sp, color: AppColors.text,fontWeight: FontWeight.w400);