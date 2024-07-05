import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({super.key, this.onSave, required this.text});

  final String text;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 44.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Row(
                    children: [
                      SizedBox(width: 8.w),
                      Image.asset(
                        'assets/png/icons/back.png',
                        width: 17.w,
                        height: 22.h,
                      ),
                      SizedBox(width: 3.w),
                      Text('Cancel', style: AppTextStyles.regular17),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onSave,
                  child: Container(
                    width: 71.w,
                    height: 44.h,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Save',
                      style: AppTextStyles.regular17.copyWith(
                        color: AppTheme.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(text, style: AppTextStyles.semiBold17),
        ],
      ),
    );
  }
}
