import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/buttons/custom_button_3.dart';
import 'package:my_garden/widgets/app_bars/custom_app_bar.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/png/paywall.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  text: 'Premium',
                  hasCancel: true,
                  onCancel: Navigator.of(context).pop,
                ),
                Expanded(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Adds free\nfor:\n",
                            style: AppTextStyles.semiBold40,
                          ),
                          TextSpan(text: "\$0,49", style: AppTextStyles.bold48),
                        ],
                      ),
                    ),
                  ),
                ),
                const CustomButton3(),
                SizedBox(height: 16.h),
                Text('Restore', style: AppTextStyles.bold18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
