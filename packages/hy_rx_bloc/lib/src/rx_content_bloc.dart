import 'package:rxdart/rxdart.dart';

import 'package:hy/hy.dart';
import 'package:hy_rx/hy_rx.dart';

import 'extensions/content_data_loader_ext.dart';

mixin RxContentBloc<C> on IDispose {
  Future<C> getContentData();

  final _contentTrigger = BehaviorSubject<ContentLoaderOperate>();

  Stream<Progress<Result>?>? _contentLoad;
  Stream<Progress<Result>?> get contentLoad {
    _contentLoad ??= getContentData.loadBy(_contentTrigger.stream).share().startWith(null);
    return _contentLoad!;
  }

  Stream<Progress?> get contentProgress => contentLoad.distinct();

  BehaviorSubject<C?>? _content;
  BehaviorSubject<C?> get content {
    _content ??= contentLoad
        .flatMap<C?>((progress) {
          final pagingContent = progress?.contentOrNull();
          return pagingContent == null ? Stream.empty() : Stream.value(pagingContent);
        })
        .toBehaviorSubjectSeeded(null);
    return _content!;
  }
  C? get currentContent => content.value;

  BehaviorSubject<EmptyState>? _contentEmptyState;
  BehaviorSubject<EmptyState> get contentEmptyState {
    _contentEmptyState ??= Rx.combineLatest2<Progress<Result>?, C?, EmptyState>(
        contentLoad, content, (progress, content) {
      if (content == null || ((content is Iterable) && content.isEmpty)) {
        if (progress is Complete) {
          final result = (progress as Complete).result;
          if (result is Success) {
            return Empty();
          } else {
            final failure = result as Failure;
            return EmptyFailure(error: failure.error, message: failure.message);
          }
        } else {
          return EmptyLoading();
        }
      } else {
        return HasContent(content);
      }
    }).distinct().toBehaviorSubject();
    return _contentEmptyState!;
  }

  Future<void> load({void onError(dynamic error)?}) async {
    _contentTrigger.add(ContentLoaderOperate(onError: onError));
    await contentProgress.firstWhere((progress) => progress is Complete);
  }

  @override
  void dispose() {
    _contentTrigger.close();
    _content?.close();
    _contentEmptyState?.close();
  }
}