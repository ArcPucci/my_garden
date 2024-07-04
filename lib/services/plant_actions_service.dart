import 'package:my_garden/models/models.dart';
import 'package:sqflite/sqflite.dart';

const plantActionsTable = "PLANT_ACTIONS";

class PlantActionsService {
  final Database database;

  PlantActionsService(this.database);

  Future<void> onCreate(PlantAction plantAction) async {
    final map = plantAction.toMap();
    map['id'] = null;
    await database.insert(plantActionsTable, map);
  }

  Future<void> onUpdate(PlantAction plantAction) async {
    final map = plantAction.toMap();
    await database.update(
      plantActionsTable,
      map,
      where: 'id = ?',
      whereArgs: [plantAction.id],
    );
  }

  Future<void> onDelete(PlantAction plantAction) async {
    await database.delete(
      plantActionsTable,
      where: 'id = ?',
      whereArgs: [plantAction.id],
    );
  }

  Future<List<PlantAction>> getAllActions() async {
    final map = await database.query(plantActionsTable);
    if (map.isEmpty) return [];

    final list = map.map(PlantAction.fromMap).toList();
    return list;
  }
}
