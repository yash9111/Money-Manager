import 'package:flutter/material.dart';
import 'package:money_manager/data/findTotal.dart';
import 'package:money_manager/data/listData.dart';
import 'package:money_manager/data/models/add_data.dart';
import 'package:money_manager/widget/chart.dart';

import '../data/top.dart';

class Statics extends StatefulWidget {
  const Statics({super.key});

  @override
  State<Statics> createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  List<String> day1 = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List f = [today(), week(), month(), year()];
  int index_color = 0;

  List<Add_data> a = [];
  ValueNotifier kj = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: kj,
        builder: (context, value, child) {
          a = f[value];
          return Custom();
        },
      )),
    );
  }

  CustomScrollView Custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Stistics",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index_color = index;
                              kj.value = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index_color == index
                                    ? Color.fromARGB(255, 47, 125, 121)
                                    : Colors.white),
                            child: Text(day[index],
                                style: TextStyle(
                                    color: index_color == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Expence",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_downward_sharp,
                              color: Colors.grey,
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Chart(indexx:index_color),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Top Spending",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: Colors.grey,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child:
                  Image.asset('assest/images/${a[index].name}.png', height: 40),
            ),
            title: Text(a[index].name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17)),
            subtitle: Text(
                '${day1[a[index].dateTime.weekday - 1]} ${a[index].dateTime.year} /${a[index].dateTime.month} /${a[index].dateTime.day}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            trailing: Text('₹ ${a[index].amount}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: a[index].IN == 'Income' ? Colors.green : Colors.red,
                    fontSize: 20)),
          );
        }, childCount: a.length))
      ],
    );
  }
}
