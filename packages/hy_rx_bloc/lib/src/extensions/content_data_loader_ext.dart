import 'package:rxdart/rxdart.dart';

import 'package:hy/hy.dart';

import '../content_data_loader.dart';

extension ContentLoaderExt<C> on ContentDataLoader<Future<C>> {
  Stream<Progress<Result>> loadBy(Stream<ContentLoaderOperate> trigger) {
    ContentLoaderOperate operate;
    return trigger
        .doOnData((contentLoaderOperate) => operate = contentLoaderOperate)
        .switchMap<Progress<Result>>((t) =>
        Stream.fromFuture(this())
            .map<Result>((value) => Success<C>(value))
            .onErrorReturnWith((error) {
              operate.onError?.also((onError) {
                onError(error);
              });
              return Failure(error);
            })
            .map<Progress<Result>>((result) => Complete(result: result))
            .startWith(InProgress<Result>())
    );
  }
}

class ContentLoaderOperate {
  final void Function(dynamic error) onError;

  ContentLoaderOperate({this.onError});
}