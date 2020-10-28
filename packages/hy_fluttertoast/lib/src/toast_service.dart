import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

import 'package:hy_flutter/hy_flutter.dart';

class ToastService extends IToastService {

  @override
  show(String message, {
    ToastLength toastLength,
    ToastGravity gravity,
    double fontSize = 16.0,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    if (message?.isNotEmpty != true) {
      return;
    }
    toast.Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength == null ? null : toastOf(toastLength),
      gravity: gravity == null ? null : toastGravityOf(gravity),
      fontSize: fontSize,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}

toast.Toast toastOf(ToastLength toastLength) {
  switch (toastLength) {
    case ToastLength.LENGTH_SHORT:
      return toast.Toast.LENGTH_SHORT;
    case ToastLength.LENGTH_LONG:
      return toast.Toast.LENGTH_LONG;
    default:
      throw UnsupportedError(toastLength.toString());
  }
}

toast.ToastGravity toastGravityOf(ToastGravity gravity) {
  switch (gravity) {
    case ToastGravity.TOP:
      return toast.ToastGravity.TOP;
    case ToastGravity.BOTTOM:
      return toast.ToastGravity.BOTTOM;
    case ToastGravity.CENTER:
      return toast.ToastGravity.CENTER;
    case ToastGravity.TOP_LEFT:
      return toast.ToastGravity.TOP_LEFT;
    case ToastGravity.TOP_RIGHT:
      return toast.ToastGravity.TOP_RIGHT;
    case ToastGravity.BOTTOM_LEFT:
      return toast.ToastGravity.BOTTOM_LEFT;
    case ToastGravity.BOTTOM_RIGHT:
      return toast.ToastGravity.BOTTOM_RIGHT;
    case ToastGravity.CENTER_LEFT:
      return toast.ToastGravity.CENTER_LEFT;
    case ToastGravity.CENTER_RIGHT:
      return toast.ToastGravity.CENTER_RIGHT;
    default:
      throw UnsupportedError(gravity.toString());
  }
}