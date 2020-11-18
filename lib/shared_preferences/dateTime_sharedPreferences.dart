import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DateTimeSharedPreferences with ChangeNotifier {
  String dateTime;
  SharedPreferences _preferences;

  DateTimeSharedPreferences();

  initPreferences() async {
    _preferences = await SharedPreferences.getInstance();

    dateTime = (_preferences.getString('dateTime') ?? DateTime.now().toString());
  }

  setPreferences(String newDateTime) {
    _preferences.setString('dateTime', newDateTime);
    dateTime = (_preferences.getString('dateTime') ?? DateTime.now().toString());

    notifyListeners();
  }
}