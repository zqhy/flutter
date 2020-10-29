import 'package:rxdart/rxdart.dart';

extension BoolStreamExt on Stream<bool> {
  Stream<bool> and(Subject<bool> other) => Rx.combineLatest2<bool, bool, bool>(this, other, (a, b) => a && b);
  Stream<bool> or(Subject<bool> other) => Rx.combineLatest2<bool, bool, bool>(this, other, (a, b) => a || b);
}