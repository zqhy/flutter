import 'package:flutter/foundation.dart';

class BuildMode {
  static bool get isDebug => kDebugMode == true;
  static bool get isProfile => kProfileMode == true;
  static bool get isRelease => kReleaseMode == true;
}