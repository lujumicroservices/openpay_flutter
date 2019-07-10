package com.luju.openpay_flutter;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import mx.openpay.android.Openpay;
import mx.openpay.android.validation.CardValidator;


/** OpenpayFlutterPlugin */
public class OpenpayFlutterPlugin implements MethodCallHandler {
  /** Plugin registration. */
  private final Activity activity;
  Openpay openpay;


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

        String _merchantId = call.argument("_merchantId");
        String _privateKey = call.argument("_privateKey");

        if (openpay == null){
            openpay = new Openpay(_merchantId, _privateKey, false);
        }
        String sessionId = openpay.getDeviceCollectorDefaultImpl().setup(activity);
        if (sessionId.length() > 4){
          sessionId = sessionId.substring(4,sessionId.length());
        }
        result.success(sessionId);
    }
    else if(call.method.equals("validateCardCVV")){
          String cardNumber = call.argument("cardNumber");
          String cvv = call.argument("cvv");


        //result.success(true);
          try{
              result.success(CardValidator.validateCVV(cvv, cardNumber));
          }catch (Exception ex){
              result.success(false);
          }

    }
    else {
      result.notImplemented();
    }
  }
}
