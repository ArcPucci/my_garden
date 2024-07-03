import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomButton2 extends StatelessWidget {
  const CustomButton2({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
  });

  final String text;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 88.h,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 347.w,
          height: 88.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                width: 2.sp,
                color: AppTheme.gray2,
              ),
            ),
          ),
          padding: EdgeInsets.only(right: 28.w),
          child: Row(
            children: [
              Expanded(child: Text(text, style: AppTextStyles.medium22)),
              leading ??
                  Image.asset(
                    'assets/png/icons/arrow_right.png',
                    width: 22.w,
                    height: 18.h,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
