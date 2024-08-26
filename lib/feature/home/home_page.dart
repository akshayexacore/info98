import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/image_view.dart';
import 'package:info_91_proj/feature/home/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      AppColors.splashBackground,
                      AppColors.splashBackground
                    ])),
                child: Stack(
                  children: [
                    Center(
                      child: AppAssetImage(
                        "assets/images/app_icon.png",
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "Home",
                style: AppTextStyles.appHeader,
              ),
              TextButton(
                  onPressed: _controller.logout, child: const Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}
