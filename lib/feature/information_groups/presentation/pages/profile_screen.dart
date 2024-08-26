import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_round_image.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_creation.page.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/blue_heading_text.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_arrow_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                PopupMenuButton<int>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  offset: Offset(0, 40.h),
                  onSelected: (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const InformGroupCreationScreen(),
                        ));
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Create Group'),
                    ),
                  ],
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
              appBarName: "Group Profile",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 180.h,
                          width: double.infinity,
                          child: Image.network(
                              fit: BoxFit.cover,
                              "https://s3-alpha-sig.figma.com/img/7eb1/5aa2/b39983facffc91323415afccde962741?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qqjMp948eA6aYndqFNf-Oq2i6NpD8mZEbNKDda6GtNyispBOpKgy5tNa~dlCzZpWnIz1hj7M-RocRaskXd-soOk3V5Lf7MCTvJSWdmQDfkZVAesb1rDG6CCnjfq-xvdKbSu2~d0hbOyMghusBosDmkzqwK32gesASoJOICAB~WJZLiQUsddqpR7QEIyEQ9fYNGcHRudO1-zDTLICXW0CywV13mRaEOuelBD1tXcPTufw1FhWG-zwUWbVI~20zyONSwv3RZAM1T37It4oRgLM8wQp9G~Oj7l~cNck5iCAM75D2XV6jxIK8OV~6IbAZY8H34dIv3NCpnT~rj~9s~UXVA__"),
                        ),
                        Positioned(
                          top: 152.h,
                          left: 18.w,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: circle_image(
                                "https://s3-alpha-sig.figma.com/img/35e8/9d9d/e5b9d1d23149590ef05ef35d5019c1af?Expires=1725235200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=KFlzmE76RXxP7rmWAawmHsghDyELMHguDt8p6w4B3AJ4cAtTATSfvGlqOob1IX2eFZSneklhjnHBvDFK2RWuGw4EouSUrbH8RAPBE1u8Nn1xm6Lq~uV0wdWEON-cp3bAfbI35BzO7EBWo~gwXf803~Hs~5fFzSCkBZb5VrqT8vdoJDb6c2~ptr86lfagh4M7Hs7tysC3wg8E9sl2CluPuDLIoh8iQOkuhONIlQjDN4eEwDlE9GZbbcaO-S~HcWclGvk1KkJAWtFQL9HfTaKnPNH91iAUMIkIPS0DkPaFKMjtgR-RXJD6k8oV1Q8~bepvUjEuMwIEI0lXPf5xw0yDFg__",
                                radius: 31),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: marginWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Group Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
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
                          CustomAroowTextbutton(
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
                          SizedBox(
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
                                  itemCount: 5)),
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
