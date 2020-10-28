import '../result.dart';

extension ResultExt on Result {

  V valueOrNull<V>() => this is Success
      ? (this as Success).value
      : null;

  E errorOrNull<E>() => this is Failure
      ? (this as Failure).error
      : null;

  String message() => this is Success
      ? (this as Success).message
      : this is Failure
      ? (this as Failure).message
      : null;
}

extension ResultNullExt on Result {
  bool get isSuccess  => this != null && this is Success;
  bool get isFailure  => this != null && this is Failure;
}