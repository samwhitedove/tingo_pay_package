import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tingo_pay/webView.dart';

class Tingo extends GetxController {
  TextEditingController amount = TextEditingController();

  late String _email;
  late String _firstName;
  late String _lastName;
  String title = "Tingo Pay";
  late String _description;
  final String _quantity = "1";
  String _currency = "NGN";

  static final RxString _merchantKey = "".obs;
  static final RxString _publicKey = "".obs;
  static final RxString _successUrl = "".obs;
  static final RxString _callbackUrl = "".obs;
  static final RxString _failUrl = "".obs;

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  RxBool isLoading = false.obs;
  RxBool deactivateButton = false.obs;

  static init(
      {required String merchantKey,
      required String publicKey,
      required String successUrl,
      required String callbackUrl,
      required String failUrl}) {
    _merchantKey.value = merchantKey;
    _publicKey.value = publicKey;
    _successUrl.value = successUrl;
    _callbackUrl.value = callbackUrl;
    _failUrl.value = failUrl;
  }

  removeFirstCharacter() {
    if (amount.text.startsWith("0")) {
      amount.text = amount.text.substring(1);
    }
  }

  String getTxf(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void makeRquest(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String url = "https://dashboard.tingopay.com/ext_transfer";
    String txf = "${getTxf(7)}_${DateTime.now().millisecondsSinceEpoch}";

    Map<String, dynamic> payload = {
      "merchant_key": _merchantKey.value,
      "public_key": _publicKey.value, 
      "success_url": _successUrl.value, /// example::: "https://your-site.com/success
      "callback_url": _callbackUrl.value, // example:::  "https://your-site.com/callBack",
      "fail_url": _failUrl.value, // / example::: "https://your-site.com/fail",
      "amount": amount.text,
      "email": _email,
      "first_name": _firstName,
      "last_name": _lastName,
      "title": title, //     "
      "description": _description, // 
      "quantity": _quantity, // default::: "1",
      "tx_ref": "TP_$txf",
      "currency": _currency, // default::: "NGN"
    };

    isLoading.value = true;
    deactivateButton.value = true;
    Map<String, String> header = {"Content-Type": "application/json"};
    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(payload), headers: header);
    isLoading.value = false;
    deactivateButton.value = false;
    amount.clear;

    if (response.statusCode == 302) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InAppWebPageViewer(
            url: response.headers['location']!,
          ),
        ),
      );
    }
  }

  void user(
      {required email,
      required firstName,
      required lastName,
      required description,
      String? title,
      String? currency}) {
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _description = description;
    title = title ?? this.title;
    _currency = currency ?? _currency;
  }
}
