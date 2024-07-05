import 'package:flutter/material.dart';
import 'package:my_garden/services/services.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferencesService _service;

  PreferencesProvider({
    required PreferencesService service,
  }) : _service = service;

  bool _premium = false;

  bool get premium => _premium;

  bool _notification = false;

  bool get notification => _notification;

  void init() {
    _premium = _service.getPremium();
    _notification = _service.getNotification();
    notifyListeners();
  }

  void onEnableNotification() async {
    _notification = !_notification;
    await _service.onSetNotification(_notification);
    notifyListeners();
  }

  void onBuyPremium() async {
    _premium = true;
    await _service.setPremium();
    notifyListeners();
  }
}
