import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_round_image.dart';
import 'package:info_91_proj/core/widgets.dart/custom_appbar_textfields.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarName;
  final bool isTextield;
  final bool isPic;
  final Function? imageOntap;
  final String? imageUrl;

  final Function? onChangeFunction;
  final List<Widget>? actionWidget;
  const CustomAppBar({
    required this.appBarName,
    this.onChangeFunction,
    this.actionWidget,
    this.isPic = false,
    this.isTextield = false,
    super.key,
    this.imageUrl,
    this.imageOntap,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      // Here you can decide what happens when the back button is pressed
      if (Navigator.of(context).canPop()) {
        // If there's a previous screen, pop it
        Navigator.of(context).pop();
        return false;
      } else {
        // If there's no previous screen, prevent the default behavior (popping the current screen)
        return false;
      }
    }

    return Container(
      padding: const EdgeInsets.all(10),
      color: AppColors.primaryAccent,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  onWillPop();
                },
              ),
              SizedBox(
                width: 5.w,
              ),
              if (isPic) ...[
                circle_image("https://randomuser.me/api/portraits/women/1.jpg",
                    onTap: imageOntap),
                 SizedBox(
                  width: 10.w,
                ),
              ],
              Text(appBarName,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 15.sp)),
              const Spacer(),
              if (actionWidget != null && actionWidget?.isNotEmpty == true)
                ...List.generate(
                    actionWidget!.length, (index) => actionWidget![index]),

              // actionWidget != null
              //     ? actionWidget.runtimeType == String
              //         ? TextButton(
              //             onPressed: () {
              //               if (actionFunctions != null) {
              //                 actionFunctions!();
              //               }
              //             },
              //             child: Text(
              //               actionWidget,
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold),
              //             ))
              //         : IconButton(
              //             onPressed: () {},
              //             icon: actionWidget,
              //             color: Colors.white,
              //           )
              //     : SizedBox()
            ],
          ),
          if (isTextield)
            CustomAppBatTexField(onChangeFunction: onChangeFunction)
        ],
      ),
    );
  }
}
