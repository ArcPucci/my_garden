import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/widgets/widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          text: 'Notification',
          hasCancel: true,
          text2: "Back",
          onCancel: context.pop,
        ),
        SizedBox(height: 16.h),
        CustomButton2(
          text: 'On',
          leading: CustomSwitchButton(
            toggled: false,
            onSwitch: (value) {},
          ),
        ),
      ],
    );
  }
}
