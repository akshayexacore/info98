import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info_91_proj/core/tiny/app_round_image.dart';

class ProfileTopImageSec extends StatelessWidget {
  final String backGroundImage;
  final String profileImage;
  final bool isAdmin;
  final bool isProfile;
  const ProfileTopImageSec(
      {super.key,
      required this.backGroundImage,
      required this.profileImage,
      this.isAdmin = false,
      this.isProfile = true});
  void pickFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      //selectedFile(photo.path);
      // cropImage(photo.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  backGroundImage,
                ),
                fit: BoxFit.cover),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 8.h),
                child: InkWell(
                  onTap: () {
                    pickFromCamera();
                  },
                  child: isAdmin ? roundCamera() : SizedBox(),
                ),
              )
            ],
          ),
        ),
        if (isProfile)
          Positioned(
            top: 152.h,
            left: 18.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: circle_image(profileImage, radius: 31),
                ),
                if (isAdmin)
                  Positioned(
                    bottom: 2.h,
                    right: -2,
                    child: roundCamera(),
                  )
              ],
            ),
          ),
      ],
    );
  }
}

class roundCamera extends StatelessWidget {
  const roundCamera({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/roundcamera.png",
      height: 25,
    );
  }
}
