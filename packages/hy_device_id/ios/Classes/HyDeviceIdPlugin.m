#import "HyDeviceIdPlugin.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@implementation HyDeviceIdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"hy_device_id"
            binaryMessenger:[registrar messenger]];
  HyDeviceIdPlugin* instance = [[HyDeviceIdPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getDeviceId" isEqualToString:call.method]) {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"studio.creche.immutable_device_identifier"];
    NSString *key = @"studio.creche.immutable_device_identifier/unique_id";
    NSString *uuid = keychain[key];
    if (uuid == nil || uuid.length < 1) {
      uuid = [NSUUID UUID].UUIDString;
      keychain[key] = uuid;
    }
    result(uuid);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
