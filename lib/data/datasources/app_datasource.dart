import 'package:device_apps/device_apps.dart';
import '../models/app_model.dart';

/// Data source for fetching installed applications
abstract class AppDataSource {
  /// Fetch all installed applications
  Future<List<AppModel>> getInstalledApps();

  /// Launch an application by package name
  Future<void> launchApp(String packageName);

  /// Get app info (opens app settings)
  Future<void> getAppInfo(String packageName);

  /// Uninstall an app
  Future<void> uninstallApp(String packageName);
}

/// Implementation of AppDataSource
class AppDataSourceImpl implements AppDataSource {
  @override
  Future<List<AppModel>> getInstalledApps() async {
    try {
      final apps = await DeviceApps.listInstalledApps(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true,
      );

      return apps.map((app) {
        return AppModel(
          packageName: app.packageName,
          appName: app.appName,
          appIcon: (app as ApplicationWithIcon).icon?.base64,
          installTime: DateTime.now(),
          isSystemApp: app.isSystemApp,
          isFavorite: false,
          isHidden: false,
        );
      }).toList();
    } catch (e) {
      print('Error fetching installed apps: $e');
      return [];
    }
  }

  @override
  Future<void> launchApp(String packageName) async {
    try {
      await DeviceApps.openApp(packageName);
    } catch (e) {
      print('Error launching app: $e');
    }
  }

  @override
  Future<void> getAppInfo(String packageName) async {
    try {
      await DeviceApps.openAppSettings(packageName);
    } catch (e) {
      print('Error opening app info: $e');
    }
  }

  @override
  Future<void> uninstallApp(String packageName) async {
    try {
      await DeviceApps.uninstallApp(packageName);
    } catch (e) {
      print('Error uninstalling app: $e');
    }
  }
}
