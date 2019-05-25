import 'package:flutter/material.dart';
import 'dart:async';
import 'package:openpay_flutter/model/card.dart' as CreditCard;
import 'package:flutter/services.dart';
import 'package:openpay_flutter/openpay_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  CreditCard.Card _card = new CreditCard.Card();
   String _merchantId = 'ms9mpfws893d5w6hmpaj';
  String _privateKey = 'sk_976bba3e7bc4451da9261e45055ad829';

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
      platformVersion = await OpenpayAPI.deviceSessionId;
      _card.card_number = "5105105105105100";
      _card.holder_name = "Juan Valdes";
      _card.expiration_year = "21";
      _card.expiration_month = "06";
      _card.cvv2 = "456";
      _card.device_session_id = platformVersion;
      _card.customer_id = "ahht4js7dhkmgjbcfiuh";


      OpenpayAPI _opp = new OpenpayAPI(_merchantId, _privateKey);
      _opp.cardService.createCard(_card);

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
