import 'package:flutter/cupertino.dart';
import 'package:my_garden/models/models.dart';

class TypeOfCare {
  final PlantAction plantAction;
  bool hasDailyOption = false;
  bool enabled = false;
  bool daily = true;
  TextEditingController? controller;

  TypeOfCare({
    required this.plantAction,
    this.controller,
  }) : hasDailyOption = plantAction.hasDailyOption;

  factory TypeOfCare.empty() => TypeOfCare(plantAction: PlantAction.empty());
}
