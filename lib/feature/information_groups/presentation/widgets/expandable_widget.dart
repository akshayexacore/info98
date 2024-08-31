import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info_91_proj/core/config/app_styles.dart'; 
import 'package:readmore/readmore.dart';

class ExpandableTextWidget extends StatelessWidget {
  final String text;
  final int count;


   ExpandableTextWidget({
    Key? key,
    required this.text,this.count=4
    // Default height
  }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return 
ReadMoreText( 
            text, 
              trimLines: count, trimLength: 4,
              
              colorClickableText:AppColors.secondary, 
              trimMode: TrimMode.Line, 
              trimCollapsedText: 'more', 
              trimExpandedText: 'Show less', 
              style: GoogleFonts.poppins(color: AppColors.text, fontSize: 13.sp), 
              moreStyle: TextStyle( 
                            fontSize: 12.sp, 
                            fontWeight: FontWeight.bold, 
                            color: AppColors.secondary), 
                      ); 
}}
