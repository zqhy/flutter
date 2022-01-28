import '../empty_state.dart';

extension EmptyStateExtensions on EmptyState {
  bool get isShowEmptyLayout => this is Empty || this is EmptyFailure;
  bool get isShowAllEmptyLayout => this is EmptyLoading || this is Empty || this is EmptyFailure;

  T? contentOrNull<T>() => this is HasContent
      ? (this as HasContent).content
      : null;

  bool? isHasMoreContent() => this is HasContent
      ? (this as HasContent).isHasMoreContent
      : null;
}