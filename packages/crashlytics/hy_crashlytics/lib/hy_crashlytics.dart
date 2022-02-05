library hy_crashlytics;

abstract class ICrashlytics {
  Future<void> setCrashlyticsCollectionEnabled(bool enabled);

  Future<void> crash();

  Future<void> log(String message);
  Future<void> recordError(dynamic exception, StackTrace? stack,
      {dynamic reason,
        bool? printDetails,
        bool fatal = false});

  Future<void> setUserId(String userId);

  /// The value can only be a type [int], [num], [String] or [bool].
  Future<void> setCustomKey(String key, Object value);
}