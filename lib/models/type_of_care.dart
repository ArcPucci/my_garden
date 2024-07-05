import 'package:flutter/cupertino.dart';
import 'package:my_garden/models/models.dart';

class TypeOfCare {
  final PlantAction plantAction;
  bool enabled = false;
  bool daily = true;
  TextEditingController? controller;
  List<DateTime> dates = [DateTime.now()];

  TypeOfCare({required this.plantAction, this.controller});

  factory TypeOfCare.empty() => TypeOfCare(plantAction: PlantAction.empty());
}
