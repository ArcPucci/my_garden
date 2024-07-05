import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/providers/providers.dart';
import 'package:my_garden/screens/screens.dart';
import 'package:my_garden/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            const CustomAppBar(text: 'Settings'),
            SizedBox(height: 16.h),
            CustomButton2(
              text: 'Privacy policy &\nTerms of use',
              onTap: () => context.go('/settings/privacy'),
            ),
            if (!value.premium)
              CustomButton2(
                text: 'Premium',
                onTap: () => onTapPremium(context),
              ),
            CustomButton2(
              text: 'Notification',
              onTap: () => context.go('/settings/notification'),
            ),
          ],
        );
      },
    );
  }

  void onTapPremium(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (context) => const PremiumScreen(),
    );

    Navigator.of(context, rootNavigator: true).push(route);
  }
}
