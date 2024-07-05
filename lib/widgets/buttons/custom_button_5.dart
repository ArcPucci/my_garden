import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomButton5 extends StatelessWidget {
  const CustomButton5({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: AppTheme.green,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/png/icons/plus.png',
              width: 18.w,
              height: 22.h,
            ),
            SizedBox(width: 6.w),
            Text(
              'Add date',
              style: AppTextStyles.regular16.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
