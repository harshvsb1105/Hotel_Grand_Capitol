import 'package:flutter/material.dart';
import 'package:hotel_grand_capitol/Constants.dart';

class RoomBookingScreen extends StatefulWidget {
  const RoomBookingScreen({Key key}) : super(key: key);

  @override
  _RoomBookingScreenState createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: reddishColor,
        title: Text(
          "Room Booking",
            style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: bluishColor)
        ),
        centerTitle: true,
      ),
        body: _buildBody());
  }

  List<String> _selectedSeats = <String>[];


  SingleChildScrollView _buildBody() =>
      SingleChildScrollView(
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
  Padding _buildSeatsSelectionWidget() =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _dummyData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
            ),
            itemBuilder: (_, final int index) => Container(
                child: _buildSeat(index))),
      );

  /// Seat grid list item. Layout of per seat.
  Widget _buildSeat(int index) {
    var seat = _dummyData.elementAt(index);
    var isSelected = isSelectedSeat(seat);
    var seatColor = !isSelected ? Colors.white30 : Colors.green;
    return InkWell(
      onTap: () {
        setState(() =>
          isSelected ? _selectedSeats.remove(seat) : _selectedSeats.add(seat));
        print("This is selected room : $_selectedSeats");
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
            child: Text(seat, style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }

  bool isSelectedSeat(String seat) => _selectedSeats.contains(seat);
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