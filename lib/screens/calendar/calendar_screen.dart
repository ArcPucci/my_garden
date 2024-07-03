import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/widgets/app_bars/custom_app_bar.dart';
import 'package:my_garden/widgets/calendar_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        const CustomAppBar(text: 'Calendar'),
        SizedBox(height: 12.h),
        CalendarWidget(
          initialDate: _dateTime,
          onSelect: (date) {
            _dateTime = date;
            setState(() {});
            context.go('/calendar/actions');
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
  }
}
