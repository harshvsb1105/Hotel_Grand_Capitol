import 'package:get/get.dart';
import 'package:hotel_grand_capitol/Boxes.dart';
import 'package:hotel_grand_capitol/Model/BookedRoomModel.dart';
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
      {List<String> roomNo,
      String roomSelected,}
      ) async {

    print("HHHHHHHHH 0");
    ///Make roomSelected List<String>
    final selectedRoom = BookedRoomModel()
      ..names = usersName
      ..numberOfPeople = numberOfPeople
      ..roomNo = roomSelected
      ..regNo = regNo;
    print("HHHHHHHHH 1 --> ${selectedRoom} %% ${selectedRoom.names}");

    final roomBox = Boxes.roomBooked();
    roomBox.add(selectedRoom);
    print("HHHHHHHHH 2");

    final bookRoom = UserModel()
        ..registrationNumber = regNo
        ..names = usersName
        ..phoneNo = phoneNumber
        ..type = type
        ..bookingID = bookingId
        ..paymentMode = paymentMode
        ..amount = amount
        ..roomNo = roomNo;
    print("HHHHHHHHH 3 ---- > ${bookRoom.names} && ${bookRoom.roomNo}");

    final box  = Boxes.getBooking();
    box.add(bookRoom);
    print("HHHHHHHHH 4 --> ${box.values.first.names} &&& ${box.values.first.roomNo} && ${box.values.first.registrationNumber}");

  }

  // String getUid(String regID) {
  //   var uuid = Uuid();
  //   regID = uuid.v4();
  //   return regID;
  // }

}