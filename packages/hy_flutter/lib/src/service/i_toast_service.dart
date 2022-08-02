import 'package:flutter/material.dart';

enum ToastLength { LENGTH_SHORT, LENGTH_LONG }

enum ToastGravity { TOP, BOTTOM, CENTER, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT, CENTER_LEFT, CENTER_RIGHT }

class ToastConfig {
  static ToastLength? defaultToastLength  = ToastLength.LENGTH_SHORT;
  static int defaultTimeInSec = 2;
  static ToastGravity? defaultGravity = ToastGravity.BOTTOM;
  static double? defaultFontSize = 16.0;
  static Color? defaultBackgroundColor = Colors.black;
  static Color? defaultTextColor = Colors.white;
}

abstract class IToastService{
  show(String message, {
    ToastLength? toastLength,
    Duration? toastDuration,
    int? timeInSec,
    ToastGravity? gravity,
    double? fontSize,
    Color? backgroundColor,
    Color? textColor});
}