import 'package:rxdart/rxdart.dart';

extension ValueStreamExt<T> on ValueStream<T> {
  BehaviorSubject<T> toBehaviorSubject() {
    final currentValue = value;
    final subject = currentValue != null ? BehaviorSubject<T>.seeded(currentValue) : BehaviorSubject<T>();
    listen(subject.add, onError: subject.addError);
    return subject;
  }
}