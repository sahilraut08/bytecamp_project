import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_one/NetworkHandler.dart';
import 'package:flutter_one/json/daily_json.dart';
import 'package:flutter_one/json/day_month.dart';
import 'package:flutter_one/pages/profile_page.dart';
import 'package:flutter_one/pages/stats_page.dart';
import 'package:flutter_one/theme/colors.dart';
import 'package:flutter_session/flutter_session.dart';

import 'budget_page.dart';
import 'home_page.dart';
import 'make_payment_page.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  NetworkHandler networkHandler = NetworkHandler();
  int activeDay = 2;
  List dailyData = [];
  var totalPayment="Loading...";

  Future<void> getDaily() async {
    var userId = await FlutterSession().get("userId");
    var date;
    date = days[activeDay]['day'];
    totalPayment="Loading...";
    var response = await networkHandler.get('expense/$userId/$date');
    setState(() {
      dailyData = response['data'];
      totalPayment = response['totalPayment'];
    });
    // print(response);
    print(dailyData);
    print(totalPayment);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Daily");
    getDaily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MakePaymentPage()));
            },
            child: const Icon(Icons.add, size: 25),
            backgroundColor: Color(0xff0a0048)
          //params
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked);
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
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
                        "Daily Transaction",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){_navigateToNextScreen(context);}, icon: Icon(
                            Icons.stacked_bar_chart,
                            size: 25,
                          )
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(days.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              activeDay = index;
                              getDaily();
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 40) / 7,
                            child: Column(
                              children: [
                                Text(
                                  days[index]['label'],
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: activeDay == index
                                          ? primary
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: activeDay == index
                                              ? primary
                                              : black.withOpacity(0.1))),
                                  child: Center(
                                    child: Text(
                                      days[index]['day'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: activeDay == index
                                              ? white
                                              : black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                children: List.generate(dailyData.length, (index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (size.width - 40) * 0.7,
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: grey.withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      dailyData[index]['icon'],
                                      width: 35,
                                      height: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dailyData[index]['category'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: (size.width - 40) * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "\$"+dailyData[index]['amount'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 65, top: 8),
                        child: Divider(
                          thickness: 0.8,
                        ),
                      )
                    ],
                  );
                })),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
            child: Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 18,
                        color: black.withOpacity(0.4),
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Text(
                  totalPayment,
                  style: TextStyle(
                      fontSize: 20,
                      color: black,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.md_cash,
      Ionicons.md_calendar,
      Ionicons.md_wallet,
      Ionicons.ios_person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: 1,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        if (index == 0)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        if (index == 1)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DailyPage()));
        if (index == 2)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BudgetPage()));
        if (index == 3)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
      },
      //other params
    );
  }

}
void _navigateToNextScreen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => StatsPage()));
}
