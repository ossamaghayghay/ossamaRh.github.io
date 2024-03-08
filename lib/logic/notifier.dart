import 'package:flutter/material.dart';

class CurrentSection with ChangeNotifier {
  String _currentSection = 'ABOUT';

  String get currentSection => _currentSection;

  void updateSection(String section) {
    _currentSection = section;
    notifyListeners();
  }
}
