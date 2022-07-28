import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:ponmo/service/user.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;

String backendUrl = 'https://ponmo.herokuapp.com';
String paystackPublicKey = 'pk_test_4bfe6c8556d928e775f7b16cd6a73732127811fa';
const String appName = 'ponmo';

class Payment extends StatefulWidget {
  final CustomInfo customInfo;

  const Payment({Key key, this.customInfo}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState(this.customInfo);
}

class _PaymentState extends State<Payment> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  //int amount = 100;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  String expiryMonth;
  final CustomInfo customInfo;
  bool _inProgress = false;
  //final _formKey = GlobalKey<FormState>();

  _PaymentState(this.customInfo);
  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: (Text("Customer details ")),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: Container(
        child: SafeArea(
          child: Form(
            //key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      padding:
                          EdgeInsets.only(left: 20, right: 20.0, bottom: 5),
                      child: SizedBox(
                        height: 40,
                      ),
                    )),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),
                          height: 40.0,
                          child: Material(
                            shadowColor: Colors.grey,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            elevation: 0.0,
                            child: GestureDetector(
                              child: Center(
                                  child: Text(
                                "#${customInfo.amount}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textScaleFactor: 1.2,
                              )),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          )),
                    )
                  ],
                ),
                CreditCardWidget(
                  height: 155,
                  width: 300,
                  cardBgColor: Colors.black87,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: CreditCardForm(
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                  ),
                ),
                Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: Colors.green,
                      primaryColorLight: Colors.white,
                      primaryColorDark: Colors.cyanAccent,
                      textTheme: Theme.of(context).textTheme.copyWith(
                            bodyText2: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                    ),
                    child: Builder(builder: (context) {
                      return _inProgress
                          ? new Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Platform.isIOS
                                  ? new CupertinoActivityIndicator()
                                  : new CircularProgressIndicator(),
                            )
                          : _getPlatformButton(
                              'CHECKOUT', () => _handleCheckout(context));
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Widget _getPlatformButton(String string, Function() function) {
    Widget widget;
    widget = Container(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
        height: 40.0,
        child: Material(
          shadowColor: Colors.grey,
          color: Colors.deepOrange[500],
          borderRadius: BorderRadius.circular(20.0),
          elevation: 0.0,
          child: GestureDetector(
              child: Center(
                  child: Text(
                string,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                textScaleFactor: 1.2,
              )),
              onTap: function),
        ));
    return widget;
  }

  _handleCheckout(BuildContext context) async {
    setState(() => _inProgress = true);
    // _formKey.currentState.save();
    Charge charge = Charge()
      ..amount = int.parse(customInfo.amount) * 100 // In base currency
      ..email = customInfo.email
      ..card = _getCardFromUI();

    charge.reference = _getReference();

    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      setState(() => _inProgress = false);
      _updateStatus(response.reference, '$response');
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("Check console for error");
      rethrow;
    }
    // _chargeCard(charge);
  }

  _chargeCard(Charge charge) {
    handleBeforeValidate(Transaction transaction) {
      _updateStatus(transaction.reference, 'validating...');
    }

    handleOnError(Object e, Transaction transaction) {
      if (transaction.reference != null) {
        _verifyOnServer(transaction.reference);
      } else {
        setState(() => _inProgress = false);
        _updateStatus(transaction.reference, e.toString());
      }
    }

    handleOnSuccess(Transaction transaction) {
      _verifyOnServer(transaction.reference);
    }

    PaystackPlugin.chargeCard(context,
        charge: charge,
        beforeValidate: (transaction) => handleBeforeValidate(transaction),
        onSuccess: (transaction) => handleOnSuccess(transaction),
        onError: (error, transaction) => handleOnError(error, transaction));
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}'
        "\n Username: ${customInfo.name}    \n  address: ${customInfo.address}"
        "   \n  PhoneNumber: ${customInfo.phoneNumber}   \n Cart:    thick: ${customInfo.thick},  Round: ${customInfo.round},   Normal: ${customInfo.normal} ";
  }

  PaymentCard _getCardFromUI() {
    var list = expiryDate.split("/");

    return PaymentCard(
      //change to cardNumber
      number: cardHolderName.replaceAll(RegExp(r"\s+\b|\b\s"), ""),
      cvc: cvvCode,
      expiryMonth: int.parse(list[0]),
      expiryYear: int.parse(list[1]),
    );
  }

  void _verifyOnServer(String reference) async {
    _updateStatus(reference, 'Verifying...');
    String url = '$backendUrl/verify/$reference';
    try {
      http.Response response = await http.get(url);
      var body = response.body;
      _updateStatus(reference, body);
    } catch (e) {
      _updateStatus(
          reference,
          'There was a problem verifying %s on the backend: '
          '$reference $e');
    }
    setState(() => _inProgress = false);
  }

  _updateStatus(String reference, String message) {
    _showMessage('Reference: $reference \n\ Response: $message',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
    ));
  }
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "CO",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
