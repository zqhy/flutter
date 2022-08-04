import 'package:rxdart/rxdart.dart';

import 'package:hy/hy.dart';

import '../content_data_loader.dart';

extension ContentLoaderExt<C> on ContentDataLoader<Future<C>> {
  Stream<Progress<Result>?> loadBy(Stream<ContentLoaderOperate> trigger) {
    ContentLoaderOperate? operate;
    return trigger
        .doOnData((contentLoaderOperate) => operate = contentLoaderOperate)
        .switchMap<Progress<Result>>((t) =>
        Stream.fromFuture(this())
            .map<Result>((value) => Success<C>(value))
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

class ContentLoaderOperate {
  final void Function(Object error, StackTrace stackTrace)? onError;

  ContentLoaderOperate({this.onError});
}