import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:openpay_flutter/model/customer.dart';
import 'package:openpay_flutter/model/payment.dart';
import 'package:openpay_flutter/openpay_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  


  String _merchantId = 'm0mhzzv3qdmwyuahydqq';
  String _privateKey = 'sk_df18c0012da643ee90a2d46de39df1b8';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {

      platformVersion = await OpenpayAPI.deviceSessionId(this._merchantId,this._privateKey);

      Map<String, String> filters = {
        "externalId": "103706956058001336318",
        "offset": "0",
        "limit": "1"
      };

      OpenpayAPI _opp = new OpenpayAPI(_merchantId, _privateKey);
      _opp.customerService.getList(Customer(), filters: filters).then((data){
        print(data);
      }).catchError((error){
        print(error);
      });

     /*  platformVersion = platformVersion.replaceRange(0, 4, "");
      print("is card valid :");
      bool cardValid = await OpenpayAPI.validateCard("111", "4111111111111111");
      print(cardValid);
      print(platformVersion); */

     /*  _card.card_number = "5105105105105100";
      _card.holder_name = "Juan Valdes";
      _card.expiration_year = "21";
      _card.expiration_month = "06";
      _card.cvv2 = "456";
      _card.device_session_id = platformVersion;
      _card.customer_id = "ahht4js7dhkmgjbcfiuh"; */

      /* Map<String, dynamic> customer = <String, dynamic>{
        'name': "jaun",
        'email': "juan@juan.com",
        'last_name': "valde",
        'phone_number': "22222",
      };    
      Payment pp = Payment();
      pp.amount = 5;
      pp.source_id = "kcuu9bu4p8yerwisr30j";
      pp.method = "card";
      pp.description = "test charge";
      pp.device_session_id = platformVersion; */

      // pp.customer = customer;
      // pp.order_id = "oid-00055";

      //OpenpayAPI _opp = new OpenpayAPI(_merchantId, _privateKey);
      //_opp.cardService.createCard(_card);
      //_opp.payService.performPayment("alb9grgcm00uhlyowimf", pp);


    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
