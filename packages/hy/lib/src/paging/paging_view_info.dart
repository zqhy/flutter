import '../empty_state.dart';

class PagingViewInfo<ITEM> {
  final EmptyState emptyState;
  final List<ITEM> listItems;
  final bool isHasNext;

  PagingViewInfo(this.emptyState, this.listItems, this.isHasNext);
}