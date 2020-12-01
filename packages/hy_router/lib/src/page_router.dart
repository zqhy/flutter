import 'dart:collection';
import 'dart:convert';

import 'package:flutter/widgets.dart';

typedef dynamic CreateAppRoute(Map<dynamic, dynamic> params);
typedef Widget PageBuilder(BuildContext context, dynamic params);

class RouterHandler<RP extends Object> {
  final CreateAppRoute createAppRoute;
  final PageBuilder pageBuilder;

  RouterHandler(this.createAppRoute, this.pageBuilder);
}

String getRouterName<T>() => (T).toString();

class PageRouter {
  static Map<String, RouterHandler> _routerHandler = new HashMap<String,RouterHandler>(
      equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
      hashCode: (a) => a.toLowerCase().hashCode);

  static void register(Map<String, RouterHandler> routerConfig) {
    _routerHandler.addAll(routerConfig);
  }

  static bool contains<T>() => containsName(getRouterName<T>());
  static bool containsName(String routeName) => _routerHandler.containsKey(routeName);

  static PageBuilder getPageBuilder<T>() => getPageBuilderFromName(getRouterName<T>());
  static PageBuilder getPageBuilderFromName(String routeName) => _routerHandler[routeName].pageBuilder;

  //region navigate
  static Future<T> navigatePath<T extends Object>(BuildContext context, String path) {

    final pathInfo = getPathInfo(path);
    final appRoute = pathInfo.appRoute;
    return appRoute == null
        ? Navigator.pushNamed<T>(context, pathInfo.routeName)
        : navigate<T>(context, appRoute);
  }

  static Future<T> navigate<T extends Object>(BuildContext context, Object route) {
    return Navigator.pushNamed<T>(context, route.runtimeType.toString(), arguments: route);
  }
  //endregion

  //region navigateReplacement
  static Future<T> navigateReplacementPath<T extends Object, TO extends Object>(BuildContext context, String path, {TO result}) {

    final pathInfo = getPathInfo(path);
    final appRoute = pathInfo.appRoute;
    return appRoute == null
        ? Navigator.pushReplacementNamed<T, TO>(context, pathInfo.routeName, result: result)
        : navigateReplacement<T, TO>(context, appRoute, result: result);
  }

  static Future<T> navigateReplacement<T extends Object, TO extends Object>(BuildContext context, Object route, {TO result}) {
    return Navigator.pushReplacementNamed<T, TO>(context, route.runtimeType.toString(), arguments: route, result: result);
  }
  //endregion

  //region navigateAndRemoveUntil
  static final RoutePredicate defaultPushNamedAndRemoveUntilPredicate = (check) => false;
  static Future<T> navigatePathAndRemoveUntil<T extends Object>(BuildContext context, String path, {RoutePredicate predicate}) {

    final pathInfo = getPathInfo(path);
    final appRoute = pathInfo.appRoute;
    return appRoute == null
        ? Navigator.pushNamedAndRemoveUntil<T>(context, pathInfo.routeName, predicate ?? defaultPushNamedAndRemoveUntilPredicate)
        : navigateAndRemoveUntil<T>(context, appRoute, predicate: predicate);
  }

  static Future<T> navigateAndRemoveUntil<T extends Object>(BuildContext context, Object route, {RoutePredicate predicate}) {
    return Navigator.pushNamedAndRemoveUntil<T>(context, route.runtimeType.toString(), predicate ?? defaultPushNamedAndRemoveUntilPredicate, arguments: route);
  }
  //endregion

  static PathInfo getPathInfo(String path) {
    var routeName = path;
    Map<dynamic, dynamic> params;
    if (path.contains("?")) {
      var splitParam = path.split("?");
      routeName = splitParam[0];
      params = _parseParams(splitParam[1]);
    }

    final createRouteParams = _routerHandler[routeName]?.createAppRoute;
    if(createRouteParams == null) {
      return PathInfo(routeName, null);
    }

    return PathInfo(routeName, createRouteParams(params));
  }

  static Map<dynamic, dynamic> _parseParams(String paramsString) {
    return paramsString.startsWith("{")
        ? json.decode(paramsString)
        : parseQueryString(paramsString);
  }

  static Map<dynamic, dynamic> parseQueryString(String query) {
    var search = RegExp('([^&=]+)=?([^&]*)');
    var params = Map<dynamic, dynamic>();
    if (query.startsWith('?')) query = query.substring(1);
    decode(String s) => s == null ? null : Uri.decodeComponent(s.replaceAll('+', ' '));
    for (Match match in search.allMatches(query)) {
      var key = decode(match.group(1));
      var value = decode(match.group(2));
      params[key] = value;
    }
    return params;
  }
}

class PathInfo {
  final String routeName;
  final Object appRoute;

  PathInfo(this.routeName, this.appRoute);
}