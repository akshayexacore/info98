import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_button.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              imageUrl: "",
              imageOntap: () {},
              appBarName: "Banners",
              actionWidget: [customTextButton("Apply", onTap: () {})],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: marginWidth),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  greyContentText(
                      "You can add up to 10 photos with your current plan, and they will be automatically removed after 30 days."),
                  SizedBox(
                    height: 15.h,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: 180.h,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          child: Image.network(
                              fit: BoxFit.cover,
                              "https://s3-alpha-sig.figma.com/img/2d9d/5694/1503b04af0728cee4429315aa028784f?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ItWrWrG43Faqr93L-5K3YzTiODWo5zpmCY9jTy1RXqC5FPefeWWd5sejjKZDmd5VHI8ZTie6m93ZINvHvF0LZMsidhi1lCXA~yOmp9~NYGzn~xLtD-NQWzpL1v4izD8uJwyMjoXFRoAe5gjzgrZhLnkuBu5iHMB6XB6ZiSrbb4WJT5NPRN981qhL20u15jgclKDe8tFrFJh6TginQ3cil1jBSRQIVZ3gJ6veT15f6cu8MoYlAB8nmI3vkPMKPsWeliktLXmRkZc1Rx3krKy4zu-DM7aKr7IS5AJar1YftNB1t~gqdQGeTaxg974dAdJUEE4HzyZ6CBh5CCLND8gmMg__"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColors.primary,
                            child: Image.asset(
                              "assets/images/delete_icon.png",
                              height: 20.h,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: TextEditingController(),
                    title: "Title",
                    isBorder: false,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: TextEditingController(),
                    title: "Description",
                    isBorder: false,
                  ),
                  const Spacer(),
                  AppButton(
                    text: "Add more",
                    busy: false,
                    icon: Icons.camera_alt,
                    onPressed: () {},
                    style: AppButtonStyles.appButton.copyWith(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.white)),
                    textStyle: AppTextStyles.appButton
                        .copyWith(color: AppColors.black),
                  ),
                  SizedBox(
                    height: 15.h,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
