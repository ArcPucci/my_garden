import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_garden/models/models.dart';

final List<TabBarItem> tabBarItems = [
  TabBarItem(
    id: 0,
    title: 'My plants',
    icon: 'assets/png/icons/tree.png',
    path: '/',
  ),
  TabBarItem(
    id: 1,
    title: 'Calendar',
    icon: 'assets/png/icons/calendar.png',
    path: '/calendar',
  ),
  TabBarItem(
    id: 2,
    title: 'Settings',
    icon: 'assets/png/icons/settings.png',
    path: '/settings',
  ),
];
