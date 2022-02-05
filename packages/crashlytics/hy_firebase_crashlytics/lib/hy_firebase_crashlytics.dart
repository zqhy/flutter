library hy_firebase_crashlytics;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:hy_crashlytics/hy_crashlytics.dart';

class Crashlytics implements ICrashlytics {

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) =>
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);

  @override
  Future<void> crash() async => FirebaseCrashlytics.instance.crash();

  @override
  Future<void> log(String message) => FirebaseCrashlytics.instance.log(message);

  @override
  Future<void> recordError(dynamic exception, StackTrace? stack, {dynamic reason, bool? printDetails, bool fatal = false}) =>
      FirebaseCrashlytics.instance.recordError(exception, stack, reason: reason, printDetails: printDetails, fatal: fatal);

  @override
  Future<void> setUserId(String userId) =>
      FirebaseCrashlytics.instance.setUserIdentifier(userId);

  @override
  Future<void> setCustomKey(String key, Object value) =>
      FirebaseCrashlytics.instance.setCustomKey(key, value);
}