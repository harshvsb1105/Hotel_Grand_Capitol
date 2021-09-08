import 'package:hive/hive.dart';

part 'BookedRoomModel.g.dart';

@HiveType(typeId: 1)
class BookedRoomModel extends HiveObject{

  @HiveField(0)
  List<String> names;

  @HiveField(1)
  String numberOfPeople;

  @HiveField(2)
  String roomNo;

  @HiveField(3)
  String regNo;
}