import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_round_image.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_creation.page.dart';

import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';

import '../widgets/profile_top_image_sec.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  List<popupMenuModel> listModel = [
    popupMenuModel(name: "Create Group", value: 1)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              imageUrl: "",
              actionWidget: [
                CustomPopupmenu(
                  onSelected: (val) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const InformGroupCreationScreen(),
                        ));
                  },
                  itemList: listModel,
                ),
              ],
              appBarName: "Group Profile",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileTopImageSec(profileImage: "https://s3-alpha-sig.figma.com/img/35e8/9d9d/e5b9d1d23149590ef05ef35d5019c1af?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qqj9NDxLQ62C0Qg6~MQQSZ5GaRk~u1~DGuRCFkGIyzxIl9ro~QiH7sKpqES3Vfh2Vz5rHPZZq-Xrq9vaz840HBavPUgmr34V3lTXCeUFze9Sg1lXyvkmXSqqyfDnQiJegGLhcnDZP30ip7Wo77D-YFZhJlDKg58UjFcyr80mbwpErKO0YaT-ndZOroyuXHDiH6oBJwj-odwRH55Vlaaj5TTraPFHMchFJhJ1dv6atYIIwFyukiF2HplWCzSrtwLJZtWY9DxPb-WNP37NSQTFOROBZ-lwJv7svxE7zMkQWeD5lLjhxTWUGCMMqCwGnHVouLxxO8E0Y5CD~z1db~6aeQ__",backGroundImage: "https://s3-alpha-sig.figma.com/img/7eb1/5aa2/b39983facffc91323415afccde962741?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=PbxqfDILQLOB0-ETRJgaATBQU3sldAIlUTDruqdVGAPlwcRlsKyX~7Sh~XSg2X2dUal7MZ80cc6ULwfeguls0jYhaR1IR0W1LdNPfrsJuJmfK3RPiGHoD~AHnwDyS~DvR1gUNG4Vzz4G8YT~abKe5-PttZV2HK6br-sQhn4fc99~Vqc3Et2Xhlbi0DSLJTC4HoE1~aSfb7DZYwKrjGA2WDNbJMHkeVh0SQSNDuELxHBkZIaXDCAkM4SdgXUYyI8BHRN~5Y5dYfUeKWDcorpSbo4bTiVN14Lx4A-9kgyZxKtRrUxjJfOu3fz5S3S09qrLCTkr5-TJ6HsuQ0vRxkw7Ig__",),
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
                          SizedBox(
                            height: 10.h,
                          ),
                          blusHeading("About us"),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          const Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          const Text(
                            "Created by arya/ 24 march 24",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          blusHeading("Media"),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 100.h,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          CustomArrowTextbutton(
                            buttonName: "Group info",
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          blusHeading("Banners"),
                          SizedBox(
                            height: 5.h,
                          ),
                        const  BannersImageView(),
                          SizedBox(
                            height: 5.h,
                          ),
                          blusHeading("Group Members"),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                greynonBoldText("1k members"),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListTile(
                                  leading: circle_image(
                                    "https://randomuser.me/api/portraits/women/1.jpg",
                                    onTap: () {},
                                  ),
                                  title: const Text(
                                    "Arya",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: SizedBox(
                                      width: 400.w,
                                      child: const Text(
                                        "Creating My own sunshine in a worldddddddddddddddddd",
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  trailing: Text(
                                    "Admin",
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 13.sp),
                                  ),
                                )
                              ],
                            ),
                          )
                          // Container(
                          //   color: Colors.red,
                          //   height: 55,
                          //   child: ListView.builder(
                          //     itemBuilder: (context, index) => Container(
                          //         child: Column(
                          //       children: [
                          //         Container(
                          //             height: 50.h,
                          //             width: 40.w,
                          //             child: Image.network(
                          //                 "https://th.bing.com/th?id=OIP.qn_LIjRBjyml3lSSiw6oHwHaE7&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2"))
                          //       ],
                          //     )),
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BannersImageView extends StatelessWidget {
  const BannersImageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160.h,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.h,
                      width: 170.w,
                      child: Image.network(
                        "https://th.bing.com/th?id=OIP.qn_LIjRBjyml3lSSiw6oHwHaE7&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    greynonBoldText("Title"),
                    SizedBox(
                      height: 5.h,
                    ),
                    greynonBoldText("Description"),
                  ],
                ),
            separatorBuilder: (context, index) =>
                SizedBox(
                  width: 18.w,
                ),
            itemCount: 5));
  }
}
