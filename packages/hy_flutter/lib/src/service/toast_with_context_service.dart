import 'package:flutter/material.dart';
import 'package:hy_flutter/hy_flutter.dart';

import '../widget/ftoast.dart';

typedef Widget CreateToastChild(String msg, {
  double? fontSize,
  Color? backgroundColor,
  Color? textColor
});

class ToastWithContextService implements IToastService {
  final _fToast = FToast();
  final CreateToastChild createToastChild;

  ToastWithContextService({this.createToastChild = _defaultCreateToastChild});

  @override
  void setContext(BuildContext context) {
    _fToast.init(context);
  }

  @override
  void show(String message, {
    ToastLength? toastLength,
    Duration? toastDuration,
    int? timeInSec,
    ToastGravity? gravity,
    double? fontSize,
    Color? backgroundColor,
    Color? textColor
  }) {
    if (message.isEmpty || _fToast.context == null) {
      return;
    }
    _fToast.showToast(
      toastDuration: toastDuration ?? toastOf(toastLength ?? ToastConfig.defaultToastLength),
      gravity: gravity ?? ToastConfig.defaultGravity,
      child: createToastChild(message, fontSize: fontSize, backgroundColor: backgroundColor, textColor: textColor),
    );
  }
}

Widget _defaultCreateToastChild(String msg, {
  double? fontSize,
  Color? backgroundColor,
  Color? textColor
}) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: backgroundColor ?? Colors.black,
  ),
  child: Text(msg, style: TextStyle(color: textColor ?? Colors.white, fontSize: fontSize),),
);

Duration? toastOf(ToastLength? toastLength) {
  if (toastLength == null) {
    return null;
  }
  switch (toastLength) {
    case ToastLength.LENGTH_SHORT:
      return Duration(seconds: 2);
    case ToastLength.LENGTH_LONG:
      return Duration(seconds: 6);
    default:
      throw UnsupportedError(toastLength.toString());
  }
}




