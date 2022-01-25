import '../empty_state.dart';

extension EmptyStateExtensions on EmptyState {
  bool get isShowEmptyLayout => this is Empty || this is EmptyFailure;
  bool get isShowAllEmptyLayout => this is EmptyLoading || this is Empty || this is EmptyFailure;
}