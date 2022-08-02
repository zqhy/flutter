library hy_analytics;

abstract class IAppAnalytics {
  Future<void> setAnalyticsCollectionEnabled(bool enabled);
  Future<void> resetAnalyticsData();

  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'});
  Future<void> logEvent({required String name, Map<String, dynamic>? parameters});
  Future<void> logJoinGroup({required String groupId,});
  Future<void> logSearch({required String searchTerm,});
  Future<void> logSelectContent({required String contentType, required String itemId,});
  Future<void> logShare({required String contentType, required String itemId, required String method});
  /// 消费虚拟货币
  Future<void> logSpendVirtualCurrency({required String itemName, required String virtualCurrencyName, required num value,});
  /// 添加付费信息
  Future<void> logAddPaymentInfo();
  /// 消费
  Future<void> logEcommercePurchase({String? currency, double? value, String? transactionId,});
  /// 退款
  Future<void> logPurchaseRefund({String? currency, double? value, String? transactionId,});

  Future<void> setUserId(String? id);
  Future<void> setUserProperty({required String name, required String? value});

  Future<void> logSignUp({required String signUpMethod});
  Future<void> logLogin({String? loginMethod});
}