// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/data/models/add_data.dart';

class add_screen extends StatefulWidget {
  const add_screen({super.key});

  @override
  State<add_screen> createState() => _add_screenState();
}

class _add_screenState extends State<add_screen> {
  final box = Hive.box<Add_data>('data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          background_container(context),
          Positioned(
            top: 120,
            // left: 30,
            child: MainContainer(),
          )
        ],
      )),
    );
  }

  DateTime date = DateTime.now();
  String? selectedItem, selectItemforHow;
  final List<String> _item = [
    'Food',
    'Transfer',
    'Transportation',
    'Education'
  ];

  final List<String> _expence = [
    'Income',
    'Expence',
  ];

  TextEditingController explain_C = TextEditingController();
  FocusNode ex = FocusNode();

  TextEditingController amount_C = TextEditingController();
  FocusNode amount_ex = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
    amount_ex.addListener(() {
      setState(() {});
    });
  }

  Container MainContainer() {
    return Container(
      height: 550,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          name(),
          SizedBox(height: 30),
          explain(),
          SizedBox(height: 30),
          amount(),
          SizedBox(height: 30),
          How(),
          SizedBox(height: 30),
          date_time(),
          Spacer(),
          saveButton(),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  GestureDetector saveButton() {
    return GestureDetector(
      onTap: () {
        var add = Add_data(selectedItem!, date, amount_C.text,
            selectItemforHow!, explain_C.text);

        box.add(add);
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xff368983)),
        width: 120,
        height: 50,
        child: Text(
          "Save",
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'f',
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
    );
  }

  Container date_time() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Color(0xffC5C5C5)),
      ),
      width: 270,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100));
          if (newDate != null) {
            setState(() {
              date = newDate;
            });
          }
        },
        child: Text(
          "Date: ${date.day} / ${date.month} / ${date.year}",
          style: TextStyle(fontSize: 19, color: Colors.black),
        ),
      ),
    );
  }

  Padding How() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffC5C5C5), width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButton<String>(
          value: selectItemforHow,
          items: _expence
              .map((e) => DropdownMenuItem(
                    child: Container(
                      child: Row(children: [
                        Container(
                          width: 40,
                          child: Image.asset('assest/images/${e}.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          e,
                          style: TextStyle(fontSize: 18),
                        )
                      ]),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _expence
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                        child: Image.asset('assest/images/${e}.png'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(e)
                    ],
                  ))
              .toList(),
          hint: Text(
            "How",
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              selectItemforHow = value!;
            });
          },
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amount_ex,
        controller: amount_C,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: "amount",
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        focusNode: ex,
        controller: explain_C,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: "explain",
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffC5C5C5), width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButton<String>(
          value: selectedItem,
          items: _item
              .map((e) => DropdownMenuItem(
                    child: Container(
                      child: Row(children: [
                        Container(
                          width: 40,
                          child: Image.asset('assest/images/${e}.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          e,
                          style: TextStyle(fontSize: 18),
                        )
                      ]),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                        child: Image.asset('assest/images/${e}.png'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(e)
                    ],
                  ))
              .toList(),
          hint: Text(
            "Name",
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              selectedItem = value!;
            });
          },
        ),
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
              color: Color(0xff368983),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  Text(
                    "Adding",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file),
                    color: Colors.white,
                  )
                ],
              ),
            )
          ]),
        )
      ],
    );
  }
}
