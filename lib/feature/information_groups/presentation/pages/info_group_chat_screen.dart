import 'package:flutter/material.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/banners_screen.dart';
import 'package:info_91_proj/feature/information_groups/presentation/pages/profile_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                isPic: true,
                imageUrl: "",
                imageOntap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BannersScreen(),
                      ));
                },
                appBarName: "Information Groups",
                actionWidget: [
                  TextButton(onPressed: () {}, child: const Text("Submit"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
