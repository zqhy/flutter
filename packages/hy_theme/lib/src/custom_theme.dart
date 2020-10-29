import 'storage_by_type.dart';

/// Interface for custom theme data implementation.
///
/// If you want to use other [CustomThemeData] as part of
/// this theme data and this other data should be available
/// through [CustomThemes.of] - use [ComplexCustomThemeData].
abstract class CustomThemeData {
  const CustomThemeData();
}

/// Interface for custom theme data with nested [CustomThemeData].
///
/// All nested [CustomThemeData] will be available through [CustomThemes.of].
abstract class ComplexCustomThemeData extends CustomThemeData
    with StorageByTypeMixin {
  ComplexCustomThemeData(List<CustomThemeData> nested) {
    setData(nested.where((item) => item != null), recursive: true);
  }
}
