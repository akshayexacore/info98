import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:info_91_proj/core/config/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.style,
    this.disabledStyle,
    this.textStyle = AppTextStyles.appButton,
    this.width,
    this.height = AppSizes.appButtonHeight,
    this.busy = false,
    this.shadow = false,
    this.padding = 0.0,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final ButtonStyle? style;
  final ButtonStyle? disabledStyle;
  final TextStyle textStyle;
  final double? width;
  final double padding;
  final double? height;
  final bool busy;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: shadow ? BoxDecoration(boxShadow: [AppShadows.shadow]) : null,
      child: TextButton(
        onPressed: !busy ? onPressed : null,
        style: onPressed != null
            ? style ?? AppButtonStyles.appButton
            : disabledStyle ?? AppButtonStyles.appButtonDisabled,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: !busy
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                  )
                : SizedBox(
                    height: height,
                    width: height,
                    child: Padding(
                      padding: EdgeInsets.all(height! > 40 ? 16.0 : 8),
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: textStyle.color,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

TextButton customTextButton(String buttonName, {required VoidCallback onTap}) =>
    TextButton(
        onPressed: onTap,
        child: Text(
          buttonName,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              fontSize: 15.sp),
        ));
