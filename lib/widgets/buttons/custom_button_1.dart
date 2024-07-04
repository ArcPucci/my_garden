import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomButton1 extends StatelessWidget {
  const CustomButton1({
    super.key,
    this.text = '',
    this.onTap,
    this.width,
    this.icon = '',
  });

  final String text;
  final double? width;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 343.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: AppTheme.green,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: icon.isEmpty
            ? Text(
                text,
                style: AppTextStyles.regular18.copyWith(color: Colors.white),
              )
            : Image.asset(icon, width: 24.w, height: 24.h),
      ),
    );
  }
}
