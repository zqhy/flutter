import 'package:rxdart/rxdart.dart';

import 'package:hy/hy.dart';
import 'package:hy_rx/hy_rx.dart';

import 'extensions/paging_data_loader_ext.dart';

mixin RxPagingBloc<ITEM, C extends Paging<ITEM>> on IDispose {
  Future<C> getPagingData(dynamic nextPage);

  final _pagingTrigger = BehaviorSubject<PagingLoadOperate>();

  Stream<Progress<Result>?>? _pagingLoad;
  Stream<Progress<Result>?> get pagingLoad {
    _pagingLoad ??= getPagingData.loadBy(_pagingTrigger.stream).share().startWith(null);
    return _pagingLoad!;
  }

  Stream<Progress?> get pagingProgress => pagingLoad.distinct();

  Stream<C> get paging => pagingLoad
      .flatMap<C>((progress) {
        final paging = progress?.contentOrNull();
        return paging == null ? Stream.empty() : Stream.value(paging);
      });

  BehaviorSubject<List<ITEM>?>? _listItems;
  BehaviorSubject<List<ITEM>?> get listItems {
    _listItems ??= pagingLoad
        .flatMap<List<ITEM>>((progress) {
          final paging = progress?.contentOrNull();
          return paging == null ? Stream.empty() : Stream.value(paging.items);
        })
        .toBehaviorSubjectSeeded([]);
    return _listItems!;
  }
  List<ITEM>? get currentListItems => listItems.value;

  BehaviorSubject<EmptyState>? _pagingEmptyState;
  BehaviorSubject<EmptyState> get pagingEmptyState {
    _pagingEmptyState ??= Rx.combineLatest2<Progress<Result>?, List<ITEM>?, EmptyState>(
        pagingLoad, listItems, (progress, listItems) {
      if (listItems == null || listItems.isEmpty) {
        if (progress is Complete) {
          final result = (progress as Complete).result;
          if (result is Success) {
            return Empty(result.data.emptyTips);
          } else {
            final failure = result as Failure;
            return EmptyFailure(failure.message, failure.error);
          }
        } else {
          return EmptyLoading();
        }
      } else {
        return HasContent(listItems);
      }
    }).distinct().toBehaviorSubject();
    return _pagingEmptyState!;
  }

  Stream<bool> get isHasNext => paging
      .map((paging) => paging.nextPage != null)
      .startWith(false);

  Stream<PagingViewInfo<ITEM>> get pagingView => Rx.combineLatest3<EmptyState, List<ITEM>?, bool, PagingViewInfo<ITEM>>(
    pagingEmptyState, listItems, isHasNext, (emptyState, listItems, isHasNext) => PagingViewInfo(emptyState, listItems, isHasNext)
  ).distinct();

  Future<void> reload({void onError(Object error, StackTrace stackTrace)?}) async {
    _pagingTrigger.add(PagingLoadOperate(PagingLoadType.ReLoad, onError: onError));
    await pagingProgress.firstWhere((progress) => progress is Complete);

  }

  Future<void> loadNext({void onError(Object error, StackTrace stackTrace)?}) async {
    _pagingTrigger.add(PagingLoadOperate(PagingLoadType.LoadNext, onError: onError));
    await pagingProgress.firstWhere((progress) => progress is Complete);
  }

  @override
  void dispose() {
    _pagingTrigger.close();
    _listItems?.close();
    _pagingEmptyState?.close();
  }
}