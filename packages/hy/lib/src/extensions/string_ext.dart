import 'dynamic_ext.dart';

extension StringExt on String? {
  String? get notEmpty => this.isNotEmpty == true ? this : null;
  String? get notBlank => isNullOrBlank ? null : this;
}