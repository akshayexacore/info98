import 'package:flutter/material.dart';
import 'package:info_91_proj/core/config/app_styles.dart';

class AppDropDownButton<T> extends StatefulWidget {
  const AppDropDownButton({
    Key? key,
    this.selectedItemBuilder,
    this.value,
    this.items,
    this.shadow = false,
    this.title,
    this.hint,
    this.onChanged,
  }) : super(key: key);

  final DropdownButtonBuilder? selectedItemBuilder;

  final T? value;

  final List<DropdownMenuItem<T>>? items;

  final bool shadow;

  final String? title;

  final String? hint;

  final ValueChanged<T>? onChanged;

  @override
  State<AppDropDownButton<T>> createState() => _AppDropDownButtonState<T>();
}

class _AppDropDownButtonState<T> extends State<AppDropDownButton<T>> {
  T? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            '${widget.title}',
            style: const TextStyle(
                fontSize: AppFontSizes.xxSmall,
                fontWeight: FontWeight.w400,
                color: AppColors.white),
          ),
          const SizedBox(
            height: AppSpacings.xxSmall,
          ),
        ],
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 0, vertical: AppPaddings.xxxSmall),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border:
                  Border(bottom: BorderSide(color: AppColors.white, width: 1)),
              boxShadow: widget.shadow ? [AppShadows.shadow] : null),
          child: DropdownButton<T>(
            value: value,
            hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.hint ?? "",
                  style: TextStyle(
                      color: AppColors.white, fontSize: AppFontSizes.xxSmall),
                )),
            selectedItemBuilder: widget.selectedItemBuilder,
            icon: Transform.rotate(
              angle: -(90 * 3.14 / 180),
              child: const Icon(
                Icons.arrow_back_ios_sharp,
                color: AppColors.white,
                size: 20,
              ),
            ),
            iconSize: 24,
            elevation: 8,
            borderRadius: BorderRadius.circular(AppRadii.medium),
            isExpanded: true,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: AppFontSizes.medium,
              fontFamily: AppFonts.primaryFontFamily,
            ),
            underline: const SizedBox(),
            onChanged: (e) {
              setState(() {
                value = e;
              });
              if (widget.onChanged != null) {
                widget.onChanged!.call(e!);
              }
            },
            items: widget.items,
          ),
        ),
      ],
    );
  }
}
