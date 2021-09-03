import 'package:get/get.dart';
import 'package:hotel_grand_capitol/Boxes.dart';
import 'package:hotel_grand_capitol/Model/UserModel.dart';
import 'package:uuid/uuid.dart';

class BookingController extends GetxController {
  Future addDetails(
      String regNo,
      List<String> usersName,
      String numberOfPeople,
      String phoneNumber,
      String type,
      String bookingId,
      String paymentMode,
      String amount,
      List<String> roomNo,
      ) async {
    final bookRoom = UserModel()
        ..registrationNumber = regNo
        ..names = usersName
        ..phoneNo = phoneNumber
        ..type = type
        ..bookingID = bookingId
        ..paymentMode = paymentMode
        ..amount = amount
        ..roomNo = roomNo;

    final box  = Boxes.getBooking();
    box.add(bookRoom);
  }

  String getUid(String regID) {
    var uuid = Uuid();
    regID = uuid.v4();
    return regID;
  }
}