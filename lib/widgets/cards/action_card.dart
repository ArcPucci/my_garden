import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/models/models.dart';
import 'package:my_garden/utils/utils.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.plantAction,
  });

  final PlantAction plantAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 88.h,
      alignment: Alignment.centerRight,
      child: Container(
        width: 347.w,
        height: 88.h,
        padding: EdgeInsets.only(right: 28.w),
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
            if (plantAction.image.isNotEmpty)
              Text(plantAction.name, style: AppTextStyles.semiBold16),
            Spacer(),
            Text('2', style: AppTextStyles.semiBold24),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
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
