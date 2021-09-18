import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_grand_capitol/Model/BookedRoomModel.dart';
import 'package:hotel_grand_capitol/Model/UserModel.dart';

class Boxes {
  static Box<UserModel> getBooking() => Hive.box<UserModel>("betaUserBox");
  static Box<BookedRoomModel> roomBooked() => Hive.box<BookedRoomModel>("betaBookedRoomBox");
}