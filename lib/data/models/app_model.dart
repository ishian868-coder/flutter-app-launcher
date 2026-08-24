/// Model representing an installed application
class AppModel {
  final String packageName;
  final String appName;
  final String? appIcon; // Base64 encoded or null
  final DateTime installTime;
  final bool isSystemApp;
  final bool isFavorite;
  final bool isHidden;

  AppModel({
    required this.packageName,
    required this.appName,
    this.appIcon,
    required this.installTime,
    required this.isSystemApp,
    this.isFavorite = false,
    this.isHidden = false,
  });

  /// Create a copy with modified fields
  AppModel copyWith({
    String? packageName,
    String? appName,
    String? appIcon,
    DateTime? installTime,
    bool? isSystemApp,
    bool? isFavorite,
    bool? isHidden,
  }) {
    return AppModel(
      packageName: packageName ?? this.packageName,
      appName: appName ?? this.appName,
      appIcon: appIcon ?? this.appIcon,
      installTime: installTime ?? this.installTime,
      isSystemApp: isSystemApp ?? this.isSystemApp,
      isFavorite: isFavorite ?? this.isFavorite,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  String toString() => 'AppModel($appName, $packageName)';
}
