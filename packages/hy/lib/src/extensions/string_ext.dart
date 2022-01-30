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
}