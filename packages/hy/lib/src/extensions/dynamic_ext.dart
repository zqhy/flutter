extension DynamicExt on dynamic {

  bool get isNullOrEmpty {
    if (this == null) return true;
    if (this is String || this is List || this is Map ||
        this is Set || this is Iterable) {
      return this.isEmpty;
    } else {
      return this.toString() == 'null' || this.toString().isEmpty;
    }
  }

  bool get isNotEmpty => isNullOrEmpty == false;

  bool get isNullOrBlank {
    if (this == null) return true;
    switch (this.runtimeType) {
      case String:
        return this.trim().isEmpty;
      case List:
      case Map:
      case Set:
      case Iterable:
        return this.isEmpty;
      default:
        return this.toString() == 'null' || this.toString().trim().isEmpty;
    }
  }
}