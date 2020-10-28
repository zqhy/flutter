import 'dart:ui';

enum ToastLength { LENGTH_SHORT, LENGTH_LONG }

enum ToastGravity { TOP, BOTTOM, CENTER, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT, CENTER_LEFT, CENTER_RIGHT }

abstract class IToastService{
  show(String message, {
    ToastLength toastLength,
    ToastGravity gravity,
    double fontSize = 16.0,
    Color backgroundColor,
    Color textColor});
}