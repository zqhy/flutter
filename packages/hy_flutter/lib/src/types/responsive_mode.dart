import 'package:flutter/widgets.dart';
import '../extensions/context_ext.dart';

enum ResponsiveMode {
  watch, mobile, tablet, desktop
}

ResponsiveMode responsiveModeOf(BuildContext context) {
  final width = context.width;
  if (width >= 1200) return ResponsiveMode.desktop;
  if (width >= 600) return ResponsiveMode.tablet;
  if (width >= 300) return ResponsiveMode.mobile;
  return ResponsiveMode.watch;
}