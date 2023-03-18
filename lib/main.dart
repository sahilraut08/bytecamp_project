import 'package:flutter/material.dart';
import 'package:flutter_one/pages/root_app.dart';
import 'package:flutter_one/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SplashPage(),
    );
  }
}

