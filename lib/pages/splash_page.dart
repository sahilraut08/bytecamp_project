import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_one/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff0a0048), Color(0xff000080)],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter),
      ),
      child: Center(
        child: Image.asset("assets/images/logoNew.png"),
      ),
    );
  }
}
