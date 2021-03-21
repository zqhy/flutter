import 'package:flutter/services.dart';

class NumberRangeTextInputFormatter extends TextInputFormatter {

  final int? _min;
  final int? _max;

  NumberRangeTextInputFormatter(this._min, this._max);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.isNotEmpty == true) {
      final value = int.tryParse(newValue.text);
      if (value == null) {
        return TextEditingValue();
      }

      final min = _min;
      final max = _max;

      if (min != null && value < min) {
        return TextEditingValue(
          text: min.toString(),
          selection: TextSelection.fromPosition(TextPosition(offset: min.toString().length))
        );
      }
      if (max != null && value > max) {
        return TextEditingValue(
          text: max.toString(),
          selection: TextSelection.fromPosition(TextPosition(offset: max.toString().length))
        );
      }
      return newValue;
    } else {
      return TextEditingValue();
    }
  }
}