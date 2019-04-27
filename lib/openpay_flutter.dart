import 'dart:async';

import 'package:flutter/services.dart';

class OpenpayFlutter {
  static const MethodChannel _channel =
      const MethodChannel('openpay_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

static Future<String> get deviceSessionId async {
    final String version = await _channel.invokeMethod('getDeviceSessionId');
    return version;
  }



  //getDeviceSessionId
}
