import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CustomSwitchButton extends StatelessWidget {
  const CustomSwitchButton({
    super.key,
    this.toggled = false,
    required this.onSwitch,
  });

  final bool toggled;
  final void Function(bool)? onSwitch;

  @override
  Widget build(BuildContext context) {
    double x = toggled ? -3 : 3;
    return GestureDetector(
      onTap: () => onSwitch?.call(!toggled),
      child: AnimatedContainer(
        width: 51.r,
        height: 31.r,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: toggled ? AppTheme.green : AppTheme.gray5.withOpacity(0.16),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(horizontal: 2.r),
        alignment: toggled ? Alignment.centerRight : Alignment.centerLeft,
        child: AnimatedContainer(
          width: 27.r,
          height: 27.r,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(x, 0),
                blurRadius: 8.r,
                color: Colors.black.withOpacity(0.15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
