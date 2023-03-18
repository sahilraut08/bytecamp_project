import 'package:flutter/material.dart';
import 'package:flutter_one/widgets/btn_widget.dart';
import 'package:flutter_one/widgets/herder_container.dart';

class RegPage extends StatefulWidget {
  const RegPage({Key? key}) : super(key: key);

  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderContainer(""),
          Container(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _textInput(hint: "Fullname", icon: Icons.person),
                  _textInput(hint: "Email", icon: Icons.email),
                  _textInput(hint: "Phone Number", icon: Icons.call),
                  _textInput(hint: "Password", icon: Icons.vpn_key),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: ButtonWidget(
                            btnText: "REGISTER",
                            onClick: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: new Padding(
                            padding: new EdgeInsets.all(10.0),
                            child: new Text("Already a member ? Login"),
                          ),
                        )
                      ],
                    )
                  ),
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
