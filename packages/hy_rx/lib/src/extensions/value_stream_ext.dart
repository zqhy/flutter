import 'package:rxdart/rxdart.dart';

extension ValueStreamExt<T> on ValueStream<T> {
  BehaviorSubject<T> toBehaviorSubject() {
    final subject = hasValue ? BehaviorSubject<T>.seeded(value) : BehaviorSubject<T>();
    listen(subject.add, onError: subject.addError);
    return subject;
  }
}