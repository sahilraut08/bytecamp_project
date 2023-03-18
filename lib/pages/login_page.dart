import 'package:flutter/material.dart';
import 'package:flutter_one/NetworkHandler.dart';
import 'package:flutter_one/pages/registration_page.dart';
import 'package:flutter_one/pages/root_app.dart';
import 'package:flutter_one/widgets/btn_widget.dart';
import 'package:flutter_one/widgets/herder_container.dart';
import 'package:flutter_session/flutter_session.dart';

import 'profile_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var session = FlutterSession();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        children: <Widget>[
          HeaderContainer(""),
          Container(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _textInput(
                      hint: "Email",
                      icon: Icons.email,
                      controller: _emailController),
                  _textInput(
                      hint: "Password",
                      icon: Icons.vpn_key,
                      controller: _passwordController),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    child: Center(
                      child: ButtonWidget(
                        onClick: () async {
                          Map<String, String> data = {
                            "email": _emailController.text,
                            "password": _passwordController.text
                          };
                          print(data);
                          var response =
                              await networkHandler.post('signIn', data);
                          print(response['data']);
                          if (response['status'] == true) {
                            session.set('userId', response['data']['_id']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          }
                        },
                        btnText: "LOGIN",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegPage()));
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text("Don't have an account ? Registor"),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
