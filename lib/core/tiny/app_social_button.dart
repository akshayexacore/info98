import 'package:flutter/material.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/image_view.dart';

class AppSocialButton extends StatelessWidget {
  const AppSocialButton({
    Key? key,
    this.onPressed,
    this.style,
    this.disabledStyle,
    this.textStyle = AppTextStyles.appButton,
    this.width,
    required this.icon,
    required this.color,
    this.height = 37.0,
    this.textColor = AppColors.black,
    this.busy = false,
    this.shadow = false,
    this.padding = 24.0,
    this.contentSpacing = 20,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String icon;
  final Color color;
  final ButtonStyle? style;
  final ButtonStyle? disabledStyle;
  final TextStyle textStyle;
  final Color textColor;
  final double? width;
  final double padding;
  final double contentSpacing;
  final double? height;
  final bool busy;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          boxShadow: shadow ? [AppShadows.shadow] : null,
          borderRadius: BorderRadius.circular(5),
          color: color),
      child: TextButton(
        onPressed: !busy ? onPressed : null,
        style: onPressed != null
            ? style ??
                AppButtonStyles.appButton.copyWith(
                    backgroundColor: MaterialStateProperty.all<Color>(color),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3))))
            : disabledStyle ?? AppButtonStyles.appButtonDisabled,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: !busy
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: padding, vertical: 8),
                    child: AppAssetImage(icon, height: 44),
                  )
                : SizedBox(
                    height: height,
                    width: height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
