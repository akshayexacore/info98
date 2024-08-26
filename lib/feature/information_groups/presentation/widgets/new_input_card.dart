import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info_91_proj/core/config/app_styles.dart';

class NewInputCard extends StatefulWidget {
  final double fontsize;
  final double height;
  final bool readOnly;
  final bool formatter;
  final TextEditingController controller;
  final int maxLines;
  final Color colors;
  final String? label;
  final String? keyboardType;
  final bool isBorder;

  final String title;
  final String? hint;

  final bool password;
  final bool direction;
  const NewInputCard({
    super.key,
    this.isBorder = true,
    required this.controller,
    this.label,
    this.keyboardType,
    this.hint,
    this.formatter = false,
    this.readOnly = false,
    this.password = false,
    this.direction = false,
    required this.title,
    this.colors = const Color(0xffC3C7C9),
    this.maxLines = 1,
    this.height = 50,
    this.fontsize = 13,
  });

  @override
  State<NewInputCard> createState() => _NewInputCardState();
}

class _NewInputCardState extends State<NewInputCard> {
  bool show = false;
  @override
  void initState() {
    super.initState();
    show = widget.password;
  }

  InputBorder? borderStyle() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
            color: widget.isBorder
                ? AppColors.divider.withOpacity(.5)
                : Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.text == "null"
        ? widget.controller.text = ""
        : widget.controller.text;

    return widget.direction == false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                    fontSize: widget.fontsize,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text),
              ),
              const SizedBox(height: 3),
              widget.keyboardType == "int"
                  ? Container(
                      alignment: Alignment.center,
                      height: widget.height,

                      // color: widget.colors,
                      // color: Colors.grey.shade200,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: widget.readOnly,
                        maxLines: widget.maxLines,
                        controller: widget.controller,
                        obscureText: show,
                        keyboardType:
                            widget.formatter ? TextInputType.number : null,
                        inputFormatters: widget.formatter
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ]
                            : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: widget.readOnly
                              ? const Color(0xffF2F3F5).withOpacity(.2)
                              : Colors.white,
                          suffixIcon: widget.password
                              ? IconButton(
                                  icon: show
                                      ? const Icon(
                                          Icons.visibility,
                                          size: 18,
                                        )
                                      : const Icon(
                                          Icons.visibility_off_outlined,
                                          size: 18,
                                        ),
                                  onPressed: () {
                                    show = !show;
                                    setState(() {});
                                  },
                                )
                              : null,
                          labelStyle: const TextStyle(
                            fontSize: 13,
                            //fontStyle: FontStyle.italic,
                          ),
                          // label: Text(
                          //   widget.label,
                          // ),
                          hintStyle: const TextStyle(
                              fontSize: 12, color: Colors.black),
                          hintText: widget.label,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xff3E4F5B).withOpacity(.1))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xff3E4F5B).withOpacity(.1))),
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.topLeft,
                      height: widget.height,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: widget.readOnly,
                        maxLines: widget.maxLines,
                        controller: widget.controller,
                        obscureText: show,
                        keyboardType:
                            widget.formatter ? TextInputType.number : null,
                        inputFormatters: widget.formatter
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ]
                            : null,
                        decoration: InputDecoration(
                          filled: true,

                          fillColor: widget.readOnly
                              ? const Color(0xffF2F3F5).withOpacity(.2)
                              : Colors.white,
                          suffixIcon: widget.password
                              ? IconButton(
                                  icon: show
                                      ? const Icon(
                                          Icons.visibility,
                                          size: 18,
                                        )
                                      : const Icon(
                                          Icons.visibility_off_outlined,
                                          size: 18,
                                        ),
                                  onPressed: () {
                                    show = !show;
                                    setState(() {});
                                  },
                                )
                              : null,
                          labelStyle: const TextStyle(
                            fontSize: 13,
                            //fontStyle: FontStyle.italic,
                          ),
                          // label: Text(
                          //   widget.label,
                          // ),
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              color: AppColors.black.withOpacity(.25)),
                          hintText: widget.label,
                          disabledBorder: borderStyle(),
                          enabledBorder: borderStyle(),
                          focusedBorder: borderStyle(),
                        ),
                      ),
                    ),
            ],
          )
        : SizedBox(
            height: 300,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: widget.fontsize, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .003),
                SizedBox(
                  height: widget.height,
                  // color: widget.colors,
                  // color: Colors.grey.shade200,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: widget.maxLines,
                    controller: widget.controller,
                    obscureText: show,
                    decoration: InputDecoration(
                      suffixIcon: widget.password
                          ? IconButton(
                              icon: show
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 18,
                                    )
                                  : const Icon(
                                      Icons.visibility_off_outlined,
                                      size: 18,
                                    ),
                              onPressed: () {
                                show = !show;
                                setState(() {});
                              },
                            )
                          : null,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        //fontStyle: FontStyle.italic,
                      ),
                      // label: Text(
                      //   widget.label,
                      // ),
                      hintStyle:
                          const TextStyle(fontSize: 12, color: Colors.black),
                      hintText: widget.label,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: widget.colors)),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
