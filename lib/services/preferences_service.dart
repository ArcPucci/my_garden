import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences _preferences;

  PreferencesService({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  static const premiumKey = "PREMIUM";
  static const notificationKey = "NOTIFICATION";

  Future<void> setPremium() async {
    await _preferences.setBool(premiumKey, true);
  }

  bool getPremium() {
    return _preferences.getBool(premiumKey) ?? false;
  }

  Future<void> onSetNotification(bool enabled) async {
    await _preferences.setBool(notificationKey, enabled);
  }

  bool getNotification() {
    return _preferences.getBool(notificationKey) ?? false;
  }
}
