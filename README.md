<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Features
```
VERSION: 0.0.2
```
## Features
 Payment Services

## Getting started

Package for easy use of tingo payment gateway for flutter developers.

## Usage
//intialize the tingo payment in your instate 
//Use the tingo gateway widget inside your app

```
import 'package:flutter/material.dart';
import 'package:tingo_pay/tingo_controller.dart';
import 'package:tingo_pay/tingo_pay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  @override
  void initState() {
    //intialize Here
    Tingo.init(
      merchantKey: "yqELaZtj9Exxxxx",
      publicKey: "PUB-gHZo9tIpYxtlFmowxxxxxxxxxxxxxxxxx",
      successUrl: "https://your-site.com/xxxx",
      callbackUrl: "https://your-site.com/xxxxx",
      failUrl: "https://your-site.com/xxxxxx",
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

```

## Additional information

All you need is to initialize the package, the package handles everything..
