import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/data/findTotal.dart';
import 'package:money_manager/data/listData.dart';
import 'package:money_manager/data/models/add_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var history;
  final box = Hive.box<Add_data>('data');

  List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text("MoneyManager")),
        body: SafeArea(
            // minimum: EdgeInsets.only(top: 50),
            child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(height: 400, child: upperPart()),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Transcations History",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 19)),
                              Text(
                                "See all",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        history = box.values.toList()[index];

                        return getList(history, index);
                      }, childCount: box.length))
                    ],
                  );
                })));
  }

  Widget getList(Add_data history, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
        },
        child: get(index, history));
  }

  ListTile get(int index, Add_data history) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('assest/images/${history.name}.png', height: 40),
      ),
      title: Text(history.name,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17)),
      subtitle: Text(
          '${day[history.dateTime.weekday - 1]} ${history.dateTime.year} /${history.dateTime.month} /${history.dateTime.day}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      trailing: Text('₹ ${history.amount}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: history.IN == 'Income' ? Colors.green : Colors.red,
              fontSize: 20)),
    );
  }

  Widget upperPart() {
    return Stack(children: [
      Column(
        children: [
          Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xff368983),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: 20,
                      left: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Color.fromRGBO(250, 250, 250, 0.1),
                          child: Icon(
                            Icons.notification_add_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Good Afternoon",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white60,
                              fontSize: 20),
                        ),
                        Text(
                          "Mr.Yash",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
      Positioned(
        top: 210,
        left: 30,
        child: Container(
          height: 189,
          width: 300,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 12,
                    spreadRadius: 16,
                    color: Color.fromRGBO(47, 125, 121, 0.3),
                    offset: Offset(0, 6))
              ],
              color: Color.fromARGB(255, 47, 125, 121),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "\₹ ${total()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: Color.fromARGB(255, 85, 145, 141),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Income",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 216, 216, 216),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: Color.fromARGB(255, 85, 145, 141),
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Expence",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 216, 216, 216),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\₹ ${Income()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25),
                  ),
                  Text(
                    "₹ ${Expence()} ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25),
                  )
                ],
              ),
            )
          ]),
        ),
      )
    ]);
  }
}
