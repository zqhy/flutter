import 'package:hy/hy.dart';
import 'package:injector/injector.dart';

class InjectorObjectContainer implements ObjectContainerRegister, ObjectContainer {

  final _injector = Injector.appInstance;

  initIoc() {
    Ioc.setContainer(this);
  }

  @override
  T? get<T>({String? name}) => _injector.exists<T>(dependencyName: name ?? "") ? _injector.get<T>(dependencyName: name ?? "") : null;

  @override
  T getRequired<T>({String? name}) => _injector.get<T>(dependencyName: name ?? "");

  @override
  void register<T>(ObjectCreator<T> creator, {String? name}) {
    _injector.registerDependency<T>(() => creator(this), dependencyName: name ?? "");
  }

  @override
  void registerSingleton<T>(ObjectCreator<T> creator, {String? name}) {
    _injector.registerSingleton<T>(() => creator(this), dependencyName: name ?? "");
  }
}