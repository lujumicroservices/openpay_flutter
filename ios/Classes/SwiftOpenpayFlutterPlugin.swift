import Flutter
import UIKit
import Openpay
import CardValidator


public class SwiftOpenpayFlutterPlugin: NSObject, FlutterPlugin {

   let MERCHANT_ID = "ms9mpfws893d5w6hmpaj"
   let API_KEY = "sk_976bba3e7bc4451da9261e45055ad829"

   var sessionloaded:Bool = false;
   var sessionId:String = "";


  var openpay : Openpay!

  

func successSessionID(sessionID: String) {
       sessionId = sessionID
       sessionloaded = true
}

func failSessionID(error: NSError) {
        sessionId = ""
       sessionloaded = true
}

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "openpay_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftOpenpayFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    sessionloaded = false;
    if (openpay == nil){
      openpay = Openpay(withMerchantId: MERCHANT_ID, andApiKey: API_KEY, isProductionMode: false, isDebug: false)
    }
        
    if (call.method.isEqual("getPlatformVersion")) {
       result("iOSes " + UIDevice.current.systemVersion)
     }else if(call.method.isEqual("getDeviceSessionId")){     
        openpay.createDeviceSessionId(successFunction: successSessionID, failureFunction: failSessionID)

        while(!sessionloaded){
          sleep(1)
        }

        
        result(sessionId)

        
    }
    else if(call.method.isEqual("validateCardCVV")){
        
    
        var cardNumber:String = call.argument("cardNumber")
         var cvv:String = call.argument("cvv")
        
        var isValid:Bool = CardValidator.validateCVV(cvv, cardNumber)
        result(true);
    }

    
  }

}
