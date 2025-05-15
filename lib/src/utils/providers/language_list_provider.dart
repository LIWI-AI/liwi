import 'package:flutter/material.dart';

class LanguageListProvider with ChangeNotifier {
  static const List<String> _populaLanguages = [
    'Arabic',
    'Hindi',
    'Chinese',
    'Japanese',
  ];
  static const List<String> _allLanguages = [
    'English',
    'Spanish',
    'French',
    'German',
    // 'Italian',
    // 'Portuguese',
    // 'Russian',
    // 'Korean',
    // 'Turkish',
    // 'Dutch',
    // 'Swedish',
    // 'Norwegian',
    // 'Danish',
    // 'Finnish',
  ];
  List<String> get popularLanguages => _populaLanguages;
  List<String> get allLanguages => _allLanguages;
}