import 'dart:io';

import 'package:my_garden/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const plantsTable = "PLANTS_TABLE";

class PlantsService {
  final Database database;

  PlantsService(this.database);

  Future<void> onCreate(Plant plant, File? file) async {
    final directory = await getApplicationCacheDirectory();
    Plant temp = plant;

    if (file != null) {
      final File newImage = await file
          .copy('${directory.path}/photo${file.path.split('/').last}');
      temp = temp.copyWith(image: newImage.path);
    }

    final map = temp.toMap();
    map['id'] = null;
    await database.insert(plantsTable, map);
  }

  Future<void> onDelete(Plant plant) async {
    await database.delete(
      plantsTable,
      where: 'id = ?',
      whereArgs: [plant.id],
    );
  }

  Future<void> onUpdate(Plant plant, File? file) async {
    final directory = await getApplicationCacheDirectory();
    Plant temp = plant;

    if (file != null) {
      final File newImage = await file
          .copy('${directory.path}/photo${file.path.split('/').last}');
      temp = temp.copyWith(image: newImage.path);
    }
    final map = temp.toMap();
    await database.update(
      plantsTable,
      map,
      where: 'id = ?',
      whereArgs: [plant.id],
    );
  }

  Future<List<Plant>> getPlants() async {
    final map = await database.query(plantsTable);
    if (map.isEmpty) return [];

    final list = map.map(Plant.fromMap).toList();
    return list;
  }
}
