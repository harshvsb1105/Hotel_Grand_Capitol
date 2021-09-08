import 'package:flutter/material.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Controllers/BookingController.dart';
import 'package:hotel_grand_capitol/Model/BookedRoomModel.dart';
import 'package:hotel_grand_capitol/Screen/BookedDetails.dart';
import 'package:hotel_grand_capitol/Widgets/NeuButtons.dart';
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
      this.imageId})
      : super(key: key);

  @override
  _RoomBookingScreenState createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  BookingController bookingController = Get.put(BookingController());
  List<String> roomsNoSelected = [];

  @override
  Widget build(BuildContext context) {
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
            Align(
              alignment: Alignment.center,
              child: NeuButtons(
                title: "Save",
                onTap: () {
                  print("This is the value of roomNoSelected : ${roomsNoSelected}");
                  print("This is the value of roomSelected : ${seat}");

                  bookingController.addDetails(
                    widget.regNo,
                    widget.userName,
                    widget.noOfPeople,
                    widget.phoneNo,
                    widget.type,
                    widget.bookingId,
                    widget.paymentMode,
                    widget.amount,
                    roomNo: roomsNoSelected,
                    roomSelected: seat
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookedDetails()));
                },
                color: darkBluishColor,
              ),
            )
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
  /// Seat grid list item. Layout of per seat.
  Widget _buildSeat(int index) {
    BookedRoomModel room = BookedRoomModel()
      ..roomNo = _dummyData.elementAt(index)
      ..names = widget.userName
      ..regNo = widget.regNo
      ..numberOfPeople = widget.noOfPeople;
    var isSelected = isSelectedSeat(room);
    var seatColor = !isSelected ? Colors.white30 : Colors.green;
    return InkWell(
      onTap: () {
        setState(() => isSelected
            ? _selectedSeats.remove(room)
            : _selectedSeats.add(room));
        print("This is selected room : $_selectedSeats");
        _selectedSeats.map((e) {
          roomsNoSelected.add(e.roomNo);
        }).toList();
        seat = _dummyData.elementAt(index);
        setState(() {});
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
            child:
                Text(room.roomNo, style: TextStyle(color: Colors.black)),
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
