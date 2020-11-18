import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;
  Color menuColor = Colors.black;
  bool _isDartMode = false;
  Color buttonColor = Colors.deepPurpleAccent;
  Color drawColor = Colors.white;
  Color cardColor = Color.fromRGBO(249, 249, 249, 1);
  Color iconColor = Colors.grey;
  Color BNColor = Color.fromRGBO(51, 0, 255, 1);

  ColorProvider();

  bool get isDarkMode => _isDartMode;

  set isDarkMode(bool value) {
    _isDartMode = value;

    if (_isDartMode) {
      _darkMode();
    } else {
      _lightMode();
    }

    notifyListeners();
  }

  _darkMode() {
    backgroundColor = Colors.black;
    menuColor = Colors.white;
    drawColor = Colors.black26;
    cardColor = Color.fromRGBO(56, 56, 56, 1);
    textColor = Colors.white;
    iconColor = Colors.white60;
  }

  _lightMode() {
    backgroundColor = Colors.white;
    menuColor = Colors.black;
    drawColor = Colors.white;
    cardColor = Color.fromRGBO(249, 249, 249, 1);
    textColor = Colors.black;
    iconColor = Colors.grey;
  }
}
