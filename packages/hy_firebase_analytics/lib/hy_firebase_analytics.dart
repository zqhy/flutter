library hy_firebase_analytics;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hy_analytics/hy_analytics.dart';

class AppFirebaseAnalytics implements IAppAnalytics {

  final FirebaseAnalytics _firebaseAnalytics;

  AppFirebaseAnalytics(this._firebaseAnalytics);

  @override
  Future<void> logAddPaymentInfo() =>
      _firebaseAnalytics.logAddPaymentInfo();

  @override
  Future<void> logEvent({required String name, Map<String, dynamic>? parameters}) =>
      _firebaseAnalytics.logEvent(name: name, parameters: parameters);

  @override
  Future<void> logJoinGroup({required String groupId}) =>
      _firebaseAnalytics.logJoinGroup(groupId: groupId);

  @override
  Future<void> logEcommercePurchase({String? currency, double? value, String? transactionId}) =>
      _firebaseAnalytics.logEcommercePurchase(currency: currency, value: value, transactionId: transactionId);

  @override
  Future<void> logPurchaseRefund({String? currency, double? value, String? transactionId}) =>
      _firebaseAnalytics.logPurchaseRefund(currency: currency, value: value, transactionId: transactionId);

  @override
  Future<void> logSearch({required String searchTerm}) =>
      _firebaseAnalytics.logSearch(searchTerm: searchTerm);

  @override
  Future<void> logSelectContent({required String contentType, required String itemId}) =>
      _firebaseAnalytics.logSelectContent(contentType: contentType, itemId: itemId);

  @override
  Future<void> logShare({required String contentType, required String itemId, required String method}) =>
      _firebaseAnalytics.logShare(contentType: contentType, itemId: itemId, method: method);

  @override
  Future<void> logSignUp({required String signUpMethod}) =>
      _firebaseAnalytics.logSignUp(signUpMethod: signUpMethod);

  @override
  Future<void> logSpendVirtualCurrency({required String itemName, required String virtualCurrencyName, required num value}) =>
      _firebaseAnalytics.logSpendVirtualCurrency(itemName: itemName, virtualCurrencyName: virtualCurrencyName, value: value);

  @override
  Future<void> logViewItem({required String itemId, required String itemName, required String itemCategory}) =>
      _firebaseAnalytics.logViewItem(itemId: itemId, itemName: itemName, itemCategory: itemCategory);

  @override
  Future<void> logViewItemList({required String itemCategory}) =>
      _firebaseAnalytics.logViewItemList(itemCategory: itemCategory);

  @override
  Future<void> resetAnalyticsData() =>
      _firebaseAnalytics.resetAnalyticsData();

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) =>
      _firebaseAnalytics.setAnalyticsCollectionEnabled(enabled);

  @override
  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'}) =>
      _firebaseAnalytics.setCurrentScreen(screenName: screenName, screenClassOverride: screenClassOverride);

  @override
  Future<void> setUserId(String? id) =>
      _firebaseAnalytics.setUserId(id);

  @override
  Future<void> setUserProperty({required String name, required String? value}) =>
      _firebaseAnalytics.setUserProperty(name: name, value: value);

  @override
  Future<void> logLogin({String? loginMethod}) => _firebaseAnalytics.logLogin(loginMethod: loginMethod);
}
