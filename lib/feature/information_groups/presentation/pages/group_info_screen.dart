import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_popupmenu.dart';

import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';

class GroupInfo extends StatelessWidget {
  GroupInfo({super.key});
  Widget commonGap = SizedBox(
    height: 15.h,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              appBarName: "Group Info",
              actionWidget: [
                CustomPopupmenu(
                  onSelected: (val) {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           const InformGroupCreationScreen(),
                    //     ));
                  },
                  itemList: [popupMenuModel(name: "Edit", value: 1)],
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonGap,
                      blusHeading("Contact Details"),
                      commonGap,
                      groupInfoDoubleText("Contact No. 1", "9988665533"),
                      groupInfoDoubleText("Contact No. 1", "9988665533"),
                      groupInfoDoubleText("Contact No. 1", "9988665533"),
                      blusHeading("Timings and Holidays"),
                      commonGap,
                      groupInfoDoubleText("Contact Time", "9:00 AM to 5:00 PM"),
                      blusHeading("Website link"),
                      commonGap,
                      groupInfoDoubleText("Website link", "www.loremipsim.c"),
                      groupInfoDoubleText("Website link", "www.loremipsim.c"),
                      groupInfoDoubleText("Website link", "www.loremipsim.c"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget groupInfoDoubleText(String heading, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        greyContentText(heading),
        SizedBox(
          height: 8.h,
        ),
        greyBoldText(content, fontWeight: FontWeight.w400),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
