import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomBG extends StatelessWidget {
  const CustomBG({
    super.key,
    required this.child,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 343.w,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.gray6,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
