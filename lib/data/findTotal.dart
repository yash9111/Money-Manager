import 'package:hive/hive.dart';
import 'package:money_manager/data/models/add_data.dart';

int totals = 0;

final box = Hive.box<Add_data>('data');

int total() {
  var history2 = box.values.toList();
  List a = [];

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  if (history2.length != 0) {
    totals = a.reduce((value, element) => value + element);
    // totals = 0;
  } else {
    totals = 0;
  }
  return totals;
}

int Income() {
  var totalIN = 0;
  var history2 = box.values.toList();
  List a = [0, 0];

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? int.parse(history2[i].amount) : 0);
  }
  if (history2.length != 0) {
    totalIN = a.reduce((value, element) => value + element);
    // totals = 0;
  } else {
    totalIN = 0;
  }
  return totalIN;
}

int Expence() {
  var totalEX = 0;
  var history2 = box.values.toList();
  List a = [0, 0];

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? 0 : int.parse(history2[i].amount) * -1);
  }
  if (a.isNotEmpty) {
    totalEX = a.reduce((value, element) => value + element);
  } else {
    totalEX = 0;
  }

  return totalEX;
}

List<Add_data> today() {
  var history2 = box.values.toList();
  List<Add_data> a = [];

  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.day == date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> week() {
  var history2 = box.values.toList();
  List<Add_data> a = [];

  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].dateTime.day &&
        history2[i].dateTime.day <= date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> month() {
  var history2 = box.values.toList();
  List<Add_data> a = [];

  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<Add_data> year() {
  var history2 = box.values.toList();
  List<Add_data> a = [];

  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].dateTime.year == date.year) {
      a.add(history2[i]);
    }
  }
  return a;
}

int total_chart(List<Add_data> history2) {
  // var history2 = box.values.toList();
  List a = [];

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  if (history2.length != 0) {
    totals = a.reduce((value, element) => value + element);
    // totals = 0;
  } else {
    totals = 0;
  }
  return totals;
}

List time(List<Add_data> history2, bool hour) {
  List<Add_data> a = [];
  List total = [0, 0];
  int counter = 0;

  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].dateTime.hour == history2[c].dateTime.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].dateTime.day == history2[c].dateTime.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  return total;
}
