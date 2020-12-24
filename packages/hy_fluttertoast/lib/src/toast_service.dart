import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

import 'package:hy_flutter/hy_flutter.dart';

class ToastService extends IToastService {

  @override
  show(String message, {
    ToastLength toastLength,
    int timeInSec,
    ToastGravity gravity,
    double fontSize,
    Color backgroundColor,
    Color textColor,
  }) {
    if (message?.isNotEmpty != true) {
      return;
    }
    toast.Fluttertoast.showToast(
      msg: message,
      toastLength: toastOf(toastLength ?? ToastConfig.defaultToastLength),
      timeInSecForIosWeb: timeInSec ?? ToastConfig.defaultTimeInSec,
      gravity: toastGravityOf(gravity ?? ToastConfig.defaultGravity),
      fontSize: fontSize ?? ToastConfig.defaultFontSize,
      backgroundColor: backgroundColor ?? ToastConfig.defaultBackgroundColor,
      textColor: textColor ?? ToastConfig.defaultTextColor,
    );
  }
}

toast.Toast toastOf(ToastLength toastLength) {
  if (toastLength == null) {
    return null;
  }
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
  if (gravity == null) {
    return null;
  }

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