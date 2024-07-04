import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/providers/providers.dart';
import 'package:my_garden/widgets/widgets.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantsProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            SizedBox(height: 12.h),
            CustomAppBar(
              text: value.plantAction.name,
              hasCancel: true,
              text2: 'Back',
              onCancel: context.pop,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                itemCount: value.selectedPlants.length,
                itemBuilder: (context, index) {
                  final plant = value.selectedPlants[index];
                  return TaskCard(plantAction: value.plantAction, plant: plant);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
