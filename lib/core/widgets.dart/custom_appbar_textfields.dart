import 'package:flutter/material.dart';

class CustomAppBatTexField extends StatelessWidget {
  final TextEditingController cntroler;
  const CustomAppBatTexField({
    super.key,
    required this.onChangeFunction, required this.cntroler,
  });

  final Function? onChangeFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.1),
            borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
          controller: cntroler,
          style: TextStyle(color: Colors.white),
          onChanged: (String va) {
            if (onChangeFunction != null) {
              onChangeFunction!(va);
            }
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.white.withOpacity(.5),
                size: 28,
              ),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white.withOpacity(.5))),
        ));
  }
}
