abstract class Result{}

class Success<V> implements Result {
  final V? value;
  final String? message;

  const Success(this.value, {this.message});
}

class Failure<E> implements Result {
  final E? error;
  final String? message;

  const Failure(this.error, {this.message});
}