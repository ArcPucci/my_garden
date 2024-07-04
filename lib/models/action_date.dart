class ActionDate {
  final int actionId;
  final DateTime date;
  final bool daily;

  ActionDate({
    required this.actionId,
    required this.date,
    required this.daily,
  });

  factory ActionDate.empty() => ActionDate(
        actionId: 0,
        date: DateTime.now(),
        daily: false,
      );

  ActionDate copyWith({
    int? actionId,
    DateTime? date,
    bool? daily,
  }) {
    return ActionDate(
      actionId: actionId ?? this.actionId,
      date: date ?? this.date,
      daily: daily ?? this.daily,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action_id': actionId,
      'date': date.microsecondsSinceEpoch,
      'daily': daily ? 1 : 0,
    };
  }

  factory ActionDate.fromJson(Map<String, dynamic> map) {
    return ActionDate(
      actionId: map['action_id'] as int,
      date: DateTime.fromMicrosecondsSinceEpoch(map['date'] as int),
      daily: (map['daily'] as int) == 1,
    );
  }
}
