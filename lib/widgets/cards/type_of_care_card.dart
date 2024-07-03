import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_garden/models/models.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/widgets.dart';

class TypeOfCareCard extends StatelessWidget {
  TypeOfCareCard({
    super.key,
    required this.plantAction,
    required this.enabled,
    this.onEnable,
    this.controller,
    this.onDelete,
  });

  final TextEditingController? controller;
  final bool enabled;
  final VoidCallback? onEnable;
  final PlantAction plantAction;
  final VoidCallback? onDelete;

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: plantAction.image.isEmpty,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
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
        height: 64.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: _buildBody()),
            CustomSwitchButton(
              toggled: enabled,
              onSwitch: (value) => onEnable?.call(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (plantAction.image.isEmpty) {
      return IntrinsicWidth(
        child: GestureDetector(
          onTap: focusNode.requestFocus,
          child: Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1.sp, color: AppTheme.green),
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              inputFormatters: [LengthLimitingTextInputFormatter(16)],
              style: AppTextStyles.semiBold18.copyWith(color: AppTheme.green3),
              decoration: const InputDecoration.collapsed(hintText: ''),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        Image.asset(plantAction.image, width: 48.w, height: 48.h),
        SizedBox(width: 12.w),
        Text(
          plantAction.name,
          style: AppTextStyles.medium18.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
