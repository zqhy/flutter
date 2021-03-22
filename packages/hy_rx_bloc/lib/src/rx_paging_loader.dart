import 'package:hy/hy.dart';

import 'rx_paging_bloc.dart';

class RxPagingLoader<ITEM, C extends Paging<ITEM>> with IDispose, RxPagingBloc<ITEM, C> {

  final PagingDataLoader<Future<C>> getPaging;

  RxPagingLoader({required this.getPaging});

  @override
  Future<C> getPagingData(dynamic nextPage) => getPaging(nextPage);
}