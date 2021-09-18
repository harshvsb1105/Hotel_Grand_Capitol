import 'package:hive/hive.dart';

part 'UserModel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
  String registrationNumber;

  @HiveField(1)
  List<String> names;

  @HiveField(2)
  String numberOfPeople;

  @HiveField(3)
  String phoneNo;

  @HiveField(4)
  String type;

  @HiveField(5)
  String bookingID;

  @HiveField(6)
  String paymentMode;

  @HiveField(7)
  String amount;

  @HiveField(8)
  List<String> roomNo;

  @HiveField(9)
  String guestImage;

  @HiveField(10)
  String guestsId;

  @HiveField(11)
  String checkInDate;

  @HiveField(12)
  String checkOutDate;
}