import 'package:rxdart/rxdart.dart';

import 'package:hy/hy.dart';

extension PagingLoaderExt<ITEM, C extends Paging<ITEM>> on PagingDataLoader<Future<C>> {
  Stream<Progress<Result>?> loadBy(Stream<PagingLoadOperate> trigger) {
    dynamic nextPage;
    var isNotMore = false;
    PagingLoadOperate? operate;
    List<ITEM> _lastListItems = [];
    return trigger
      .takeWhile((operate) => !isNotMore || operate.type == PagingLoadType.ReLoad)
      .doOnData((pagingLoadOperate) => operate = pagingLoadOperate)
      .map<PagingLoadOption>((operate) => operate.type == PagingLoadType.LoadNext ? PagingLoadOption(nextPage) : PagingLoadOption(null))
      .switchMap((option) =>
        Stream<C>.fromFuture(this(option.nextPage))
            .map<Result>((C paging) {
              nextPage = paging.nextPage;
              isNotMore = nextPage == null;
              if (operate?.type == PagingLoadType.LoadNext) {
                _lastListItems.addAll(paging.items);
              } else {
                _lastListItems = paging.items;
              }
              paging.setItems(_lastListItems);
              return Success<C>(paging);
            })
            .onErrorReturnWith((error, stackTrace) {
              operate?.onError?.also((onError) {
                onError(error, stackTrace);
              });
              return Failure(error: error, stackTrace: stackTrace);
            })
            .map<Progress<Result>>((result) => Complete(result: result))
            .startWith(InProgress<Result>())
    );
  }
}

enum PagingLoadType {
  ReLoad, LoadNext
}

class PagingLoadOperate {
  final PagingLoadType type;
  final void Function(Object error, StackTrace stackTrace)? onError;

  PagingLoadOperate(this.type, {this.onError});
}

class PagingLoadOption {
  final dynamic nextPage;

  const PagingLoadOption(this.nextPage);
}