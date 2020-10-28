#import "HyChannelInfoPlugin.h"

@implementation HyChannelInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"hy_channel_info"
            binaryMessenger:[registrar messenger]];
  HyChannelInfoPlugin* instance = [[HyChannelInfoPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getChannelInfo" isEqualToString:call.method]) {
    result([[NSBundle mainBundle] objectForInfoDictionaryKey:@"channel_info"]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
