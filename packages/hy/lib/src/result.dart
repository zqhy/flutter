abstract class Result<T>{
}

class Success<T> implements Result<T> {
  final T data;
  final String? message;

  const Success(this.data, [this.message]);
}

class Failure<T> implements Result<T> {
  final String? message;
  final Object? error;
  final StackTrace? stackTrace;

  const Failure([this.message, this.error, this.stackTrace]);
}