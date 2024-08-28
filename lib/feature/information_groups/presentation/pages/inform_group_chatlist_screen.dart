import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_divider.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/info_group_chat_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_creation.page.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/start_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_popupmenu.dart';

import 'package:toggle_switch/toggle_switch.dart';

class InfoGroupChatListScreen extends StatefulWidget {
  const InfoGroupChatListScreen({super.key});

  @override
  State<InfoGroupChatListScreen> createState() => _InfoGroupChatListScreen();
}

class _InfoGroupChatListScreen extends State<InfoGroupChatListScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final List<Chat> chats = [
    Chat(
      name: "John Doe",
      itemcount: 5,
      message: "Hey! How's it going?",
      time: "12:45 PM",
      avatarUrl: "https://randomuser.me/api/portraits/men/1.jpg",
    ),
    Chat(
      name: "Jane Smith",
      message: "Can we meet tomorrow?",
      time: "11:30 AM",
      avatarUrl: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    // Add more chats here
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2, // Number of tabs
      vsync:
          this, // 'this' works here because the class mixes in SingleTickerProviderStateMixin
    );
  }

  @override
  void dispose() {
    tabController
        .dispose(); // Dispose the controller when the widget is removed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.splashBackground,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                appBarName: "Information Groups",
                isTextield: true,
                actionWidget: [CustomPopupmenu(onSelected: (val){if(val==1){Navigator.push(context, MaterialPageRoute(builder: (context) => InformGroupCreationScreen(),));}}, itemList: [popupMenuModel(name: "Create group",value: 1)],)
               
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              toggleSwitch(onToggle: (val) {}),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 2,
                  itemBuilder: (context, index) => ChatListItem(
                    chat: chats[index],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StartScreen(),
                          ));
                    },
                  ),
                  separatorBuilder: (context, index) => customDivider(),
                ),
              )
            ],
          ),
        ));
  }

  ToggleSwitch toggleSwitch({Function? onToggle}) {
    return ToggleSwitch(
      minWidth: 110.0.w,
      minHeight: 34.h,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.white,
      inactiveFgColor: Colors.black,
      initialLabelIndex: 1,
      curve: Curves.bounceOut,
      cornerRadius: 10,
      activeBgColors: [
        [Colors.orange[800]!],
        [Colors.orange[800]!]
      ],
      totalSwitches: 2,
      labels: const ['Groups', 'Own Groups'],
      radiusStyle: true,
      onToggle: (index) {
        if (onToggle != null) {
          onToggle(index);
        }
      },
    );
  }
}
