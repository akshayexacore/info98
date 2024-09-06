import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/widgets/custom_scaffold.dart';

class SelectedContactListView extends StatelessWidget {
  final List<Contact> contactList;
  const SelectedContactListView({super.key, required this.contactList});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        CustomAppBar(appBarName: "View Contacts"),
        // Expanded(
        //     child: ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount))
      ],
    );
  }
}
