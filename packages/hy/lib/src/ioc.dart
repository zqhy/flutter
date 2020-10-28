import 'container/object_container.dart';

class Ioc {

  static ObjectContainer _container;

  static void setContainer(ObjectContainer container) {
    _container = container;
  }

  static T get<T>({String name}) {
    return _container.get(name: name);
  }

  static T getRequired<T>({String name}) {
    return _container.getRequired(name: name);
  }
}