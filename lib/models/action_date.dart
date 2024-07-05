import 'dart:convert';

class ActionDate {
  final int actionId;
  final List<DateTime> dates;
  final bool daily;

  ActionDate({
    required this.actionId,
    required this.dates,
    required this.daily,
  });

  factory ActionDate.empty() => ActionDate(
        actionId: 0,
        dates: [DateTime.now()],
        daily: false,
      );

  ActionDate copyWith({
    int? actionId,
    List<DateTime>? dates,
    bool? daily,
  }) {
    return ActionDate(
      actionId: actionId ?? this.actionId,
      dates: dates ?? this.dates,
      daily: daily ?? this.daily,
    );
  }

  Map<String, dynamic> toJson() {
    final list = dates.map((e) => e.microsecondsSinceEpoch.toString()).toList();
    return {
      'action_id': actionId,
      'dates': jsonEncode(list),
      'daily': daily ? 1 : 0,
    };
  }

  factory ActionDate.fromJson(Map<String, dynamic> map) {
    final list = jsonDecode(map['dates'] as String) as List<dynamic>;
    final dates = list
        .map((e) => DateTime.fromMicrosecondsSinceEpoch(int.parse(e)))
        .toList();
    return ActionDate(
      actionId: map['action_id'] as int,
      dates: dates,
      daily: (map['daily'] as int) == 1,
    );
  }
}
