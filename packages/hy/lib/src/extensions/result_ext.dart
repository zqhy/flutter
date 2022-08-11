import '../result.dart';

extension ResultExt on Result {

  T? dataOrNull<T>() => this is Success
      ? (this as Success).data
      : null;

  Object? errorOrNull() => this is Failure
      ? (this as Failure).error
      : null;

  String? message() => this is Success
      ? (this as Success).message
      : this is Failure
      ? (this as Failure).message
      : null;

  bool get isSuccess  => this is Success;
  bool get isFailure  => this is Failure;
}