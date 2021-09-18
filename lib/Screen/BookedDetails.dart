import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_grand_capitol/Model/BookedRoomModel.dart';
import 'package:hotel_grand_capitol/Model/UserModel.dart';

class BookedDetails extends StatefulWidget {
  const BookedDetails({Key key}) : super(key: key);

  @override
  _BookedDetailsState createState() => _BookedDetailsState();
}

class _BookedDetailsState extends State<BookedDetails> {
  List<UserModel> _usersList = [];
  List<BookedRoomModel> bookedRoom = [];

  BookedRoomModel bookedRoomModel;
  // List get inventoryList => _inventoryList;



  getItem() async {
    final box = await Hive.openBox<UserModel>('betaUserBox');
    final roomBox = await Hive.openBox<BookedRoomModel>('betaBookedRoomBox');

    _usersList = box.values.toList();
    bookedRoom = roomBox.values.toList();
    print("This is room Box detail ---> ${bookedRoom.first.roomNo} && ${bookedRoom.first.names} ::: ${bookedRoom.length} ");
    setState(() {});
    print("${_usersList.first.names.toString()}");
    // print("RRRRRRRR${_usersList.first.roomNo}");
    // print("ZZZZZZZZZ${bookedRoomModel.names} && ${bookedRoomModel.roomNo}");
  }

  @override
  void initState() {
    getItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
        itemCount: _usersList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(_usersList[index].names.toString()),
            subtitle: Text(_usersList[index].roomNo.toString())
          )),
    );
  }
}
