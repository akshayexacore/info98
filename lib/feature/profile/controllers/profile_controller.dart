import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/image_view.dart';
import 'package:info_91_proj/core/utils/app_validator.dart';
import 'package:info_91_proj/core/widgets.dart/app_dialog.dart';
import 'package:info_91_proj/feature/auth/data/auth_repository.dart';
import 'package:info_91_proj/feature/auth/data/models/user.dart';
import 'package:info_91_proj/feature/auth/data/user_repository.dart';
import 'package:info_91_proj/feature/auth/presentation/pages/login_page.dart';
import 'package:info_91_proj/feature/home/home_page.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ProfileController extends GetxController {
  late var busy = false.obs;
  late var isNameValid = false.obs;

  late final textControllerName = TextEditingController();
  late final textControllerAbout = TextEditingController();
  late final _userProfileRepository = UserProfileRepository();
  late final _authRepository = AuthRepository();
  var user = Rxn<User>();

  late ProgressDialog pr;
  var progress = 0.obs;
  var selectedFile = ''.obs;

  @override
  void onInit() {
    pr = ProgressDialog(Get.context!, isDismissible: false);
    getUser();
    super.onInit();
  }

  void getUser() async {
    try {
      busy(true);
      final response = await _userProfileRepository.getUser();
      if (response.success) {
        user(response.user);
        textControllerName.text = user.value?.name ?? '';
        textControllerAbout.text = user.value?.about ?? '';
        selectedFile(response.user?.image);
      }
    } catch (_) {
      AppDialog.showToast(_.toString());
    } finally {
      busy(false);
    }
  }

  void logout() {
    AppDialog.showDialog(
        title: "LOGOUT",
        content: "Are you sure you want to logout?",
        negativeText: "Cancel",
        negativeOnPressed: Get.back,
        dismissible: true,
        positiveText: "Logout",
        positiveOnPressed: _logout);
  }

  _logout() {
    _authRepository.logoutUser();
    Get.offAllNamed(LoginPage.routeName);
  }

  void updateProfile() async {
    try {
      busy(true);
      if (!validate()) {
        return;
      }
      await pr.show();
      pr.update(message: "Updating profile...");
      final response = await _userProfileRepository.updateUser(
          textControllerName.text.trim(),
          textControllerAbout.text.trim(),
          selectedFile.value.isURL ? '' : selectedFile.value,
          onProgress);
      pr.hide();
      if (response.isSuccess) {
        AppDialog.showDialog(
            title: 'Success ',
            content: response.message,
            positiveText: "Ok",
            positiveOnPressed: () {
              Get.offAllNamed(HomePage.routeName);
            });
      } else {
        AppDialog.showSnackBar('Failed ', response.message);
      }
    } catch (_) {
      pr.hide();
      print(_.toString());
      if (_ is DioError) {
        print(_.response?.statusMessage);
        print(_.response?.data);
        AppDialog.showSnackBar(
            'Failed ', _.response?.data['message'] ?? 'Bill uploading failed');
      }
    } finally {
      busy(false);
      pr.hide();
    }
  }

  bool validate() {
    if (textControllerName.text.trim().isEmpty ||
        !AppValidator.isValidName(textControllerName.text)) {
      AppDialog.showSnackBar("Error", "Enter valid name");
      return false;
    }
    /*if(textControllerAbout.text.trim().isEmpty){
      AppDialog.showSnackBar("Error","Enter about yourself");
      return false;
    }
    if(selectedFile.isEmpty || extension(selectedFile.value).isEmpty){
      AppDialog.showSnackBar("Error","Please select a profile picture.");
      return false;
    }*/
    return true;
  }

  void pickFromCamera() async {
    Get.back();
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      //selectedFile(photo.path);
      cropImage(photo.path);
    }
  }

  void pickFromGallery() async {
    Get.back();
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      //selectedFile(photo.path);
      cropImage(photo.path);
    }
  }

  void cropImage(String image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        // cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            aspectRatioLockEnabled: true,
          )
        ]);
    if (croppedFile != null) {
      selectedFile(croppedFile.path);
    }
  }

  void clearImage() async {
    Get.back();
    AppDialog.showDialog(
        title: "Remove",
        content: "Are you sure you want to remove Profile Picture?",
        negativeText: "Cancel",
        negativeOnPressed: Get.back,
        dismissible: true,
        positiveText: "Remove",
        positiveOnPressed: () {
          selectedFile('');
          Get.back();
        });
  }

  void showUploadOptions() {
    Get.bottomSheet(
        DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 1, width: MediaQuery.sizeOf(context).width),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: pickFromCamera,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  child: const AppAssetImage(
                                    "assets/images/ic_camera.png",
                                    height: 24,
                                  ),
                                  backgroundColor: AppColors.secondary),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Camera",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: pickFromGallery,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  child: const AppAssetImage(
                                    "assets/images/ic_gallery.png",
                                    height: 24,
                                  ),
                                  backgroundColor: AppColors.secondary),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Gallery",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: clearImage,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  child: const AppAssetImage(
                                    "assets/images/ic_delete.png",
                                    height: 24,
                                  ),
                                  backgroundColor: AppColors.secondary),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Delete",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            expand: false,
            maxChildSize: 1,
            initialChildSize: 0.4),
        backgroundColor: AppColors.white);
  }

  void onProgress(int value) {
    progress(value);
  }
}
