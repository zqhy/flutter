abstract class Result{}

class Success<V> implements Result {
  final V value;
  final String? message;

  const Success(this.value, {this.message});
}

class Failure<E> implements Result {
  final String? message;
  final E? error;
  final StackTrace? stackTrace;

  const Failure({this.message, this.error, this.stackTrace});
}