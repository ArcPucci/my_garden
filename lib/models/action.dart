class PlantAction {
  final int id;
  final String name;
  final String image;
  final bool hasDailyOption;

  PlantAction({
    required this.id,
    required this.name,
    required this.image,
    this.hasDailyOption = false,
  });

  factory PlantAction.empty() => PlantAction(
        id: -1,
        name: 'Other',
        image: '',
        hasDailyOption: false,
      );

  PlantAction copyWith({
    int? id,
    String? name,
    String? image,
    bool? hasDailyOption,
  }) {
    return PlantAction(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      hasDailyOption: hasDailyOption ?? this.hasDailyOption,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'has_daily_option': hasDailyOption ? 1 : 0,
    };
  }

  factory PlantAction.fromMap(Map<String, dynamic> map) {
    return PlantAction(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      hasDailyOption: (map['has_daily_option'] as int) == 1,
    );
  }
}
