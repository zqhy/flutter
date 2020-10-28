import 'dart:async';

class EmptyValidator {
  static StreamTransformer<String, String> validateIsEmpty(String field, String tips) =>
      StreamTransformer<String, String>.fromHandlers(handleData: (text, sink){
        if (text.isEmpty) {
          sink.addError("$field$tips");
        } else {
          sink.add(text);
        }
      });
}