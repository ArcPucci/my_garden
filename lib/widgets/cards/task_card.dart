import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/models/models.dart';
import 'package:my_garden/utils/utils.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.plantAction,
    required this.plant,
  });

  final PlantAction plantAction;
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 96.h,
      alignment: Alignment.centerRight,
      child: Container(
        width: 347.w,
        height: 96.h,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.sp,
              color: AppTheme.gray2,
            ),
          ),
        ),
        padding: EdgeInsets.only(right: 28.w),
        child: Row(
          children: [
            _buildImage(),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                plant.name,
                style: AppTextStyles.semiBold16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildCAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (plant.image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(plant.image),
          width: 66.w,
          height: 66.h,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      'assets/png/logo.png',
      width: 66.w,
      height: 66.h,
    );
  }

  Widget _buildCAction() {
    if (plantAction.image.isNotEmpty) {
      return Image.asset(
        plantAction.image,
        width: 48.w,
        height: 48.h,
      );
    }
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 21.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.sp,
          color: AppTheme.green,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      child: Text(
        plantAction.name,
        style: AppTextStyles.medium18.copyWith(color: AppTheme.green3),
      ),
    );
  }
}
