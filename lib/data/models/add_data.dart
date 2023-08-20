import 'package:hive/hive.dart';
part 'add_data.g.dart';

@HiveType(typeId: 1)
class Add_data extends HiveObject {
  @HiveField(0)
  
  String name;
  @HiveField(1)
  String explain;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String IN;
  @HiveField(4)
  DateTime dateTime;

  Add_data(this.name, this.dateTime, this.amount, this.IN, this.explain);
}
