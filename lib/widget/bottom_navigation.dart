import 'package:flutter/material.dart';
import 'package:money_manager/Screens/HomeScreen.dart';
import 'package:money_manager/Screens/add.dart';
import 'package:money_manager/Screens/statics.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index_color = 0;
  List screens = [HomeScreen(), Statics(), HomeScreen(), Statics()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => add_screen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff368983),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 7.5,
            bottom: 7.5,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index_color == 0 ? Color(0xff368983) : Colors.grey,
                )),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: index_color == 1 ? Color(0xff368983) : Colors.grey,
                )),
            SizedBox(
              width: 50,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.wallet,
                  size: 30,
                  color: index_color == 2 ? Color(0xff368983) : Colors.grey,
                )),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                  });
                },
                child: Icon(
                  Icons.person_4_rounded,
                  size: 30,
                  color: index_color == 3 ? Color(0xff368983) : Colors.grey,
                )),
          ]),
        ),
      ),
    );
  }
}
