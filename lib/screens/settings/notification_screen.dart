import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/providers/providers.dart';
import 'package:my_garden/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (BuildContext context, value, Widget? child) {
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
              text: value.notification ? 'On' : 'Off',
              leading: CustomSwitchButton(
                toggled: value.notification,
                onSwitch: (toggled) => value.onEnableNotification(),
              ),
            ),
          ],
        );
      },
    );
  }
}
