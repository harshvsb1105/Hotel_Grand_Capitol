import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_grand_capitol/Boxes.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Controllers/BookingController.dart';
import 'package:hotel_grand_capitol/Model/BookedRoomModel.dart';
import 'package:hotel_grand_capitol/Model/UserModel.dart';
import 'package:hotel_grand_capitol/Screen/BookedDetails.dart';
import 'package:hotel_grand_capitol/Screen/DashboardScreen.dart';
import 'package:hotel_grand_capitol/Screen/SlipScreen.dart';
import 'package:hotel_grand_capitol/Widgets/NeuButtons.dart';
import 'package:hotel_grand_capitol/Widgets/TextFieldWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';

class RoomBookingScreen extends StatefulWidget {
  final String regNo;
  final List<String> userName;
  final String noOfPeople;
  final String phoneNo;
  final String type;
  final String bookingId;
  final String paymentMode;
  final String amount;
  final String guestImage;
  final String imageId;
  final bool dashboard;
  final String checkIn;
  final String checkOut;
  final File imageFile;
  final List<UserModel> usersList;
  final Box<UserModel> userModelBox;
  final Box<BookedRoomModel> bookedRoomModelBox;


  const RoomBookingScreen(
      {Key key,
      this.regNo,
      this.userName,
      this.noOfPeople,
      this.phoneNo,
      this.type,
      this.bookingId,
      this.paymentMode,
      this.amount,
      this.guestImage,
      this.imageId,
      this.dashboard = false,
      this.checkIn,
      this.checkOut,
      this.imageFile, this.usersList, this.userModelBox, this.bookedRoomModelBox})
      : super(key: key);

  @override
  _RoomBookingScreenState createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  BookingController bookingController = Get.put(BookingController());
  TextEditingController checkOutController = TextEditingController();
  TextEditingController addBillController = TextEditingController();
  Set<String> roomsNoSelected = {};
  List<BookedRoomModel> bookedRoom = [];
  List<String> selectedRoom = [];
  DateTime checkedOutDate = DateTime.now();

