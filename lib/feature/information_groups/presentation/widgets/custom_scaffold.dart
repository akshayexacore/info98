import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget> children;

  const CustomScaffold({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
