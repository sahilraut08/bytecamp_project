import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_one/json/create_budget_json.dart';
import 'package:flutter_one/theme/colors.dart';
import 'package:flutter_session/flutter_session.dart';

import '../NetworkHandler.dart';
import 'daily_page.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({Key? key}) : super(key: key);

  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  NetworkHandler networkHandler = NetworkHandler();
  int activeCategory = 0;
  int activePayMethod = 0;
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _budgetPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Send money",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Row(
                        children: [Icon(AntDesign.search1)],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pay Using : ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xff67727d)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            activePayMethod = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: activePayMethod == 0 ? primary : white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                  activePayMethod == 0 ? primary : black)),
                          child: activePayMethod == 0
                              ? const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text(
                              "Phone Number",
                              style: TextStyle(color: white),
                            ),
                          )
                              : const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text(
                              "Phone Number",
                              style: TextStyle(color: black),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            activePayMethod = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: activePayMethod == 1 ? primary : white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                  activePayMethod == 1 ? primary : black)),
                          child: activePayMethod == 1
                              ? const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text(
                              "Net Banking",
                              style: TextStyle(color: white),
                            ),
                          )
                              : const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text(
                              "Net Banking",
                              style: TextStyle(color: black),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            activePayMethod = 2;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: activePayMethod == 2 ? primary : white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                  activePayMethod == 2 ? primary : black)),
                          child: activePayMethod == 2
                              ? const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text(
                              "QR Code",
                              style: TextStyle(color: white),
                            ),
                          )
                              : const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Text(
                              "QR Code",
                              style: TextStyle(color: black),
                            ),
                          ),
                        ),
                      )
                    ]),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone Number",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xff67727d)),
                ),
                TextField(
                  controller: _phoneNumber,
                  cursorColor: black,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: black),
                  decoration: InputDecoration(
                      hintText: "Enter Phone Number", border: InputBorder.none),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (size.width - 140),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xff67727d)),
                          ),
                          TextField(
                            controller: _budgetPrice,
                            cursorColor: black,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: black),
                            decoration: InputDecoration(
                                hintText: "Enter Amount",
                                border: InputBorder.none),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          onPressed: () async {
                            var userId = await FlutterSession().get("userId");
                            Map data = {
                              "phone": _phoneNumber.text,
                              "amount": _budgetPrice.text,
                              "category": 6,
                              "userId": userId
                            };
                            var response =
                            await networkHandler.postIncome('payment', data);
                            print(response);
                            if (response['status'] == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DailyPage()));
                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 25,
                            color: white,
                          )),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
