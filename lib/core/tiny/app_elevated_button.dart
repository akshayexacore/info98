import 'package:flutter/material.dart';
import 'package:info_91_proj/core/config/app_styles.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    this.onPressed,
    this.showBackGround = true,
    required this.child,
  }) : super(key: key);
  final VoidCallback? onPressed;

  final size = AppSizes.appBackButton;
  final bool showBackGround;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: showBackGround ? AppColors.white : null,
        borderRadius: const BorderRadius.all(Radius.circular(AppRadii.medium)),
        boxShadow: [
          if (showBackGround) AppShadows.shadow,
        ],
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadii.medium)),
        child: Stack(
          children: [
            SizedBox(height: size, width: size, child: Center(child: child)),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
