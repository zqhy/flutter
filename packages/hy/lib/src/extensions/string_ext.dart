import 'dynamic_ext.dart';

extension StringExt on String {
  String? get notEmpty => this.isNotEmpty == true ? this : null;
  String? get notBlank => isNullOrBlank ? null : this;

  int toHexColor() {
    String string = this.toUpperCase().replaceAll("#", "");
    if (string.length == 6) {
      string = "FF" + string;
    }
    return int.parse(string, radix: 16);
  }

  /// The [radix] must be in the range 2..36. The digits used are
  /// first the decimal digits 0..9, and then the letters 'a'..'z' with
  /// values 10 through 35. Also accepts upper-case letters with the same
  /// values as the lower-case ones.
  ///
  /// If no [radix] is given then it defaults to 10.
  int toInt({int? radix}) => int.parse(this, radix: radix);
  int? toIntOrNull({int? radix}) => int.tryParse(this, radix: radix);
  bool get isInt => toIntOrNull() != null;

  double toDouble() => double.parse(this);
  double? toDoubleOrNull() => double.tryParse(this);
  bool get isDouble => toDoubleOrNull() != null;
}