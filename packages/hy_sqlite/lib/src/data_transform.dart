class DataTransform {
  static bool getBoolFromInt(int? source) => source == 1;

  static int? boolToInt(bool? source) => source == null ? null : source ? 1 : 0;
}