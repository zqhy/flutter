import '../progress.dart';
import '../result.dart';
import 'result_ext.dart';

extension ProgressExt on Progress {

  T resultOrNull<T>() => this is Complete
      ? (this as Complete).result
      : null;

  V contentOrNull<V>() {
    return resultOrNull<Result>()?.valueOrNull<V>();
  }
}

extension ProgressNullExt on Progress {
  bool get isInProgress  => this != null && this is InProgress;
  bool get isComplete  => this != null && this is Complete;
}