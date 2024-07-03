import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/widgets/widgets.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key, required this.onChanged});

  final void Function(DateTime) onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomBG(
      width: 343.w,
      height: 164.h,
      child: CupertinoDatePicker(
        itemExtent: 35.h,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: onChanged,
      ),
    );
  }
}
