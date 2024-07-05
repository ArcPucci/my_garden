import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/providers/providers.dart';
import 'package:my_garden/widgets/app_bars/custom_app_bar.dart';
import 'package:my_garden/widgets/calendar_widget.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantsProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            SizedBox(height: 12.h),
            const CustomAppBar(text: 'Calendar'),
            SizedBox(height: 12.h),
            CalendarWidget(
              initialDate: _dateTime,
              dates: value.dates,
              hasDailyTasks: value.hasDailyTask,
              onSelect: (date) {
                _dateTime = date;
                setState(() {});
                value.onSelectDate(_dateTime);
              },
              onPrevMonth: (date) {
                _dateTime = date;
                setState(() {});
              },
              onNextMonth: (date) {
                _dateTime = date;
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
