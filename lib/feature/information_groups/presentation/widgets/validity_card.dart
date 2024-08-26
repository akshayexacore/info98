import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValidityCard extends StatelessWidget {
  final String amount;
  final String planName;
  final Function onChange;
  const ValidityCard({
    super.key,
    required this.amount,
    required this.planName,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Grey shadow color
              spreadRadius: 1,
              blurRadius: 1, // Blur radius
              offset: Offset(0, 0.7), // Shadow position
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(.5), width: .5),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  height: 22.h,
                  "assets/images/selected-disabled.png",
                  color: Color.fromARGB(255, 6, 46, 78),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                planName,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          SizedBox(
            height: 35.h,
          ),
          Row(
            children: [
              Text(
                "Amount",
                style: TextStyle(color: Color(0xff333333).withOpacity(.75)),
              ),
              const Spacer(),
              Text(
                amount,
                style: TextStyle(
                    color: Color(0xff333333), fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
