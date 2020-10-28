extension DateTimeExt on DateTime {
  bool isToday(DateTime now) {
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool isYesterday(DateTime now) {
    final yesterday = now.subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }
}