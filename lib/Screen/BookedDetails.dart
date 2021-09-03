import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_grand_capitol/Model/UserModel.dart';

class BookedDetails extends StatefulWidget {
  const BookedDetails({Key key}) : super(key: key);

  @override
  _BookedDetailsState createState() => _BookedDetailsState();
}

class _BookedDetailsState extends State<BookedDetails> {
  List<UserModel> _usersList = [];
  // List get inventoryList => _inventoryList;

  getItem() async {
    final box = await Hive.openBox<UserModel>('userModel');
    _usersList = box.values.toList();
    setState(() {});
    print("${_usersList.first.names.toString()}");
  }

  @override
  void initState() {
    getItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) => Text(_usersList[index].names.toString())),
    );
  }
}
