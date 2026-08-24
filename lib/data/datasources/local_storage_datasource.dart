import 'package:hive_flutter/hive_flutter.dart';

/// Local storage data source for favorites and hidden apps
abstract class LocalStorageDataSource {
  /// Get all favorite app package names
  Future<List<String>> getFavorites();

  /// Add app to favorites
  Future<void> addFavorite(String packageName);

  /// Remove app from favorites
  Future<void> removeFavorite(String packageName);

  /// Get all hidden app package names
  Future<List<String>> getHiddenApps();

  /// Add app to hidden list
  Future<void> hideApp(String packageName);

  /// Show hidden app
  Future<void> showApp(String packageName);
}

/// Implementation using Hive local storage
class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  static const String _favoritesBox = 'favorites';
  static const String _hiddenAppsBox = 'hidden_apps';
  static const String _themeBox = 'theme_settings';

  /// Initialize Hive boxes
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_favoritesBox);
    await Hive.openBox(_hiddenAppsBox);
    await Hive.openBox(_themeBox);
  }

  @override
  Future<List<String>> getFavorites() async {
    final box = Hive.box(_favoritesBox);
    return List<String>.from(box.values as List);
  }

  @override
  Future<void> addFavorite(String packageName) async {
    final box = Hive.box(_favoritesBox);
    if (!box.values.contains(packageName)) {
      await box.add(packageName);
    }
  }

  @override
  Future<void> removeFavorite(String packageName) async {
    final box = Hive.box(_favoritesBox);
    final keys = box.keys.where((key) => box.get(key) == packageName);
    for (var key in keys) {
      await box.delete(key);
    }
  }

  @override
  Future<List<String>> getHiddenApps() async {
    final box = Hive.box(_hiddenAppsBox);
    return List<String>.from(box.values as List);
  }

  @override
  Future<void> hideApp(String packageName) async {
    final box = Hive.box(_hiddenAppsBox);
    if (!box.values.contains(packageName)) {
      await box.add(packageName);
    }
  }

  @override
  Future<void> showApp(String packageName) async {
    final box = Hive.box(_hiddenAppsBox);
    final keys = box.keys.where((key) => box.get(key) == packageName);
    for (var key in keys) {
      await box.delete(key);
    }
  }
}
