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
  final bool isHasMoreContent;
  HasContent(this.content, {this.isHasMoreContent = false,  String? message}) : super(message);
}