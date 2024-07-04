import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_garden/models/models.dart';
import 'package:my_garden/providers/providers.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddPlantSheet extends StatefulWidget {
  const AddPlantSheet({super.key});

  @override
  State<AddPlantSheet> createState() => _AddPlantSheetState();
}

class _AddPlantSheetState extends State<AddPlantSheet> {
  Timer? _debounce;
  late PlantsProvider _actionsProvider;

  final List<TypeOfCare> typesOfCare = [];

  @override
  void initState() {
    super.initState();
    _actionsProvider = Provider.of(context, listen: false);

    for (final item in _actionsProvider.actions) {
      typesOfCare.add(
        TypeOfCare(
          plantAction: item,
          controller: TextEditingController(text: item.name),
        ),
      );
    }
  }

  final plantName = TextEditingController();
  XFile? file;

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
            CustomAppBar2(onSave: onSave),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 46.h),
                child: Column(
                  children: [
                    ImageBox(
                      path: file?.path,
                      onPickImage: (file) {
                        this.file = file;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 28.h),
                    CustomInput(controller: plantName),
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
                                onChanged: onChanged,
                                onEnable: () => onEnable(index),
                                onDelete: () => onDelete(index),
                              ),
                              if (typeOfCare.enabled) ...[
                                if (action.hasDailyOption) ...[
                                  SizedBox(height: 12.h),
                                  PeriodTypesList(
                                    daily: typeOfCare.daily,
                                    onSelect: (value) =>
                                        onSelectPeriod(value, index),
                                  ),
                                ],
                                if (!typeOfCare.daily ||
                                    !action.hasDailyOption) ...[
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
                                  CustomDatePicker(
                                    onChanged: (date) =>
                                        onChangedDate(date, index),
                                  ),
                                ],
                                SizedBox(height: 12.h),
                                SizedBox(
                                  width: 343.w,
                                  child: Text(
                                    'Set time',
                                    style: AppTextStyles.regular16.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                CustomTimePicker(
                                  onChanged: (time) =>
                                      onChangedTime(time, index),
                                ),
                                SizedBox(height: 12.h),
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
                    SizedBox(height: 16.h),
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
    _actionsProvider.onCreate(PlantAction.empty());
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
    _actionsProvider.onDelete(typesOfCare[index].plantAction);
    typesOfCare.removeAt(index);
    setState(() {});
  }

  void onChangedDate(DateTime date, int index) {
    final currentDate = typesOfCare[index].date;
    typesOfCare[index].date = currentDate.copyWith(
      year: date.year,
      month: date.month,
      day: date.day,
    );
  }

  void onChangedTime(DateTime time, int index) {
    final currentTime = typesOfCare[index].date;
    typesOfCare[index].date = currentTime.copyWith(
      hour: time.hour,
      month: time.minute,
    );
  }

  void onChanged(String value, PlantAction action) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final temp = action.copyWith(name: value);
      _actionsProvider.onUpdate(temp);
    });
  }

  void onSave() {
    if (plantName.text.isEmpty) return;
    final actionDates = <ActionDate>[];

    for (final item in typesOfCare) {
      if (!item.enabled) continue;
      final temp = ActionDate(
        actionId: item.plantAction.id,
        date: item.date,
        daily: item.daily,
      );
      actionDates.add(temp);
    }

    final plant = Plant(
      id: 0,
      name: plantName.text,
      image: '',
      actions: actionDates,
    );

    _actionsProvider.onCreatePlant(
      plant,
      file == null ? null : File(file!.path),
    );
    Navigator.of(context).pop();
  }
}
