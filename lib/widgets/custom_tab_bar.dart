import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final void Function(int index) onChanged;

  @override
  Widget build(BuildContext context) {
    final left = selectedIndex == 0;
    return Container(
      width: 343.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: AppTheme.gray5.withOpacity(0.12),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Stack(
        alignment: left ? Alignment.centerLeft : Alignment.centerRight,
        children: [
          Container(
            width: 169.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 0.5.sp,
                color: Colors.black.withOpacity(0.04),
              ),
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 1.r,
                  color: Colors.black.withOpacity(0.04),
                ),
                BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 8.r,
                  color: Colors.black.withOpacity(0.12),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 2.w),
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                customTabs.length,
                (index) {
                  final selected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => onChanged(index),
                    child: Container(
                      width: 169.w,
                      height: 32.h,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        customTabs[index],
                        style: selected
                            ? AppTextStyles.regular13
                            : AppTextStyles.semiBold13,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
