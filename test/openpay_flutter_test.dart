import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openpay_flutter/openpay_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('openpay_flutter');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await OpenpayAPI.platformVersion, '42');
  });
}
