import 'object_container.dart';

typedef T ObjectCreator<T>(ObjectContainer container);

abstract class ObjectContainerRegister {
  void register<T>(ObjectCreator<T> creator, {String? name});
  void registerSingleton<T>(ObjectCreator<T> creator, {String? name});
}