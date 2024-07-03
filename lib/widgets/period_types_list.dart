import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';
import 'package:my_garden/widgets/widgets.dart';

class PeriodTypesList extends StatelessWidget {
  const PeriodTypesList({
    super.key,
    this.daily = true,
    required this.onSelect,
  });

  final bool daily;
  final void Function(bool) onSelect;

  @override
  Widget build(BuildContext context) {
    return CustomBG(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomButton4(
            text: "Daily",
            selected: daily,
            onTap: () => onSelect(true),
          ),
          Container(
            width: 331.w,
            height: 1.sp,
            color: AppTheme.gray7,
          ),
          CustomButton4(
            text: "Other",
            selected: !daily,
            onTap: () => onSelect(false),
          ),
        ],
      ),
    );
  }
}
