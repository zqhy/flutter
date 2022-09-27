import 'package:flutter/material.dart';

extension ThemeDataExt on ThemeData {
  bool get isDarkMode => brightness == Brightness.dark;
}