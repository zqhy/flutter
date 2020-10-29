import 'package:hy/hy.dart';

import 'rx_content_bloc.dart';
import 'content_data_loader.dart';

class RxContentLoader<C> with IDispose, RxContentBloc<C> {

  final ContentDataLoader<Future<C>> getContent;

  RxContentLoader({this.getContent});

  @override
  Future<C> getContentData() => getContent();
}