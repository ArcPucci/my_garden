import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/providers/providers.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantsProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            SizedBox(height: 12.h),
            const CustomAppBar(text: 'My Plants'),
            Expanded(
              child: value.plants.isEmpty
                  ? _buildEmptyBody(context)
                  : Stack(
                      children: [
                        Positioned.fill(
                          child: Column(
                            children: [
                              SizedBox(height: 12.h),
                              CustomTabBar(
                                selectedIndex: _tabIndex,
                                onChanged: onChanged,
                              ),
                              Expanded(
                                child: _tabIndex == 0
                                    ? _buildTasksList(context, value)
                                    : _buildPlantsList(context, value),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 12.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CustomButton1(
                              width: 319.w,
                              icon: 'assets/png/icons/plus.png',
                              onTap: () => onAddPlant(context),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlantsList(BuildContext context, PlantsProvider value) {
    return ListView.builder(
      itemCount: value.plants.length,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      itemBuilder: (context, index) {
        final plant = value.plants[index];
        return PlantCard(
          plant: plant,
          onDelete: () => value.onDeletePlant(plant),
        );
      },
    );
  }

  Widget _buildTasksList(BuildContext context, PlantsProvider value) {
    final list = value.todayTasks.keys.toList();
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 28.h),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final last = index == value.actions.length - 1;
        final id = list[index];
        final action = value.actions.firstWhere((e) => e.id == id);
        final list2 = value.todayTasks[id]!;
        final count = list2.length;
        return Padding(
          padding: EdgeInsets.only(bottom: last ? 150.h : 0),
          child: ActionCard(
            plantAction: action,
            count: count,
            onTap: () => value.onSelect(list2, action),
          ),
        );
      },
    );
  }

  Widget _buildEmptyBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onAddPlant(context),
          child: Image.asset(
            'assets/png/add.png',
            width: 58.w,
            height: 58.h,
          ),
        ),
        SizedBox(height: 8.h),
        Text('Add plant', style: AppTextStyles.regular24),
      ],
    );
  }

  void onAddPlant(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return const AddPlantSheet();
      },
    );
  }

  void onChanged(int index) {
    _tabIndex = index;
    setState(() {});
  }
}