  Future<void> _checkedOutDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: checkedOutDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != checkedOutDate)
      setState(() {
        checkedOutDate = picked;
        checkOutController.text = checkedOutDate.toString().substring(0, 10);
      });
  }

  getBookedRooms() async {
    final roomBox = await Hive.openBox<BookedRoomModel>('betaBookedRoomBox1');
    bookedRoom = roomBox.values.toList();

    bookedRoom.map((e) {
      selectedRoom.add(e.roomNo);
    }).toList();
    setState(() {});
    // widget.dashboard ?  _selectedSeats = bookedRoom  : _selectedSeats = [];
  }

  @override
  void initState() {
    getBookedRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // selectedRoom.add(value);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: reddishColor,
          title: Text("Room Booking",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: bluishColor)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildBody(),
            30.height,
            widget.dashboard
                ? Text("Booked Rooms",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: bluishColor))
                : Container(),
            widget.dashboard ? _buildBookedRooms() : Container(),
            !widget.dashboard
                ? Align(
                    alignment: Alignment.center,
                    child: NeuButtons(
                      title: "Save",
                      onTap: () {
                        print(
                            "This is the value of roomNoSelected : ${roomsNoSelected}");
                        print("This is the value of roomSelected : ${seat}");
                        print("PATMENT MODE ::: ${widget.paymentMode}");
                        bookingController.addDetails(
                          widget.regNo,
                          widget.userName,
                          widget.noOfPeople,
                          widget.phoneNo,
                          widget.type,
                          widget.bookingId,
                          widget.paymentMode,
                          widget.amount,
                          widget.checkIn,
                          widget.checkOut,
                          roomNo: roomsNoSelected.toList(),
                          roomSelected: seat,
                          guestImage: widget.guestImage,
                          guestImageId: widget.imageId,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SlipScreen(
                                      regNo: widget.regNo,
                                      userName: widget.userName,
                                      noOfPeople: widget.noOfPeople,
                                      phoneNo: widget.phoneNo,
                                      type: widget.type,
                                      bookingId: widget.bookingId,
                                      paymentMode: widget.paymentMode,
                                      amount: widget.amount,
                                      checkIn: widget.checkIn,
                                      checkOut: widget.checkOut,
                                      guestImage: widget.guestImage,
                                      imageId: widget.imageId,
                                      roomNo: roomsNoSelected.toList(),
                                      image: widget.imageFile,
                                    )));
                      },
                      color: darkBluishColor,
                    ),
                  )
                : Container()
          ],
        ));
  }

  List<BookedRoomModel> _selectedSeats = <BookedRoomModel>[];

  SingleChildScrollView _buildBody() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildSeatsSelectionWidget(),
          ],
        ),
      );

  /// Will create a widget where seats will be arranged in the grid and
  /// user can tap and select/un-select those seats.
  Padding _buildSeatsSelectionWidget() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _dummyData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
            ),
            itemBuilder: (_, final int index) =>
                Container(child: _buildSeat(index))),
      );

  var seat;
  int ind;
  bool roomSelected = false;

  Widget _buildSeat(int index) {
    BookedRoomModel room = BookedRoomModel()
      ..roomNo = _dummyData.elementAt(index)
      ..names = widget.userName
      ..regNo = widget.regNo
      ..numberOfPeople = widget.noOfPeople
      ..checkOutDate = widget.checkOut
      ..checkInDate = widget.checkIn
      ..bookingID = widget.bookingId
      ..amount = widget.amount
      ..paymentMode = widget.paymentMode
      ..phoneNo = widget.phoneNo
      ..type = widget.type
      ..guestImage = widget.guestImage
      ..guestsId = widget.imageId
      ..roomsChosen = roomsNoSelected.toList();

    bookedRoom.map((e) {
      // print("What is e :: ${e.names} && ${room.names}");

      /// put _selectedSeat list map too
      if (e.roomNo == room.roomNo) {
        ind = bookedRoom.indexOf(room);
        // print("indexxxxx : $ind");
        // print("The value of e : ${e.roomNo} &&& ${e.names}");
        // print("The value of room : ${room.roomNo} && ${room.names}");
      }
    }).toList();
    var isSelected = isSelectedSeat(room);
    // print("isSelected :::: $isSelected");
    // print("room model :::: ${room.roomNo} && ${room.names}");
    bool pressed = false;
    var seatColor =
        !selectedRoom.contains(room.roomNo) ? Colors.white30 : Colors.green;
    // selectedRoom.add(room.roomNo);
    return InkWell(
      onTap: () {
        selectedRoom.add(room.roomNo);
        if (widget.dashboard == false) {
          // roomSelected = true;
          setState(() => isSelected
              ? _selectedSeats.remove(room)
              : _selectedSeats.add(room));
          print("This is selected room : $_selectedSeats");
          _selectedSeats.map((e) {
            roomsNoSelected.add(e.roomNo);
          }).toList();
          seat = _dummyData.elementAt(index);

          final selectedRoom = BookedRoomModel()
            ..names = widget.userName
            ..numberOfPeople = widget.noOfPeople
            ..roomNo = seat
            ..regNo = widget.regNo
            ..checkOutDate = widget.checkOut
            ..checkInDate = widget.checkIn
            ..bookingID = widget.bookingId
            ..paymentMode = widget.paymentMode
            ..phoneNo = widget.phoneNo
            ..type = widget.type
            ..guestImage = widget.guestImage
            ..guestsId = widget.imageId
            ..updatedAt = DateTime.now()
            ..amount = widget.paymentMode != "Payment.Due" ? widget.amount : ""
            ..pendingAmount = widget.paymentMode == "Payment.Due" ? widget.amount : ""
            ..roomsChosen = roomsNoSelected.toList();

          print("HHHHHHHHH 1 --> ${selectedRoom} %% ${selectedRoom.roomNo}");

          final roomBox = Boxes.roomBooked();
          roomBox.add(selectedRoom);
          setState(() {});
          print("HHHHHHHHH 2 ----- $roomSelected ");
        } else {
        }
      },
      child: Padding(
        // space around seat.
        padding: const EdgeInsets.all(2),
        // seat it self.
        child: Container(
          color:  seatColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8), // spacing around the text of the seat.
          // text that fits in the seat and represents seat id.
          child: FittedBox(
            child: Text(room.roomNo, style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }

  /// ------------------------------------BOOKED ROOMS------------------------------------------------ ///

  SingleChildScrollView _buildBookedRooms() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildRoomSelectionWidget(),
          ],
        ),
      );

  Padding _buildRoomSelectionWidget() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: bookedRoom.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
            ),
            itemBuilder: (_, final int index) =>
                Container(child: _buildRoomTile(index))),
      );

  Widget _buildRoomTile(int index) {
    BookedRoomModel room = BookedRoomModel()

      /// roomNo should be selectedRoom.elementAt(index)
      ..roomNo = selectedRoom.elementAt(index)
      ..names = widget.userName
      ..regNo = widget.regNo
      ..numberOfPeople = widget.noOfPeople
      ..checkOutDate = widget.checkOut
      ..checkInDate = widget.checkIn
      ..bookingID = widget.bookingId
      ..amount = widget.amount
      ..paymentMode = widget.paymentMode
      ..phoneNo = widget.phoneNo
      ..type = widget.type
      ..guestImage = widget.guestImage
      ..guestsId = widget.imageId
      ..roomsChosen = roomsNoSelected.toList();

    var isSelected = isSelectedSeat(room);
    // print("isSelected :::: $isSelected");
    // print("room model :::: ${room.roomNo} && ${room.names}");

    var seatColor = !isSelected ? Colors.white30 : Colors.green;
    return InkWell(
      onTap: () {
        if (widget.dashboard == false) {
          setState(() => isSelected
              ? _selectedSeats.remove(room)
              : _selectedSeats.add(room));
          print("This is selected room : $_selectedSeats");
          _selectedSeats.map((e) {
            roomsNoSelected.add(e.roomNo);
          }).toList();
          seat = _dummyData.elementAt(index);

          final selectedRoom = BookedRoomModel()
            ..names = widget.userName
            ..numberOfPeople = widget.noOfPeople
            ..roomNo = seat
            ..regNo = widget.regNo
            ..checkOutDate = widget.checkOut
            ..checkInDate = widget.checkIn
            ..bookingID = widget.bookingId
            ..paymentMode = widget.paymentMode
            ..phoneNo = widget.phoneNo
            ..type = widget.type
            ..guestImage = widget.guestImage
            ..guestsId = widget.imageId
            ..updatedAt = DateTime.now()
            ..amount = widget.paymentMode != "Payment.Due" ? widget.amount : ""
            ..pendingAmount = widget.paymentMode == "Payment.Due" ? widget.amount : ""
            ..roomsChosen = roomsNoSelected.toList();

          print("HHHHHHHHH 1 --> ${selectedRoom} %% ${selectedRoom.names}");

          final roomBox = Boxes.roomBooked();
          roomBox.add(selectedRoom);
          print("HHHHHHHHH 2");
          setState(() {});
        } else {
          ///Make separate section for booked rooms

          print("This is index of room : $index");
          print("This is roomNo of room : ${bookedRoom[index].roomNo}");
          print("This is name of room : ${bookedRoom[index].names}");
          print("This is reg of room : ${bookedRoom[index].regNo}");
          print("This is checkOut of room : ${bookedRoom[index].checkOutDate}");
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: reddishColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              builder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 600,
                      width: 600,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Room Number - ${bookedRoom[index].roomNo}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: bluishColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  bookedRoom[index].names.first ?? "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                trailing: Text(
                                  bookedRoom[index].regNo ?? "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                tileColor: backgroundColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  "Dates",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                trailing: Text(
                                  "${bookedRoom[index].checkInDate} - ${bookedRoom[index].checkOutDate}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                tileColor: backgroundColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  "Guests",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                trailing: Text(
                                  "${bookedRoom[index].numberOfPeople} Guests",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                tileColor: backgroundColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  "Total Bill",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                trailing: Text(
                                  bookedRoom[index].amount == "" ? "0" : bookedRoom[index].amount,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                tileColor: backgroundColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  "Pending Amount",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                trailing: Text(
                                  bookedRoom[index].pendingAmount != null ? bookedRoom[index].pendingAmount == "" ? "0" : bookedRoom[index].pendingAmount : "0",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: bluishColor),
                                ),
                                tileColor: backgroundColor,
                              ),
                            ),
                            15.height,
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     NeuButtons(
                            //       color: bluishColor,
                            //       title: "Add-Bill",
                            //       buttonBackground: reddishColor,
                            //       shadow1: Color(0xffcc4747),
                            //       shadow2: Color(0xffff6161),
                            //     ),
                            //     NeuButtons(
                            //       color: bluishColor,
                            //       title: "Collect-Payment",
                            //       buttonBackground: reddishColor,
                            //       shadow1: Color(0xffcc4747),
                            //       shadow2: Color(0xffff6161),
                            //     )
                            //   ],
                            // ),
                            // 10.height,
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     NeuButtons(
                            //       color: bluishColor,
                            //       title: "Pin-Room",
                            //       buttonBackground: reddishColor,
                            //       shadow1: Color(0xffcc4747),
                            //       shadow2: Color(0xffff6161),
                            //     ),
                            //     NeuButtons(
                            //       color: bluishColor,
                            //       title: "Unpin-Room",
                            //       buttonBackground: reddishColor,
                            //       shadow1: Color(0xffcc4747),
                            //       shadow2: Color(0xffff6161),
                            //     )
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NeuButtons(
                                  color: bluishColor,
                                  title: "Modify",
                                  buttonBackground: reddishColor,
                                  shadow1: Color(0xffcc4747),
                                  shadow2: Color(0xffff6161),
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AlertDialog(
                                              title: Text('Modify Check-Out date'),
                                              content: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.53,
                                                    child: TextFieldWidget(
                                                      hintText: "Check-Out",
                                                      controller: checkOutController,
                                                      suffixButton: true,
                                                      suffixHeight: 30,
                                                      suffixWidth: 35,
                                                      suffixTitle: "Out",
                                                      suffixOnTap: () async {
                                                        await _checkedOutDate(
                                                            context);
                                                      },
                                                    ),
                                                  ),
                                                  20.height,
                                                  NeuButtons(
                                                    color: bluishColor,
                                                    title: "Modify Check-Out",
                                                    buttonBackground: reddishColor,
                                                    shadow1: Color(0xffcc4747),
                                                    shadow2: Color(0xffff6161),
                                                    onTap: () async {
                                                      print("CHECKOUTDATE 0:: ${checkedOutDate}");

                                                      BookedRoomModel room = BookedRoomModel()
                                                        ..roomNo = bookedRoom[index].roomNo
                                                        ..names = bookedRoom[index].names
                                                        ..regNo = bookedRoom[index].regNo
                                                        ..numberOfPeople = bookedRoom[index].numberOfPeople
                                                        ..checkOutDate = checkedOutDate.toString().substring(0,10)
                                                        ..checkInDate = bookedRoom[index].checkInDate
                                                        ..bookingID = bookedRoom[index].bookingID
                                                        ..amount = bookedRoom[index].amount
                                                        ..paymentMode = bookedRoom[index].paymentMode
                                                        ..phoneNo = bookedRoom[index].phoneNo
                                                        ..type = bookedRoom[index].type
                                                        ..guestImage = bookedRoom[index].type
                                                        ..guestsId = bookedRoom[index].guestsId
                                                        ..pendingAmount = bookedRoom[index].pendingAmount
                                                        ..roomsChosen = bookedRoom[index].roomsChosen;


                                                      widget.usersList.map((e) {
                                                        int idx =  widget.usersList.indexOf(e);
                                                        UserModel userModel = UserModel()
                                                          ..registrationNumber = e.registrationNumber
                                                          ..names = e.names
                                                          ..phoneNo = e.phoneNo
                                                          ..type = e.type
                                                          ..bookingID = e.bookingID
                                                          ..paymentMode = e.paymentMode
                                                          ..amount = e.amount
                                                          ..checkInDate = e.checkInDate
                                                          ..checkOutDate = checkedOutDate.toString().substring(0,10)
                                                          ..roomNo = e.roomNo
                                                          ..guestsId = e.guestsId
                                                          ..guestImage = e.guestImage
                                                          ..pendingAmount = e.pendingAmount
                                                          ..updatedAt = DateTime.now();

                                                        widget.userModelBox.putAt(idx, userModel);
                                                      }).toList();

                                                      widget.bookedRoomModelBox.putAt(index, room);

                                                      setState(() {

                                                      });
                                                      // Navigator.pop(context);

                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
                                                    },
                                                  )
                                                ],
                                              )
                                            )
                                    );
                                  },
                                ),
                                NeuButtons(
                                  color: bluishColor,
                                  title: "Add Bills",
                                  buttonBackground: reddishColor,
                                  shadow1: Color(0xffcc4747),
                                  shadow2: Color(0xffff6161),
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AlertDialog(
                                                title: Text('Add Bills'),
                                                content: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.53,
                                                      child: TextFieldWidget(
                                                        hintText: "Enter Amount",
                                                        controller: addBillController,
                                                        suffixHeight: 30,
                                                        suffixWidth: 35,
                                                      ),
                                                    ),
                                                    20.height,
                                                    NeuButtons(
                                                      color: bluishColor,
                                                      title: "Modify Bills",
                                                      buttonBackground: reddishColor,
                                                      shadow1: Color(0xffcc4747),
                                                      shadow2: Color(0xffff6161),
                                                      onTap: () async {
                                                        print("ABOUT ROOM :: ${bookedRoom[index].roomNo}");
                                                        print("Modify Bills 0 ${addBillController.text}");

                                                        BookedRoomModel room = BookedRoomModel()
                                                          ..roomNo = bookedRoom[index].roomNo
                                                          ..names = bookedRoom[index].names
                                                          ..regNo = bookedRoom[index].regNo
                                                          ..numberOfPeople = bookedRoom[index].numberOfPeople
                                                          ..checkOutDate = bookedRoom[index].checkOutDate
                                                          ..checkInDate = bookedRoom[index].checkInDate
                                                          ..bookingID = bookedRoom[index].bookingID
                                                          ..amount = bookedRoom[index].amount
                                                          ..paymentMode = addBillController.text
                                                          ..phoneNo = bookedRoom[index].phoneNo
                                                          ..type = bookedRoom[index].type
                                                          ..guestImage = bookedRoom[index].type
                                                          ..guestsId = bookedRoom[index].guestsId
                                                          ..pendingAmount = bookedRoom[index].pendingAmount
                                                          ..roomsChosen = bookedRoom[index].roomsChosen;

                                                        print("Modify Bills 1 ${addBillController.text}");

                                                        widget.usersList.map((e) {
                                                          int idx =  widget.usersList.indexOf(e);
                                                          UserModel userModel = UserModel()
                                                            ..registrationNumber = e.registrationNumber
                                                            ..names = e.names
                                                            ..phoneNo = e.phoneNo
                                                            ..type = e.type
                                                            ..bookingID = e.bookingID
                                                            ..paymentMode = e.paymentMode
                                                            ..amount = e.amount
                                                            ..checkInDate = e.checkInDate
                                                            ..checkOutDate = e.checkOutDate
                                                            ..roomNo = e.roomNo
                                                            ..guestsId = e.guestsId
                                                            ..guestImage = e.guestImage
                                                            ..pendingAmount = addBillController.text
                                                            ..updatedAt = DateTime.now();

                                                          widget.userModelBox.putAt(idx, userModel);
                                                        }).toList();
                                                        print("Modify Bills 4 ${addBillController.text}");

                                                        widget.bookedRoomModelBox.putAt(index, room);
                                                        print("Modify Bills 5 ${addBillController.text}");

                                                        setState(() {

                                                        });
                                                        // Navigator.pop(context);
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
                                                      },
                                                    )
                                                  ],
                                                )
                                            )
                                    );
                                  },
                                )
                              ],
                            ),
                            20.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NeuButtons(
                                  color: bluishColor,
                                  title: "Slip",
                                  buttonBackground: reddishColor,
                                  shadow1: Color(0xffcc4747),
                                  shadow2: Color(0xffff6161),
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SlipScreen(
                                              regNo: bookedRoom[index].regNo,
                                              userName: bookedRoom[index].names,
                                              noOfPeople: bookedRoom[index]
                                                  .numberOfPeople,
                                              phoneNo:
                                              bookedRoom[index].phoneNo,
                                              type: bookedRoom[index].type,
                                              bookingId:
                                              bookedRoom[index].bookingID,
                                              paymentMode:
                                              bookedRoom[index].paymentMode,
                                              amount: bookedRoom[index].amount,
                                              checkIn:
                                              bookedRoom[index].checkInDate,
                                              checkOut: bookedRoom[index]
                                                  .checkOutDate,
                                              guestImage:
                                              bookedRoom[index].guestImage,
                                              imageId:
                                              bookedRoom[index].guestsId,
                                              roomNo: roomsNoSelected.toList(),
                                              image: File(
                                                  bookedRoom[index].guestImage),
                                            )));
                                  },
                                ),
                                NeuButtons(
                                  color: bluishColor,
                                  title: "Check-Out",
                                  buttonBackground: reddishColor,
                                  shadow1: Color(0xffcc4747),
                                  shadow2: Color(0xffff6161),
                                  onTap: () async {
                                    print("paymentMode IN BOOKEDROOMSCREEN :: ${bookedRoom[index].paymentMode}");
                                    if(bookedRoom[index].paymentMode == "Payment.Due") {
                                      print("Print for due payment");
                                      await showDialog(
                                          context: context,
                                          builder: (context) =>
                                          AlertDialog(
                                            title: Text('Some amount is Due, make payment and then press OK to continue'),
                                            content:      ElevatedButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: Text("OK")),
                                          )
                                      );
                                    }
                                    ///CHECK FOR THE DIALOG BOX FOR DUE PAYMENT ------------
                                    await bookedRoom[index].delete();
                                    toast("Checked-Out");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardScreen()));
                                  },
                                )
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ));
        }
      },
      child: Padding(
        // space around seat.
        padding: const EdgeInsets.all(2),
        // seat it self.
        child: Container(
          color: seatColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8), // spacing around the text of the seat.
          // text that fits in the seat and represents seat id.
          child: FittedBox(
            child: Text(room.roomNo, style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }

  bool isSelectedSeat(BookedRoomModel room) => _selectedSeats.contains(room);
}

List<String> _dummyData = [
  '001',
  '002',
  '003',
  '004',
  '005',
  '006',
  '007',
  '008',
  '009',
  '010',
  '101',
  '102',
  '103',
  '104',
  '105',
  '106',
  '107',
  '108',
  '109',
  '110',
  '201',
  '202',
  '203',
  '204',
  '205',
  '206',
  '207',
  '208',
  '209',
  '210',
  '301',
  '302',
  '303',
  '304',
  '305',
  '306',
  '307',
  '308',
  '309',
  '310',
  '401',
  '402',
  '403',
  '404',
  '405',
  '406',
  '407',
  '408',
  '409',
  '410',
];
