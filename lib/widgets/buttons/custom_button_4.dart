import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomButton4 extends StatelessWidget {
  const CustomButton4({
    super.key,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 343.w,
        height: 49.h,
        color: Colors.transparent,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyles.regular16.copyWith(color: Colors.black),
            ),
            if (selected)
              Image.asset(
                'assets/png/icons/checkmark.png',
                width: 16.w,
                height: 26.h,
              ),
          ],
        ),
      ),
    );
  }
}
