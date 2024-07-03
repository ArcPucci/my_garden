import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get shortFormat => DateFormat('dd MMMM').format(this);
  String get shortFullFormat => DateFormat('d MMM y').format(this);
  String get monthAndYear => DateFormat('MMM yyyy').format(this);
  String get time => DateFormat('HH:mm').format(this);
  String get shortMonthFormat => DateFormat('MMM').format(this);
  DateTime get withZeroTime => DateTime(year, month, day);
  DateTime get averageDay => DateTime(year, month, 15);
  String get shortFullFormat2 => DateFormat('MMM dd, h:mm aaa').format(this);
  String get fullFormat => DateFormat('dd.MM.yyyy H:m').format(this);
}