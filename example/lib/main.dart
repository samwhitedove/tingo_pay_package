import 'package:flutter/material.dart';
import 'package:tingo_pay/tingo_controller.dart';
import 'package:tingo_pay/tingo_pay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.yellow,
      title: 'TingoPay Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var init;
  @override
  void initState() {
    init = Tingo.init(
      merchantKey: "yqELaZtj9E9ombt9",
      publicKey: "PUB-gHZo9tIpYxtlFmowDmVg8w59v7h8zVh2",
      successUrl: "https://tingopay.com/success-payment",
      callbackUrl: "https://tingopay.com/call-back",
      failUrl: "https://tingopay.com/failed-payment",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TingoGateWay(
      email: "email@email.com",
      description: "Description",
      firstName: "John",
      lastName: "Doe",
    );
  }
}
