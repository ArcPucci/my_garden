import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_garden/models/models.dart';
import 'package:my_garden/services/services.dart';

class PlantsProvider extends ChangeNotifier {
  final PlantActionsService _actionsService;
  final PlantsService _plantsService;

  PlantsProvider({
    required PlantActionsService actionsService,
    required PlantsService plantsService,
  })  : _actionsService = actionsService,
        _plantsService = plantsService;

  List<PlantAction> _actions = [];

  List<PlantAction> get actions => _actions;

  List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  void init() async {
    _plants = await _plantsService.getPlants();
    _actions = await _actionsService.getAllActions();
    notifyListeners();
  }

  void onCreate(PlantAction plantAction) async {
    await _actionsService.onCreate(plantAction);

    _actions = await _actionsService.getAllActions();
    notifyListeners();
  }

  void onUpdate(PlantAction plantAction) async {
    await _actionsService.onUpdate(plantAction);

    _actions = await _actionsService.getAllActions();
    notifyListeners();
  }

  void onDelete(PlantAction plantAction) async {
    await _actionsService.onDelete(plantAction);

    _actions = await _actionsService.getAllActions();
    notifyListeners();
  }

  void onCreatePlant(Plant plant, File? file) async {
    await _plantsService.onCreate(plant, file);

    _plants = await _plantsService.getPlants();
    notifyListeners();
  }

  void onDeletePlant(Plant plant) async {
    await _plantsService.onDelete(plant);

    _plants = await _plantsService.getPlants();
    notifyListeners();
  }
}
