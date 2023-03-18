import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_one/json/create_budget_json.dart';
import 'package:flutter_one/pages/daily_page.dart';
import 'package:flutter_one/theme/colors.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_one/NetworkHandler.dart';
import 'package:flutter_session/flutter_session.dart';

class MakePaymentPage extends StatefulWidget {
  const MakePaymentPage({Key? key}) : super(key: key);

  @override
  _MakePaymentPageState createState() => _MakePaymentPageState();
}

class _MakePaymentPageState extends State<MakePaymentPage> {
  NetworkHandler networkHandler = NetworkHandler();
  int activeCategory = 0;
  int activePayMethod = 0;
  TextEditingController _phone = TextEditingController();
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
                        "New Payment",
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Text(
              "Choose category",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: black.withOpacity(0.5)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(categories.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeCategory = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    width: 150,
                    height: 170,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == index
                                ? primary
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: grey.withOpacity(0.15)),
                              child: Center(
                                child: Image.asset(
                                  categories[index]['icon'],
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              )),
                          Text(
                            categories[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
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
                          scanBarcode();
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
                  controller: _phone,
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
                              "phone": _phone.text,
                              "amount": _budgetPrice.text,
                              "category": activeCategory,
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

  Future scanBarcode() async {
    String scanResult;
    try {
      print("open");
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.BARCODE);
      print("close");
    } on PlatformException {
      print("error");
    }
    if (!mounted) return;
  }
}
