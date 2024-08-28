import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_button.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/banners_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_scaffold.dart';

import 'package:info_91_proj/feature/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';

import '../widgets/profile_top_image_sec.dart';

class ProfileSettingScreen extends StatelessWidget {
  ProfileSettingScreen({super.key});
  var constGap = SizedBox(
    height: 15.h,
  );
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        CustomAppBar(
          imageUrl: "",
          actionWidget: [customTextButton("Save", onTap: () {})],
          appBarName: "Group Settings",
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileTopImageSec(
                backGroundImage:
                    "https://s3-alpha-sig.figma.com/img/7eb1/5aa2/b39983facffc91323415afccde962741?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=PbxqfDILQLOB0-ETRJgaATBQU3sldAIlUTDruqdVGAPlwcRlsKyX~7Sh~XSg2X2dUal7MZ80cc6ULwfeguls0jYhaR1IR0W1LdNPfrsJuJmfK3RPiGHoD~AHnwDyS~DvR1gUNG4Vzz4G8YT~abKe5-PttZV2HK6br-sQhn4fc99~Vqc3Et2Xhlbi0DSLJTC4HoE1~aSfb7DZYwKrjGA2WDNbJMHkeVh0SQSNDuELxHBkZIaXDCAkM4SdgXUYyI8BHRN~5Y5dYfUeKWDcorpSbo4bTiVN14Lx4A-9kgyZxKtRrUxjJfOu3fz5S3S09qrLCTkr5-TJ6HsuQ0vRxkw7Ig__",
                profileImage:
                    "https://s3-alpha-sig.figma.com/img/35e8/9d9d/e5b9d1d23149590ef05ef35d5019c1af?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qqj9NDxLQ62C0Qg6~MQQSZ5GaRk~u1~DGuRCFkGIyzxIl9ro~QiH7sKpqES3Vfh2Vz5rHPZZq-Xrq9vaz840HBavPUgmr34V3lTXCeUFze9Sg1lXyvkmXSqqyfDnQiJegGLhcnDZP30ip7Wo77D-YFZhJlDKg58UjFcyr80mbwpErKO0YaT-ndZOroyuXHDiH6oBJwj-odwRH55Vlaaj5TTraPFHMchFJhJ1dv6atYIIwFyukiF2HplWCzSrtwLJZtWY9DxPb-WNP37NSQTFOROBZ-lwJv7svxE7zMkQWeD5lLjhxTWUGCMMqCwGnHVouLxxO8E0Y5CD~z1db~6aeQ__",
                isAdmin: true,
              ),
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: marginWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    greyBoldText("Group Name",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    NewInputCard(
                      controller: TextEditingController(),
                      title: "About us",
                      height: 80,
                      maxLines: 3,
                    ),
                    constGap,
                    NewInputCard(
                      controller: TextEditingController(),
                      title: "You can add up to 3 keywords.",
                      label: "#tags #tags #tags",
                      colors: AppColors.text.withOpacity(.75),
                      fontsize: 12.sp,
                    ),
                    constGap,
                    greyBoldText("Contact Details",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Mobile Number",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Alternative Number",
                          ),
                        )
                      ],
                    ),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Whatsapp Number",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: Container(),
                        )
                      ],
                    ),
                    constGap,
                    greyBoldText("Timings and Holidays",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Contact Time",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Holidays",
                          ),
                        )
                      ],
                    ),
                    constGap,
                    greyBoldText("Banners",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    const BannersImageView(),
                    CustomArrowTextbutton(
                        buttonName: "Add Banners",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BannersScreen(),
                              ));
                        }),
                    constGap,
                    greyBoldText("Others",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Website link",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Website link",
                          ),
                        )
                      ],
                    ),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Google map link",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
