import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_button.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/banners_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/info_group_chat_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/expandable_widget.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/icon.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/profile_top_image_sec.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        const CustomAppBar(
          imageUrl:
              "https://s3-alpha-sig.figma.com/img/1d0e/383d/b6e3946fdbb59adc0ab258d3c0726b43?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hqY18ZgpQ4HigC3lhlKqEd2c-i1msfmir7yXKRJycSUV705Oqm2oC0oTZrTzsv3PDayakYS25bpREtmCWAB~DN~yUMsg3W9XJtk5QStTKAwd8m9Pcgt3l-QQ5qsSx1Bo5a6-7OpOQmFBtXM2a6Sf-JFfc20ZsfCFnBOcpHeCcyyNKaQpoLxo~3OBVnzcbs9Te0wjotXKCBkoiZVEHmV5sztkAv3HD9Ro4sh4rGtyzMvHGMUxN-dyqZiEJJVlVjPmj56lH~WMeqivTTJgAFsfvf1TyoNG97AcDnnQTuvIsB9sBNiek9hKtyCFzCQp4TOc63KOEkzNilLLQn-aEm4TwQ__",
          appBarName: "Lorem Ipsum",
        ),
        const ProfileTopImageSec(
          isProfile: false,
          backGroundImage:
              "https://s3-alpha-sig.figma.com/img/7eb1/5aa2/b39983facffc91323415afccde962741?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=PbxqfDILQLOB0-ETRJgaATBQU3sldAIlUTDruqdVGAPlwcRlsKyX~7Sh~XSg2X2dUal7MZ80cc6ULwfeguls0jYhaR1IR0W1LdNPfrsJuJmfK3RPiGHoD~AHnwDyS~DvR1gUNG4Vzz4G8YT~abKe5-PttZV2HK6br-sQhn4fc99~Vqc3Et2Xhlbi0DSLJTC4HoE1~aSfb7DZYwKrjGA2WDNbJMHkeVh0SQSNDuELxHBkZIaXDCAkM4SdgXUYyI8BHRN~5Y5dYfUeKWDcorpSbo4bTiVN14Lx4A-9kgyZxKtRrUxjJfOu3fz5S3S09qrLCTkr5-TJ6HsuQ0vRxkw7Ig__",
          profileImage:
              "https://s3-alpha-sig.figma.com/img/35e8/9d9d/e5b9d1d23149590ef05ef35d5019c1af?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qqj9NDxLQ62C0Qg6~MQQSZ5GaRk~u1~DGuRCFkGIyzxIl9ro~QiH7sKpqES3Vfh2Vz5rHPZZq-Xrq9vaz840HBavPUgmr34V3lTXCeUFze9Sg1lXyvkmXSqqyfDnQiJegGLhcnDZP30ip7Wo77D-YFZhJlDKg58UjFcyr80mbwpErKO0YaT-ndZOroyuXHDiH6oBJwj-odwRH55Vlaaj5TTraPFHMchFJhJ1dv6atYIIwFyukiF2HplWCzSrtwLJZtWY9DxPb-WNP37NSQTFOROBZ-lwJv7svxE7zMkQWeD5lLjhxTWUGCMMqCwGnHVouLxxO8E0Y5CD~z1db~6aeQ__",
        ),
        Expanded(
            child: Container(height: double.infinity,
             
          padding: EdgeInsets.symmetric(horizontal: marginWidth),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  greyBoldText("Group Name",
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                      size: 16.sp),
                  Spacer(),
                  clickebleIcon("assets/images/youtube.png", () {}),
                  SizedBox(
                    width: 20.w,
                  ),
                  clickebleIcon("assets/images/world.png", () {}),
                  SizedBox(
                    width: 20.w,
                  ),
                  clickebleIcon("assets/images/map.png", () {}),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              greyContentText(
                "1k members",
              ),
              SizedBox(
                height: 15.h,
              ),
              ExpandableTextWidget(
                text:
                    "Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              ),
              SizedBox(
                height: 15.h,
              ),
              greyBoldText("Banners",
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                  size: 15.sp),
              SizedBox(
                height: 15.h,
              ),
              const BannersImageView(),
              Spacer(),
        
            ],
          ),
        )),      Padding(
          padding:  EdgeInsets.symmetric(horizontal: marginWidth),
          child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: "Contact",
                        // isBorder: true,
                        busy: false,
                        onPressed: () {},
                        style: AppButtonStyles.appButton.copyWith(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.white)),
                        textStyle: AppTextStyles.appButton
                            .copyWith(color: AppColors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: AppButton(
                        text: "Join Group",
                        busy: false,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(),
                              ));
                        },
                        style: AppButtonStyles.appButton.copyWith(
                            backgroundColor: WidgetStatePropertyAll(
                          AppColors.secondary,
                        )),
                        textStyle: AppTextStyles.appButton
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
        ),
              SizedBox(
                height: 10.h,
              ),
      ],
    );
  }
}
