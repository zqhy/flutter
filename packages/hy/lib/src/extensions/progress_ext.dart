import '../progress.dart';
import '../result.dart';
import 'result_ext.dart';

extension ProgressExt on Progress {

  T? resultOrNull<T>() => this is Complete
      ? (this as Complete).result
      : null;

  V? contentOrNull<V>() {
    return resultOrNull<Result>()?.dataOrNull<V>();
  }

  bool get isInProgress  => this is InProgress;
  bool get isComplete  => this is Complete;
}