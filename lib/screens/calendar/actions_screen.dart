import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/widgets.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        CustomAppBar(
          text: DateTime.now().shortFormat,
          hasCancel: true,
          text2: 'Back',
          onCancel: context.pop,
        ),
      ],
    );
  }
}
