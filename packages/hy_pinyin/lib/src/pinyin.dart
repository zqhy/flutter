import 'package:lpinyin/lpinyin.dart';
import 'package:hy/hy.dart';

class Pinyin implements IPinyin {

  @override
  String getFirstWordPinyin(String str) {
    return PinyinHelper.getFirstWordPinyin(str);
  }

  @override
  String getShortPinyin(String str) {
    return PinyinHelper.getShortPinyin(str);
  }

  @override
  String getPinyin(String str, {String separator = ' '}) {
    return PinyinHelper.getPinyin(str, separator: separator);
  }

  @override
  String getPinyinE(String str, {String separator = " ", String defPinyin = ' '}) {
    return PinyinHelper.getPinyinE(str, separator: separator, defPinyin: defPinyin);
  }
}