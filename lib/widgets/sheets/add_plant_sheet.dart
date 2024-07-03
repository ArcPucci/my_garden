import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/models/models.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/widgets.dart';

class AddPlantSheet extends StatefulWidget {
  const AddPlantSheet({super.key});

  @override
  State<AddPlantSheet> createState() => _AddPlantSheetState();
}

class _AddPlantSheetState extends State<AddPlantSheet> {
  final List<TypeOfCare> typesOfCare =
      actions.map((e) => TypeOfCare(plantAction: e)).toList();

  @override
  Widget build(BuildContext context) {
    final overlay = MediaQuery.of(context).padding;
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 375.w,
        height: 727.h + overlay.bottom,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 14.h),
            const CustomAppBar2(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 46.h),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/png/logo.png',
                      width: 104.w,
                      height: 104.h,
                    ),
                    SizedBox(height: 28.h),
                    CustomInput(),
                    SizedBox(height: 18.h),
                    SizedBox(
                      width: 343.w,
                      child: Text(
                        'Type of care',
                        style: AppTextStyles.medium18.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Column(
                      children: List.generate(
                        typesOfCare.length,
                        (index) {
                          final typeOfCare = typesOfCare[index];
                          final action = typeOfCare.plantAction;
                          final enabled = typeOfCare.enabled;
                          final controller = typeOfCare.controller;
                          return Column(
                            children: [
                              TypeOfCareCard(
                                enabled: enabled,
                                controller: controller,
                                plantAction: action,
                                onEnable: () => onEnable(index),
                                onDelete: () => onDelete(index),
                              ),
                              if (typeOfCare.enabled) ...[
                                SizedBox(height: 12.h),
                                PeriodTypesList(
                                  daily: typeOfCare.daily,
                                  onSelect: (value) =>
                                      onSelectPeriod(value, index),
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  width: 343.w,
                                  child: Text(
                                    'Set date',
                                    style: AppTextStyles.regular16.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                CustomBG(
                                  width: 343.w,
                                  height: 164.h,
                                  child: CupertinoDatePicker(
                                    itemExtent: 35.h,
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (date) {},
                                  ),
                                ),
                              ],
                              Container(
                                width: 343.w,
                                height: 1.sp,
                                color: AppTheme.gray2,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomButton1(text: 'Add care', onTap: onAdd),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onAdd() {
    typesOfCare.add(TypeOfCare(
      plantAction: PlantAction.empty(),
      controller: TextEditingController(text: 'Other'),
    ));
    setState(() {});
  }

  void onEnable(int index) {
    typesOfCare[index].enabled = !typesOfCare[index].enabled;
    setState(() {});
  }

  void onSelectPeriod(bool daily, int index) {
    typesOfCare[index].daily = daily;
    setState(() {});
  }

  void onDelete(int index) {
    typesOfCare.removeAt(index);
    setState(() {});
  }
}
