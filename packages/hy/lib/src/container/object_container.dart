abstract class ObjectContainer {
  /// return null when there is no service of type
  T get<T>({String name});
  /// throw exception when there is no service of type
  T getRequired<T>({String name});
}