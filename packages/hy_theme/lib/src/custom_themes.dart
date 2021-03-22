import 'package:flutter/material.dart';

import 'package:list_ext/list_ext.dart';

import 'custom_theme.dart';
import 'storage_by_type.dart';

/// Storage for custom themes data.
class CustomThemes extends InheritedWidget {
  /// Obtains the nearest CustomThemes.
  static CustomThemes? _of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomThemes>();
  }

  /// Obtains the theme data of given type from the nearest storage.
  ///
  /// If [CustomThemes] storage is not found than returns `null`.
  static T? of<T extends CustomThemeData>(BuildContext context) {
    final customThemes = _of(context);
    if (customThemes == null) {
      return null;
    }
    final ThemeMode mode = customThemes.themeMode ?? ThemeMode.system;
    final Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
    T? theme;
    if (mode == ThemeMode.dark || (mode == ThemeMode.system && platformBrightness == Brightness.dark)) {
      theme = customThemes.darkThemesStorageByType.get<T>();
    }
    return theme == null
        ? customThemes.themesStorageByType.get<T>()
        : theme;
  }

  final ThemeMode? themeMode;

  /// List of custom themes data.
  final List<CustomThemeData> themes;

  final List<CustomThemeData>? darkThemes;

  final StorageByTypeImpl themesStorageByType = StorageByTypeImpl();
  final StorageByTypeImpl darkThemesStorageByType = StorageByTypeImpl();

  CustomThemes({
    Key? key,
    required this.themes,
    this.darkThemes,
    this.themeMode,
    required Widget child,
  })  : super(key: key, child: child) {
    themesStorageByType.setData(themes, recursive: true);

    final thisDarkThemes = darkThemes;
    if (thisDarkThemes != null && thisDarkThemes.length > 0) {
      darkThemesStorageByType.setData(thisDarkThemes, recursive: true);
    }
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    if (oldWidget is CustomThemes)
      return !oldWidget.themes.isUnorderedEquivalent(themes);
    return true;
  }
}
