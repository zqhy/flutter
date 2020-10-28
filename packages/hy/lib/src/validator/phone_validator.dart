import 'dart:async';

const String _kPhoneRule = r"^[0-9]*$";

class PhoneValidator {
//  final StreamTransformer<String,String> validatePhone = StreamTransformer<String,String>.fromHandlers(handleData: (phone, sink){
//    if (phone == null || phone.isEmpty) {
//      sink.addError('手机号码不能为空');
//      return;
//    }
//
//    if (phone.length != 11) {
//      sink.addError('请输入11位的手机号码');
//      return;
//    }
//
//    final RegExp emailExp = new RegExp(_kPhoneRule);
//    if (!emailExp.hasMatch(phone)){
//      sink.addError('请输入正确的手机号码');
//    } else {
//      sink.add(phone);
//    }
//  });

  final StreamTransformer<String,bool> isPhoneValidated = StreamTransformer<String,bool>.fromHandlers(handleData: (phone, sink){
    if (phone.isEmpty) {
      sink.add(false);
      return;
    }

    if (phone.length != 11) {
      sink.add(false);
      return;
    }

    final RegExp emailExp = new RegExp(_kPhoneRule);
    if (!emailExp.hasMatch(phone)){
      sink.add(false);
    } else {
      sink.add(true);
    }
  });
}