import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.hasCancel = false,
    this.onCancel,
    this.text2,
  });

  final String text;
  final bool hasCancel;
  final String? text2;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (hasCancel)
                  GestureDetector(
                    onTap: onCancel,
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        Image.asset(
                          'assets/png/icons/back.png',
                          width: 17.w,
                          height: 22.h,
                        ),
                        SizedBox(width: 3.w),
                        Text(text2 ?? 'Cancel', style: AppTextStyles.regular17),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Text(
            text,
            style: AppTextStyles.semiBold18,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
