#import "OpenpayFlutterPlugin.h"
#import <openpay_flutter/openpay_flutter-Swift.h>

@implementation OpenpayFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpenpayFlutterPlugin registerWithRegistrar:registrar];
}
@end
