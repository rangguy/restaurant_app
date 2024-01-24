import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getNotifRestaurantPreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isNotifRestaurantActive = false;
  bool get isNotifRestaurantActive => _isNotifRestaurantActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getNotifRestaurantPreferences() async {
    _isNotifRestaurantActive = await preferencesHelper.isNotifRestaurantActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableNotifRestaurant(bool value) {
    preferencesHelper.setNotifRestaurant(value);
    _getNotifRestaurantPreferences();
  }
}
