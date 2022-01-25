extension DurationExt on Duration {
  int get day => inDays;
  int get hour => inHours % 24;
  int get minute => inMinutes % 60;
  int get second => inSeconds % 60;
  int get millisecond => inMilliseconds % 1000;
  int get microsecond => inMicroseconds % 1000;
}