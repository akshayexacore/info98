import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info_91_proj/core/config/app_styles.dart';
import 'package:info_91_proj/core/tiny/app_button.dart';
import 'package:info_91_proj/core/tiny/app_divider.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/texts.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedContactListView extends StatelessWidget {
  final List<Contact> contactList;
  const SelectedContactListView({super.key, required this.contactList});
  void saveContact(Contact contact) async {
    final String url = 'tel:${contact.displayName}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        CustomAppBar(appBarName: "View Contacts"),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => Column(
                      children: [
                        ContactListCard(
                          onCange: () {},
                          avatar: contactList[index].avatar ?? Uint8List(0),
                          contactName: contactList[index].displayName ?? "",
                          leadingWidget: AppButton(
                            text: "Add",
                            width: 60,
                            onPressed: () {
                              saveContact(contactList[index]);
                            },
                            height: 30,
                            style: AppButtonStyles.appButton.copyWith(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.secondary)),
                            textStyle: AppTextStyles.appButton
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                        customDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.message,
                            color: AppColors.primary,
                          ),
                          title: greyBoldText(
                              contactList[index].displayName ?? ""),
                        )
                      ],
                    ),
                separatorBuilder: (context, index) => Container(
                      height: 5.h,
                      color: AppColors.white,
                    ),
                itemCount: contactList.length))
      ],
    );
  }
}
