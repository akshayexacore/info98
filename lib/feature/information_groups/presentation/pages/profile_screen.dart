import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_round_image.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/gfallery_view_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/group_info_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_creation.page.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_setting_screen.dart';

import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';

import '../widgets/custom_image_card.dart';
import '../widgets/profile_top_image_sec.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  List<popupMenuModel> listModel = [
    popupMenuModel(name: "Group Setting", value: 1)
  ];
  List<String> MediaList = [
    "https://s3-alpha-sig.figma.com/img/15c4/bf2a/faa786897f95b8eb7e0f22b36d2884b8?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ObdzlxyzfSXhZ5l15bpmN-Rk4a~BmYeLvBIHhwnpc5lC9vEbhOJtUptUXPV0J~brLA52D-VO~KKn8hy8ua9F4hJbS5-jo0kh2vuJnzjohK12voc4sNt-6tT2POy~NUxoKf2~oVJugr0TU-gqa1wS4qGq-x~FccYkozpSI9YAjmslx73Gqfo~oBsRs1j77H3Ct4GMycedDachvoo~CKQ5dHeOxgCGpcaJe9lcJgrwOK0P4Itk5gL5s1iO-AXxPRRtUceETV7afE8C2DY4z20pi8qVP9KzbZgcjDpxV5wUiy9aqUhjLNaIAJZZD~txbK7nhRQkVdAbcshL6UvhE7s~CQ__",
    "https://s3-alpha-sig.figma.com/img/465d/b729/9dfb8d4f18cb1d69d607a7a44403f023?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=d91oVlG0AXBJd~WzAfpfEZPuVcIVWLvnMQgscZ1DPK-PQksU5XDE01Wv9Q1kLGzUtIqBgi5p~9Xi7OWsrghTtM7INVMd8ZYOU1jzvgZFMYzXaJbhCgBXNS9ujCH2e1omJKr~mEI2o9J3Dvu4uyI-6pwCavg~Vc7qdubycWVMmwoZfYeIwdxFs1WfUUrItWNWlBRgGB-yiylRM3MT7rwu8X8Dv32DXSy7zADzBw9Uls~yamr9BlwgzYNXC0QkvF3sj5w3bm398D2P~NBaa2RNr3T~ZmJAsqsMa8H4fjnqSTZgUQOErxjotOY1k1O~c5AfZeRhoP3bE9fTT4UI1kn9Hg__",
    "https://s3-alpha-sig.figma.com/img/e787/7b6b/1e1d619c6f167a5ac7cab9d654d200df?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cYz0Mk~dKA2ECJmKDZFgSP12Caj~yiLmbAocs6LOjFN42hBQbbS-LQewU3d8Z9j1XZttqkc39BLGvAElvIYlZirpz8GOkPM0lsb~r-HXHXydT8muu7n2cq8-OuEC6QFCETIcsy4ys8zAimFfR8BQSUKAVrV4UKajmHHr-r4GwNgenBH7kw7PomD-6Le0oiSKWd8XSuI1m8V7BG793MNHShbhatJiuwR4UddyvrxNMvovWHR2qZQb8ms27CSxVRILNWtVH4DgKCAjZtT78Rvyi3HkhLqype29VOjNT3Jq~sviJY7Czqt8DveBQ2Mi1U~uQLRhjtKrAC~v3VhKJnqX8Q__",
    'https://picsum.photos/250?image=1',
   'https://picsum.photos/250?image=2',
    'https://picsum.photos/250?image=3',
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
                          builder: (context) => ProfileSettingScreen(),
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
                    ProfileTopImageSec(
                      profileImage:
                          "https://s3-alpha-sig.figma.com/img/35e8/9d9d/e5b9d1d23149590ef05ef35d5019c1af?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qqj9NDxLQ62C0Qg6~MQQSZ5GaRk~u1~DGuRCFkGIyzxIl9ro~QiH7sKpqES3Vfh2Vz5rHPZZq-Xrq9vaz840HBavPUgmr34V3lTXCeUFze9Sg1lXyvkmXSqqyfDnQiJegGLhcnDZP30ip7Wo77D-YFZhJlDKg58UjFcyr80mbwpErKO0YaT-ndZOroyuXHDiH6oBJwj-odwRH55Vlaaj5TTraPFHMchFJhJ1dv6atYIIwFyukiF2HplWCzSrtwLJZtWY9DxPb-WNP37NSQTFOROBZ-lwJv7svxE7zMkQWeD5lLjhxTWUGCMMqCwGnHVouLxxO8E0Y5CD~z1db~6aeQ__",
                      backGroundImage:
                          "https://s3-alpha-sig.figma.com/img/7eb1/5aa2/b39983facffc91323415afccde962741?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=PbxqfDILQLOB0-ETRJgaATBQU3sldAIlUTDruqdVGAPlwcRlsKyX~7Sh~XSg2X2dUal7MZ80cc6ULwfeguls0jYhaR1IR0W1LdNPfrsJuJmfK3RPiGHoD~AHnwDyS~DvR1gUNG4Vzz4G8YT~abKe5-PttZV2HK6br-sQhn4fc99~Vqc3Et2Xhlbi0DSLJTC4HoE1~aSfb7DZYwKrjGA2WDNbJMHkeVh0SQSNDuELxHBkZIaXDCAkM4SdgXUYyI8BHRN~5Y5dYfUeKWDcorpSbo4bTiVN14Lx4A-9kgyZxKtRrUxjJfOu3fz5S3S09qrLCTkr5-TJ6HsuQ0vRxkw7Ig__",
                    ),
                    SizedBox(
                      height: 50.h,
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
                          blusHeading("About Us"),
                          SizedBox(
                            height: 10.h,
                          ),
                          greyBoldText(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                              color: AppColors.text,
                              size: 15.sp),

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
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => customImageCard(index: index,imageCount:MediaList.length ,
                                  imageUrl:
                                      MediaList[index],width:110.w ,onImageTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => GaleryViewScreen(imageList: MediaList,),));},),
                              itemCount: MediaList.length<3?MediaList.length:3,
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          CustomArrowTextbutton(
                            buttonName: "Group info",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GroupInfo(),
                                  ));
                            },
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          blusHeading("Banners"),
                          SizedBox(
                            height: 5.h,
                          ),
                          const BannersImageView(),
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
                                        "Creating My own sunshine in a world",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customImageCard(
                      imageUrl:
                          "https://th.bing.com/th?id=OIP.qn_LIjRBjyml3lSSiw6oHwHaE7&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2",
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
            separatorBuilder: (context, index) => SizedBox(
                  width: 18.w,
                ),
            itemCount: 5));
  }
}
