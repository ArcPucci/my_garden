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

  bool _hasDailyTask = false;

  bool get hasDailyTask => _hasDailyTask;

  void init() async {
    await _getTodayTasks();
    notifyListeners();
  }

  Future<void> _updatePlants() async {
    _plants = await _plantsService.getPlants();
    for (int i = 0; i < _plants.length; i++) {
      final plant = _plants[i];
      for (int j = 0; j < plant.actions.length; j++) {
        final action = plant.actions[j];
        if (!action.daily) continue;
        for (int p = 0; p < action.dates.length; p++) {
          final d1 = action.dates[p].withZeroTime.microsecondsSinceEpoch;
          final d2 = DateTime.now().withZeroTime.microsecondsSinceEpoch;
          if (d1 > d2) return;
          _plants[i].actions[j].dates[p] = DateTime.now();
        }
      }
    }
  }

  Future<void> _getTodayTasks() async {
    await _updatePlants();
    _actions = await _actionsService.getAllActions();
    _todayTasks.clear();
    final currentDate = DateTime.now().withZeroTime;
    for (final item in _plants) {
      for (final item2 in item.actions) {
        for (final date in item2.dates) {
          final d1 = date.withZeroTime.microsecondsSinceEpoch;
          final d2 = currentDate.microsecondsSinceEpoch;
          if (d1 != d2) continue;

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
    }
    await _getCalendarDates();
  }

  Future<int> onCreate(PlantAction plantAction) async {
    final id = await _actionsService.onCreate(plantAction);

    await _getTodayTasks();
    notifyListeners();
    return id;
  }

  Future<void> onUpdate(PlantAction plantAction) async {
    await _actionsService.onUpdate(plantAction);

    await _getTodayTasks();
    notifyListeners();
  }

  void onDelete(PlantAction plantAction) async {
    await _actionsService.onDelete(plantAction);

    await _getTodayTasks();
    notifyListeners();
  }

  void onCreatePlant(Plant plant, File? file) async {
    await _plantsService.onCreate(plant, file);

    await _getTodayTasks();
    notifyListeners();
  }

  void onDeletePlant(Plant plant) async {
    await _plantsService.onDelete(plant);

    await _getTodayTasks();
    notifyListeners();
  }

  void onSelect(List<int> list, PlantAction plantAction) {
    _selectedPlants.clear();

    final temp = _plants.where((e) => list.contains(e.id)).toList();
    final currentDate = DateTime.now().withZeroTime;

    for (int i = 0; i < temp.length; i++) {
      final item = temp[i];
      final index =
          item.actions.indexWhere((e) => e.actionId == plantAction.id);
      for (final date in item.actions[index].dates) {
        if (date.withZeroTime != currentDate) continue;
        final temp2 = item.actions[index].copyWith(dates: [date]);
        temp[i] = item.copyWith(actions: [temp2]);
        _selectedPlants.add(item);
      }
    }

    _plantAction = plantAction;
    _router.go('/tasks');
  }

  void onSelectPlant(Plant plant) {
    _plant = plant;
  }

  void onEditPlant(Plant plant, File? file) async {
    await _plantsService.onUpdate(plant, file);

    await _getTodayTasks();
    notifyListeners();
  }

  Future<void> _getCalendarDates() async {
    _hasDailyTask = false;
    final currentDate = DateTime.now().withZeroTime;
    _dates.clear();
    for (final item in _plants) {
      for (final item2 in item.actions) {
        final actions = _actions.where((e) => e.id == item2.actionId);
        if (actions.isEmpty) continue;
        final action = actions.first;
        for (final date in item2.dates) {
          if (_hasDailyTask) continue;
          _hasDailyTask = item2.daily && action.hasDailyOption;
          if (date.isBefore(currentDate)) continue;
          if (_dates.contains(date.withZeroTime)) continue;
          _dates.add(date.withZeroTime);
        }
      }
    }
  }

  void onSelectDate(DateTime dateTime) async {
    _date = dateTime;
    _selectedActions.clear();
    for (final item in _plants) {
      for (final item2 in item.actions) {
        final id = item2.actionId;
        final actions = _actions.where((e) => e.id == id);
        if (actions.isEmpty) continue;

        final action = actions.firstWhere((e) => e.id == id);

        for (final date in item2.dates) {
          if ((date.withZeroTime == dateTime.withZeroTime) ||
              (item2.daily && action.hasDailyOption)) {
            if (_selectedActions[id] == null) {
              _selectedActions[id] = 1;
              continue;
            }

            _selectedActions[id] = _selectedActions[id]! + 1;
          }
        }
      }
    }

    notifyListeners();
    _router.go('/calendar/actions/');
  }

  void onCompleteTask(Plant plant, int plantIndex) async {
    final index = _plants.indexWhere((e) => e.id == plant.id);
    final actionIndex = _plants[index].actions.indexWhere(
          (e) => e.actionId == plantAction.id,
        );
    _selectedPlants.removeAt(plantIndex);

    print(_plants[index].actions[actionIndex].dates.last);
    if (_plants[index].actions[actionIndex].daily &&
        plantAction.hasDailyOption) {
      final lastDate = _plants[index].actions[actionIndex].dates.last;
      _plants[index].actions[actionIndex].dates.last =
          lastDate.add(Duration(days: 1));
    } else {
      _plants[index].actions[actionIndex].dates.removeLast();
    }
    print(_plants[index].actions[actionIndex].dates.last);
    await _plantsService.onUpdate(_plants[index], null);
    await _getTodayTasks();
    notifyListeners();
  }
}
