import 'package:flutter/material.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/image_view.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
    this.onPressed,
    this.showBackGround = true,
    this.color = AppColors.hint,
  }) : super(key: key);
  final VoidCallback? onPressed;

  final size = AppSizes.appBackButton;
  final bool showBackGround;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: showBackGround ? AppColors.white : null,
          borderRadius:
              const BorderRadius.all(Radius.circular(AppRadii.medium)),
          boxShadow: [
            if (showBackGround) AppShadows.shadow,
          ],
        ),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              child: AppSvgAsset(
                'assets/images/ic_left.svg',
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
