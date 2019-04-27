package com.luju.openpay_flutter;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import mx.openpay.android.Openpay;


/** OpenpayFlutterPlugin */
public class OpenpayFlutterPlugin implements MethodCallHandler {
  /** Plugin registration. */
  private final Activity activity;
  Openpay openpay;

    String _merchantId = "ms9mpfws893d5w6hmpaj";
    String _privateKey = "sk_976bba3e7bc4451da9261e45055ad829";

    private OpenpayFlutterPlugin(Activity activity) {
        this.activity = activity;
    }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "openpay_flutter");
    channel.setMethodCallHandler(new OpenpayFlutterPlugin(registrar.activity()));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android juan " + android.os.Build.VERSION.RELEASE);
    }else if(call.method.equals("getDeviceSessionId")){

        if (openpay == null){
            openpay = new Openpay(_merchantId, _privateKey, false);
        }
        result.success(openpay.getDeviceCollectorDefaultImpl().setup(activity));
      }
    else {
      result.notImplemented();
    }
  }
}
