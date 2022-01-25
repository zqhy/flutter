abstract class IPinyin {
  String getFirstWordPinyin(String str);
  String getShortPinyin(String str);
  String getPinyin(String str, {String separator = ' '});
  String getPinyinE(String str, {String separator = " ", String defPinyin = ' '});
}