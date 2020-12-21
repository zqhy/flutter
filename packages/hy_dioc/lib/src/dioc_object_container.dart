import 'package:dioc/dioc.dart';
import 'package:hy/hy.dart';

class DiocObjectContainer implements ObjectContainerRegister, ObjectContainer {

  final Container _container = Container();

  initIoc() {
    Ioc.setContainer(this);
  }

  @override
  T get<T>({String name}) => _container.has<T>() ? _container.get(name: name) : null;

  @override
  T getRequired<T>({String name}) => _container.get(name: name);

  @override
  void register<T>(ObjectCreator<T> creator, {String name}) {
    _container.register((c) => creator(this), name: name, defaultMode: InjectMode.create);
  }

  @override
  void registerSingleton<T>(ObjectCreator<T> creator, {String name}) {
    _container.register((c) => creator(this), name: name, defaultMode: InjectMode.singleton);
  }
}