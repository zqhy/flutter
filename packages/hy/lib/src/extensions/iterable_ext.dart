extension IterableExt<E> on Iterable<E> {
  Iterable<R> select<R>(R block(int index, E element)) {
    int count = 0;
    return [
      for(E element in this)
        block(count++, element)
    ];
  }
}