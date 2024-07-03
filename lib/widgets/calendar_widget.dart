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
  });

  final DateTime initialDate;
  final DateTime? selectedDate;
  final void Function(DateTime) onSelect;
  final void Function(DateTime) onPrevMonth;
  final void Function(DateTime) onNextMonth;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  static const _x = 7;
  static const _y = 6;
  static const _n = 42;
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
          canSelected: dateTime.isBefore(currentDateTime),
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
                  widget.onSelect(temp.copyWith(month: temp.month - 1));
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
                    widget.onSelect(temp.copyWith(month: temp.month + 1));
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
                      return GestureDetector(
                        onTap: () {
                          final temp = widget.initialDate.copyWith(day: day.id);
                          widget.onSelect(temp);
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          alignment: Alignment.center,
                          child: Text(
                            '${day.id}',
                            style: AppTextStyles.regular18.copyWith(
                              color: AppTheme.gray8,
                            ),
                          ),
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
