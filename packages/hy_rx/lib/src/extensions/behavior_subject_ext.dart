import 'dart:async';

import 'package:rxdart/rxdart.dart';

extension BehaviorSubjectExt on BehaviorSubject<int> {

  static StreamSubscription _countdownSubscription;
  void countdown(int seconds) {
    _countdownSubscription?.cancel();
    _countdownSubscription = Stream.periodic(Duration(seconds: 1), (x) => seconds - x - 1).takeWhile((ticks) => ticks >= 0).startWith(seconds).listen((ticks) {
      if (isClosed) {
        _countdownSubscription?.cancel();
      } else {
        add(ticks);
      }
    }, onError: (error) => _countdownSubscription?.cancel(),
        onDone: () => _countdownSubscription?.cancel());
  }
}