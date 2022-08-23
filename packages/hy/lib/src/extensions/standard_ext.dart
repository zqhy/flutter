extension StandardExt<T> on T {
  T also(void block(T self)) {
    block(this);
    return this;
  }

  R let<R>(R block(T self)){
    return block(this);
  }
}

R run<R>(R operation()) {
  return operation();
}