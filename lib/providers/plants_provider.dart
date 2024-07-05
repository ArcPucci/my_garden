import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_garden/models/models.dart';
import 'package:my_garden/services/services.dart';
import 'package:my_garden/utils/utils.dart';

class PlantsProvider extends ChangeNotifier {
  final PlantActionsService _actionsService;
  final PlantsService _plantsService;
  final GoRouter _router;

  PlantsProvider({
    required PlantActionsService actionsService,
    required PlantsService plantsService,
    required GoRouter router,
  })  : _actionsService = actionsService,
        _plantsService = plantsService,
        _router = router;

  List<PlantAction> _actions = [];

  List<PlantAction> get actions => _actions;

  List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  Map<int, List<int>> _todayTasks = {};

  Map<int, List<int>> get todayTasks => _todayTasks;

  List<Plant> _selectedPlants = [];

  List<Plant> get selectedPlants => _selectedPlants;

  PlantAction _plantAction = PlantAction.empty();

  PlantAction get plantAction => _plantAction;

  Plant _plant = Plant.empty();

  Plant get plant => _plant;

  List<DateTime> _dates = [];

  List<DateTime> get dates => _dates;

  Map<int, int> _selectedActions = {};

  Map<int, int> get selectedActions => _selectedActions;

  DateTime _date = DateTime.now();

  DateTime get date => _date;

  void init() async {
    _plants = await _plantsService.getPlants();
    _actions = await _actionsService.getAllActions();
    await _getTodayTasks();
    notifyListeners();
  }

  Future<void> _getTodayTasks() async {
    _todayTasks.clear();
    final currentDate = DateTime.now().withZeroTime;
    for (final item in _plants) {
      for (final item2 in item.actions) {
        if (!item2.daily &&
            (!item2.date.withZeroTime.isAtSameMomentAs(currentDate))) continue;

        final id = item2.actionId;
        final temp = _actions.map((e) => e.id).toList();

        if (!temp.contains(id)) continue;

        if (_todayTasks[id] == null) {
          _todayTasks[id] = [item.id];
          continue;
        }
        _todayTasks[id]?.add(item.id);
      }
    }
    await _getCalendarDates();
  }

  void onCreate(PlantAction plantAction) async {
    await _actionsService.onCreate(plantAction);

    _actions = await _actionsService.getAllActions();
    await _getTodayTasks();
    notifyListeners();
  }

  void onUpdate(PlantAction plantAction) async {
    await _actionsService.onUpdate(plantAction);

    _actions = await _actionsService.getAllActions();
    await _getTodayTasks();
    notifyListeners();
  }

  void onDelete(PlantAction plantAction) async {
    await _actionsService.onDelete(plantAction);

    _actions = await _actionsService.getAllActions();
    await _getTodayTasks();
    notifyListeners();
  }

  void onCreatePlant(Plant plant, File? file) async {
    await _plantsService.onCreate(plant, file);

    _plants = await _plantsService.getPlants();
    await _getTodayTasks();
    notifyListeners();
  }

  void onDeletePlant(Plant plant) async {
    await _plantsService.onDelete(plant);

    _plants = await _plantsService.getPlants();
    await _getTodayTasks();
    notifyListeners();
  }

  void onSelect(List<int> list, PlantAction plantAction) {
    _selectedPlants = _plants.where((e) => list.contains(e.id)).toList();
    _plantAction = plantAction;
    _router.go('/tasks');
  }

  void onSelectPlant(Plant plant) {
    _plant = plant;
  }

  void onEditPlant(Plant plant, File? file) async {
    await _plantsService.onUpdate(plant, file);

    _plants = await _plantsService.getPlants();
    await _getTodayTasks();
    notifyListeners();
  }

  Future<void> _getCalendarDates() async {
    _dates.clear();
    for (final item in _plants) {
      for (final item2 in item.actions) {
        if (_dates.contains(item2.date.withZeroTime)) continue;
        _dates.add(item2.date.withZeroTime);
      }
    }
  }

  void onSelectDate(DateTime dateTime) async {
    _date = dateTime;
    _selectedActions.clear();
    for (final item in _plants) {
      for (final item2 in item.actions) {
        if (item2.date.withZeroTime != dateTime.withZeroTime) continue;

        final id = item2.actionId;

        if (_selectedActions[id] == null) {
          _selectedActions[id] = 1;
          continue;
        }

        _selectedActions[id] = _selectedActions[id]! + 1;
      }
      _router.go('/calendar/actions/');
    }

    notifyListeners();
  }
}
