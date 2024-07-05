import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/utils/utils.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    super.key,
    required this.initialDate,
    this.selectedDate,
    required this.onSelect,
    required this.onPrevMonth,
    required this.onNextMonth,
    required this.dates,
    this.hasDailyTasks = false,
  });

  final DateTime initialDate;
  final DateTime? selectedDate;
  final List<DateTime> dates;
  final bool hasDailyTasks;
  final void Function(DateTime) onSelect;
  final void Function(DateTime) onPrevMonth;
  final void Function(DateTime) onNextMonth;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  static const _x = 7;
  static const _y = 5;
  static const _n = 35;
  static const List<String> _shortWeekdays = <String>[
    'S',
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
  ];

  final List<DayInfo> days = [];

  final List<int> years = [for (int i = 0; i < 100; i++) 1925 + i];

  final currentDateTime = DateTime.now();

  int defaultIndex = 99;

  @override
  void initState() {
    _calculateDays();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CalendarWidget oldWidget) {
    _calculateDays();
    super.didUpdateWidget(oldWidget);
  }

  void _calculateDays() {
    days.clear();
    final int year = widget.initialDate.year;
    final int month = widget.initialDate.month;

    final prevMonth = widget.initialDate.copyWith(month: month - 1).month;

    final int daysInPrevMonth = DateUtils.getDaysInMonth(year, prevMonth);
    final int daysInMonth = DateUtils.getDaysInMonth(year, month);

    final int dayOffset = DateUtils.firstDayOffset(
      year,
      month,
      const DefaultMaterialLocalizations(),
    );

    var n = _n;

    for (int i = 1; i <= dayOffset; i++) {
      final int id = daysInPrevMonth - dayOffset + i;
      days.add(DayInfo(
        id: id,
        canSelected: false,
        isCurrentMonth: false,
        isCurrentDay: false,
      ));
      n--;
    }

    for (int i = 1; i <= daysInMonth; i++) {
      final dateTime = DateTime(year, month, i);
      days.add(
        DayInfo(
          id: i,
          canSelected: dateTime.isAfter(currentDateTime),
          isCurrentMonth: true,
          isCurrentDay: dateTime == currentDateTime.withZeroTime,
        ),
      );
      n--;
    }
    for (int i = 1; i <= n; i++) {
      days.add(DayInfo(
        id: i,
        canSelected: false,
        isCurrentMonth: false,
        isCurrentDay: false,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        color: AppTheme.gray6,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  final temp = widget.initialDate;
                  widget.onPrevMonth(temp.copyWith(month: temp.month - 1));
                },
                child: Image.asset(
                  'assets/png/icons/prev.png',
                  width: 40.w,
                  height: 40.h,
                ),
              ),
              Text(
                widget.initialDate.monthAndYear,
                style: AppTextStyles.semiBold22,
              ),
              Transform.rotate(
                angle: pi,
                child: GestureDetector(
                  onTap: () {
                    final temp = widget.initialDate;
                    widget.onNextMonth(temp.copyWith(month: temp.month + 1));
                  },
                  child: Image.asset(
                    'assets/png/icons/prev.png',
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _x,
              (index) => SizedBox(
                width: 40.w,
                height: 40.h,
                child: Center(
                  child: Text(
                    _shortWeekdays[index].toUpperCase(),
                    style: AppTextStyles.semiBold18,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _y,
              (y) => Padding(
                padding: EdgeInsets.only(bottom: y == _y - 1 ? 0 : 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _x,
                    (x) {
                      final day = days[index++];
                      final temp = widget.initialDate.copyWith(day: day.id);
                      final hasColor = (widget.hasDailyTasks ||
                              widget.dates.contains(temp.withZeroTime)) &&
                          !day.isCurrentDay &&
                          day.isCurrentMonth &&
                          day.isCurrentMonth &&
                          day.canSelected;
                      return GestureDetector(
                        onTap: () {
                          if (!day.canSelected && !day.isCurrentDay) return;
                          widget.onSelect(temp);
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: day.isCurrentDay
                                ? Border.all(
                                    width: 2.sp,
                                    color: AppTheme.blue3,
                                  )
                                : null,
                            color: hasColor ? AppTheme.green : null,
                          ),
                          alignment: Alignment.center,
                          child: _buildDay(day),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDay(DayInfo day) {
    final temp = widget.initialDate.copyWith(day: day.id).withZeroTime;
    if (!day.isCurrentMonth) return SizedBox();
    if (day.isCurrentDay)
      return Text(
        '${day.id}',
        style: AppTextStyles.regular18.copyWith(color: AppTheme.blue3),
      );
    if (widget.dates.contains(temp) || widget.hasDailyTasks && day.canSelected)
      return Text(
        '${day.id}',
        style: AppTextStyles.regular18.copyWith(color: Colors.white),
      );
    if (day.canSelected)
      return Text('${day.id}', style: AppTextStyles.regular18);
    return Text(
      '${day.id}',
      style: AppTextStyles.regular18.copyWith(
        color: AppTheme.gray8,
      ),
    );
  }
}

class DayInfo {
  final int id;
  final bool canSelected;
  final bool isCurrentMonth;
  final bool isCurrentDay;

  const DayInfo({
    required this.id,
    required this.canSelected,
    required this.isCurrentMonth,
    required this.isCurrentDay,
  });
}
