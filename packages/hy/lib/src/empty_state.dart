abstract class EmptyState {
  final String? message;

  EmptyState(this.message);
}

class EmptyLoading extends EmptyState {

  EmptyLoading({String? message}) : super(message);
}

class Empty extends EmptyState {
  Empty({String? message}) : super(message);
}

class EmptyFailure extends EmptyState {
  final dynamic error;
  EmptyFailure({this.error, String? message}) : super(message);
}

class HasContent<T> extends EmptyState {
  final T? content;
  HasContent(this.content, {String? message}) : super(message);
}