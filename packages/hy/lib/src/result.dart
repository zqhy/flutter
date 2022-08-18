abstract class Result<T>{
}

class Success<T> implements Result<T> {
  final T data;
  final String? message;

  const Success(this.data, [this.message]);

  @override
  String toString() => "Success{data: $data, message: $message}";
}

class SuccessVoid extends Success<void> {
  SuccessVoid([String? message]) : super(Null, message);
}

class Failure<T> implements Result<T> {
  final String? message;
  final Object? error;
  final StackTrace? stackTrace;

  const Failure([this.message, this.error, this.stackTrace]);

  Failure.from(Failure failure): this(failure.message, failure.error, failure.stackTrace);

  @override
  String toString() => "Failure{message: $message, error: $error, stackTrace: $stackTrace}";
}