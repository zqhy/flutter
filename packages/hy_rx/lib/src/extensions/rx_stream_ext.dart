import 'package:rxdart/rxdart.dart';

extension RxStreamExt<T> on Stream<T> {
  BehaviorSubject<T> toBehaviorSubject() {
    final subject = BehaviorSubject<T>();
    listen(subject.add, onError: subject.addError);
    return subject;
  }

  BehaviorSubject<T> toBehaviorSubjectSeeded(T seedValue, {
    void Function()? onListen,
    void Function()? onCancel,
    bool sync = false,
  }) {
    final subject = BehaviorSubject<T>.seeded(seedValue, onListen: onListen, onCancel: onCancel, sync: sync);
    listen(subject.add, onError: subject.addError);
    return subject;
  }
}