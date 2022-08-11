abstract class Result<T>{
  T? get data;
}

class Success<T> implements Result<T> {
  final T data;
  final String? message;

  const Success(this.data, [this.message]);
}

class Failure<E> implements Result {
  final String? message;
  final E? error;
  final StackTrace? stackTrace;

  const Failure([this.message, this.error, this.stackTrace]);

  @override
  get data => null;
}