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

  @HiveField(4)
  String type;

  @HiveField(5)
  String bookingID;

  @HiveField(6)
  String paymentMode;

  @HiveField(7)
  String amount;

  @HiveField(8)
  String guestImage;

  @HiveField(9)
  String guestsId;

  @HiveField(10)
  String checkInDate;

  @HiveField(11)
  String checkOutDate;

  @HiveField(12)
  String phoneNo;

  @HiveField(13)
  List<String> roomsChosen;

  @HiveField(14)
  DateTime updatedAt;

  @HiveField(15)
  String pendingAmount;
}