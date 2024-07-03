import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/app_bars/custom_app_bar.dart';
import 'package:my_garden/widgets/widgets.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        const CustomAppBar(text: 'My Plants'),
        Expanded(
          child: Column(
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
          ),
        ),
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
}
