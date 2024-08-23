import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/image_view.dart';
import 'package:info_91_proj/feature/splash/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  static const routeName = '/';

  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Center(
        child: AppAssetImage(
          'assets/images/app_icon.png',
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
