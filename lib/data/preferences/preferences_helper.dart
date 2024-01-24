import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const darkTheme = 'DARK_THEME';
  static const notifRestaurant = 'NOTIF_RESTAURANT';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isNotifRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(notifRestaurant) ?? false;
  }

  void setNotifRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(notifRestaurant, value);
  }
}
