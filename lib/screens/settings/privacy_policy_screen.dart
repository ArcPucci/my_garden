import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/widgets/widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          text: "Privacy policy &\nTerms of use",
          hasCancel: true,
          text2: 'Back',
          onCancel: context.pop,
        ),
        SizedBox(height: 16.h),
        const CustomButton2(text: "Privacy policy &\nTerms of use"),
        const CustomButton2(text: "Terms of use"),
      ],
    );
  }
}
