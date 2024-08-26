import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custome_space_between_text.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/validity_card.dart';

class ValidityScreen extends StatelessWidget {
  const ValidityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              imageUrl: "",
              actionWidget: [
                PopupMenuButton<int>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  offset: Offset(0, 40.h),
                  onSelected: (value) {},
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginWidth),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      const Text(
                          "Choose a  plan for your business group and submit the request"),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ValidityCard(
                              amount: "1099",
                              onChange: (va) {},
                              planName: "Plan A",
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: ValidityCard(
                              amount: "1099",
                              onChange: (va) {},
                              planName: "Plan A",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ValidityCard(
                              amount: "1099",
                              onChange: (va) {},
                              planName: "Plan A",
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: ValidityCard(
                              amount: "1099",
                              onChange: (va) {},
                              planName: "Plan A",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const CustomSpcaeBetweenText(
                        leftText: "Paln name",
                        rightText: "Lorem inspum",
                      ),
                      const CustomSpcaeBetweenText(
                        leftText: "Total Members",
                        rightText: "1000",
                      ),
                      const CustomSpcaeBetweenText(
                        leftText: "Validity",
                        rightText: "6 months",
                      ),
                      const CustomSpcaeBetweenText(
                        leftText: "Amount",
                        rightText: "999.0",
                      ),
                      const CustomSpcaeBetweenText(
                        leftText: "Tax",
                        rightText: "999.0",
                      ),
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
}
