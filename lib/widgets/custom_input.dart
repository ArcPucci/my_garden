import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomInput extends StatelessWidget {
  CustomInput({super.key, required this.controller});

  final focusNode = FocusNode();
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusNode.requestFocus,
      child: Container(
        width: 343.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppTheme.gray3,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          style: AppTextStyles.regular16.copyWith(color: Colors.black),
          decoration: InputDecoration.collapsed(
            hintText: 'Plant name',
            hintStyle: AppTextStyles.regular16,
          ),
        ),
      ),
    );
  }
}
