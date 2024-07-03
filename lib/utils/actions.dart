import 'package:my_garden/models/models.dart';

final List<PlantAction> actions = [
  PlantAction(
    id: 0,
    name: 'Watering',
    image: 'assets/png/actions/water.png',
    hasDailyOption: true,
  ),
  PlantAction(
    id: 1,
    name: 'Fertilizing',
    image: 'assets/png/actions/fertilizing.png',
  ),
  PlantAction(
    id: 2,
    name: 'Pruning',
    image: 'assets/png/actions/pruning.png',
  ),
  PlantAction(
    id: 3,
    name: 'Aerating',
    image: 'assets/png/actions/aerating.png',
  ),
  PlantAction(
    id: 4,
    name: 'Lightning',
    image: 'assets/png/actions/lightning.png',
    hasDailyOption: true,
  ),
  PlantAction(
    id: 5,
    name: 'Pest Inspection',
    image: 'assets/png/actions/pest_inspection.png',
  ),
];
