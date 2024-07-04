import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_garden/models/models.dart';
import 'package:my_garden/utils/utils.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({
    super.key,
    required this.plant,
    this.onTap,
    this.onDelete,
  });

  final Plant plant;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.21,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Image.asset(
                    'assets/png/icons/delete.png',
                    width: 24.w,
                    height: 32.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      child: Container(
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
          child: Row(
            children: [
              _buildImage(),
              SizedBox(width: 12.w),
              Text(plant.name, style: AppTextStyles.semiBold16),
            ],
          ),
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
}
