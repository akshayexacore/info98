import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/image_view.dart';
import 'package:info_91_proj/core/tiny/app_button.dart';
import 'package:info_91_proj/core/tiny/app_input_text.dart';
import 'package:info_91_proj/feature/profile/controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  static const routeName = '/profile';

  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.splashBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppSpacings.small,
                ),
                Text(
                  "Profile",
                  style: AppTextStyles.appTitle,
                ),
                const SizedBox(
                  height: AppSpacings.xxLarge,
                ),
                Obx(() {
                  return Stack(
                    children: [
                      CircleAvatar(
                          radius: 60,
                          child: _controller.selectedFile.value.isURL ||
                                  _controller.selectedFile.isEmpty
                              ? AppNetworkImage(_controller.selectedFile.value,
                                  placeholder:
                                      Image.asset("assets/images/ic_user.png"))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.file(
                                    File(_controller.selectedFile.value),
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ))),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                              onTap: _controller.showUploadOptions,
                              child: CircleAvatar(
                                radius: 17,
                                child: Icon(Icons.edit,
                                    color: AppColors.white, size: 20),
                                backgroundColor: AppColors.primary,
                              )))
                    ],
                  );
                }),
                const SizedBox(
                  height: AppSpacings.medium,
                ),
                AppInputText(
                  shadow: false,
                  border: true,
                  hintText: "Full Name",
                  keyboardType: TextInputType.name,
                  controller: _controller.textControllerName,
                ),
                const SizedBox(
                  height: 15,
                ),
                AppInputText(
                  shadow: false,
                  border: true,
                  hintText: "About",
                  keyboardType: TextInputType.name,
                  controller: _controller.textControllerAbout,
                ),
                const SizedBox(
                  height: AppSpacings.xxxLarge,
                ),
                Obx(() {
                  return AppButton(
                      text: "DONE",
                      busy: _controller.busy.value,
                      onPressed: _controller.updateProfile);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
