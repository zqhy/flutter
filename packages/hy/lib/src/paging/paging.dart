class Paging<ITEM> {
  List<ITEM> _items;
  List<ITEM> get items => _items;
  final dynamic nextPage;
  final String? emptyTips;

  Paging(List<ITEM> items, {this.nextPage, this.emptyTips}): _items = items;

  void setItems(List<ITEM> items) {
    _items = items;
  }
}