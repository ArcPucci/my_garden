import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 36.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                'assets/png/app_icon.png',
                width: 212.r,
                height: 212.r,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 32.h),
            Text('GreenThumb Tool', style: AppTextStyles.bold36),
            SizedBox(height: 24.h),
            SizedBox(
              width: 343.w,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/png/icons/tick.png',
                        width: 22.w,
                        height: 21.h,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Systematization of plant care',
                        style: AppTextStyles.regular18,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Image.asset(
                        'assets/png/icons/tick.png',
                        width: 22.w,
                        height: 21.h,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Personalized gardening calendar',
                        style: AppTextStyles.regular18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const CustomButton1(text: 'Start'),
            SizedBox(
              width: 327.w,
              height: 44.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Privacy policy', style: AppTextStyles.medium18),
                  Text('Terms of Use', style: AppTextStyles.medium18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
