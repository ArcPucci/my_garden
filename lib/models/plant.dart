import 'dart:convert';

import 'package:my_garden/models/models.dart';

class Plant {
  final int id;
  final String name;
  final String image;
  final List<ActionDate> actions;

  Plant({
    required this.id,
    required this.name,
    required this.image,
    required this.actions,
  });

  Plant copyWith({
    int? id,
    String? name,
    String? image,
    List<ActionDate>? actions,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'actions': jsonEncode(actions),
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    final list = jsonDecode(map['actions'] as String) as List<dynamic>;
    final actions = list.map((e) => ActionDate.fromJson(e)).toList();
    return Plant(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      actions: actions,
    );
  }
}
