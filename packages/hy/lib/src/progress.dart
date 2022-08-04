abstract class Progress<T> {

}

class InProgress<T> implements Progress<T> {
  InProgress();
}

class Complete<T> implements Progress<T> {
  final T? result;

  Complete([this.result]);
}