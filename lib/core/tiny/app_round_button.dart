import 'package:flutter/material.dart';

import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_button.dart';

class AppRoundButton extends StatelessWidget {
  const AppRoundButton(
      {Key? key,
      this.onPressed,
      required this.text,
      this.style,
      this.disabledStyle,
      this.textStyle = AppTextStyles.appButton,
      this.width,
      this.height = AppSizes.appButtonHeight,
      this.busy = false,
      this.padding = 0.0})
      : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final ButtonStyle? style;
  final ButtonStyle? disabledStyle;
  final TextStyle textStyle;
  final double? width;
  final double padding;
  final double? height;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      style: style,
      disabledStyle: disabledStyle,
      textStyle: textStyle,
      width: width,
      height: height,
      busy: busy,
      padding: padding,
    );
  }
}
