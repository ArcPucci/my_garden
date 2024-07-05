import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/providers/providers.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantsProvider>(
      builder: (BuildContext context, value, Widget? child) {
        final keys = value.selectedActions.keys.toList();
        return Column(
          children: [
            SizedBox(height: 12.h),
            CustomAppBar(
              text: value.date.shortFormat,
              hasCancel: true,
              text2: 'Back',
              onCancel: context.pop,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  final id = keys[index];
                  final action = value.actions.firstWhere((e) => e.id == id);
                  final count = value.selectedActions[id]!;
                  return ActionCard(plantAction: action, count: count);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
