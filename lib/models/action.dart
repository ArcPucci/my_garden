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
        name: '',
        image: '',
        hasDailyOption: true,
      );
}
