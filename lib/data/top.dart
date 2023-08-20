import 'package:money_manager/data/m.dart';

List<money> geter_top() {
  money snap_food = money();
  snap_food.time = 'jan 30,2023';
  snap_food.fee = '-\$500';
  snap_food.name = 'Snap food';
  snap_food.image = 'cre.jpg';
  snap_food.buy = true;
  money snap = money();
  snap.time = 'dec 2,2022';
  snap.fee = '-\$200';
  snap.name = ' food';
  snap.image = 'cre.jpg';
  snap.buy = true;

  return [snap, snap_food];
}
