import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Model/BookedRoomModel.dart';
import 'package:hotel_grand_capitol/Model/UserModel.dart';
import 'package:hotel_grand_capitol/Screen/DashboardScreen.dart';
import 'package:hotel_grand_capitol/Widgets/ListItemWidget.dart';
import 'package:hotel_grand_capitol/Widgets/NeuButtons.dart';
import 'package:hotel_grand_capitol/Widgets/TextFieldWidget.dart';
import 'package:nb_utils/nb_utils.dart';

class DueCustomersList extends StatefulWidget {
  final List<UserModel> usersList;
  final List<BookedRoomModel> bookedRoomModel;
  final Box<UserModel> userModelBox;
  final Box<BookedRoomModel> bookedRoomModelBox;

  const DueCustomersList({Key key, this.usersList, this.bookedRoomModel, this.userModelBox, this.bookedRoomModelBox})
      : super(key: key);

  @override
  _DueCustomersListState createState() => _DueCustomersListState();
}

class _DueCustomersListState extends State<DueCustomersList> {
  TextEditingController searchController = TextEditingController(text: "");
  TextEditingController checkOutController = TextEditingController();
  String _searchText;
  List<UserModel> filteredList = [];
  List<UserModel> allNewsList = [];
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

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List<UserModel> tempList = [];
      for (int i = 0; i < filteredList.length; i++) {
        if (filteredList[i]
            .phoneNo
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          print("LIST Searched :: ${filteredList[i].phoneNo}");
          tempList.add(filteredList[i]);
        }
      }
      print("This is tempList :: ${tempList}");
      filteredList = tempList;
    }
    print("filtered List :: ${filteredList}");
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: filteredList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListItemWidget(
          userList: filteredList[index],);
        //     .onTap(() => showModalBottomSheet(
        //     context: context,
        //     isScrollControlled: true,
        //     backgroundColor: reddishColor,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20.0),
        //     ),
        //     builder: (context) => Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         height: 300,
        //         width: 600,
        //         alignment: Alignment.center,
        //         child: SingleChildScrollView(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Container(
        //                 width: MediaQuery.of(context)
        //                     .size
        //                     .width *
        //                     0.53,
        //                 child: TextFieldWidget(
        //                   hintText: "Check-Out",
        //                   controller: checkOutController,
        //                   suffixButton: true,
        //                   suffixHeight: 30,
        //                   suffixWidth: 35,
        //                   suffixTitle: "Out",
        //                   suffixOnTap: () async {
        //                     await _checkedOutDate(
        //                         context);
        //                   },
        //                 ),
        //               ),
        //               20.height,
        //               NeuButtons(
        //                 color: bluishColor,
        //                 title: "Modify Check-Out",
        //                 buttonBackground: reddishColor,
        //                 shadow1: Color(0xffcc4747),
        //                 shadow2: Color(0xffff6161),
        //                 onTap: () async {
        //                   Hive.box('betaUserBox2').putAt(
        //                       index,
        //                       UserModel().checkOutDate =
        //                           checkedOutDate
        //                               .toString());
        //
        //                   /// Add for BookedRoomModel too
        //                 },
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ))
        // );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    filteredList = widget.usersList;
    _searchText = searchController.text;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: reddishColor,
        title: Text("All Customers",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: bluishColor)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFieldWidget(
                onChanged: (value) {
                  // searched = true;
                  searchController.addListener(() {
                    print(
                        "THis is length of followed NewsList : ${allNewsList.length}");
                    if (searchController.text.isEmpty) {
                      _searchText = "";
                      filteredList = allNewsList;
                    } else {
                      _searchText = searchController.text;
                    }
                    setState(() {});
                  });
                },
                hintText: "Search Phone Number",
                prefixIcon: true,
                controller: searchController,
              ),
            ),
            20.height,
            Expanded(
              child: searchController.text.isEmpty
                  ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.usersList.length,
                  itemBuilder: (context, index) =>
                      ListItemWidget(userList: widget.usersList[index])
                          // .onTap(() => showModalBottomSheet(
                          // context: context,
                          // isScrollControlled: true,
                          // backgroundColor: reddishColor,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(20.0),
                          // ),
                          // builder: (context) => Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Container(
                          //     height: 300,
                          //     width: 600,
                          //     alignment: Alignment.center,
                          //     child: SingleChildScrollView(
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Container(
                          //             width: MediaQuery.of(context)
                          //                 .size
                          //                 .width *
                          //                 0.53,
                          //             child: TextFieldWidget(
                          //               hintText: "Check-Out",
                          //               controller: checkOutController,
                          //               suffixButton: true,
                          //               suffixHeight: 30,
                          //               suffixWidth: 35,
                          //               suffixTitle: "Out",
                          //               suffixOnTap: () async {
                          //                 await _checkedOutDate(
                          //                     context);
                          //               },
                          //             ),
                          //           ),
                          //           20.height,
                          //           NeuButtons(
                          //             color: bluishColor,
                          //             title: "Modify Check-Out",
                          //             buttonBackground: reddishColor,
                          //             shadow1: Color(0xffcc4747),
                          //             shadow2: Color(0xffff6161),
                          //             onTap: () async {
                          //               print("CHECKOUTDATE 0:: ${checkedOutDate}");
                          //               UserModel userModel = UserModel()
                          //                 ..registrationNumber = widget.usersList[index].registrationNumber
                          //                 ..names = widget.usersList[index].names
                          //                 ..phoneNo = widget.usersList[index].phoneNo
                          //                 ..type = widget.usersList[index].type
                          //                 ..bookingID = widget.usersList[index].bookingID
                          //                 ..paymentMode = widget.usersList[index].paymentMode
                          //                 ..amount = widget.usersList[index].amount
                          //                 ..checkInDate = widget.usersList[index].checkInDate
                          //                 ..checkOutDate = checkedOutDate.toString().substring(0,10)
                          //                 ..roomNo = widget.usersList[index].roomNo
                          //                 ..guestsId = widget.usersList[index].guestsId
                          //                 ..guestImage = widget.usersList[index].guestImage
                          //                 ..pendingAmount = widget.usersList[index].pendingAmount
                          //                 ..updatedAt = DateTime.now();
                          //
                          //               print("CHECKOUTDATE 1 :: ${checkedOutDate}");
                          //
                          //               widget.bookedRoomModel.map((e) {
                          //                 print("REG VALUES :::::  ${widget.usersList[index].registrationNumber}--------${e.regNo} ---------");
                          //
                          //                 if(widget.usersList[index].registrationNumber == e.regNo) {
                          //                   print("REG VALUES ==== ${widget.usersList[index].registrationNumber}  *** ${e.regNo}");
                          //                   int idx =  widget.bookedRoomModel.indexOf(e);
                          //
                          //                   BookedRoomModel room = BookedRoomModel()
                          //                     ..roomNo = e.roomNo
                          //                     ..names = e.names
                          //                     ..regNo = e.regNo
                          //                     ..numberOfPeople = e.numberOfPeople
                          //                     ..checkOutDate = checkedOutDate.toString().substring(0,10)
                          //                     ..checkInDate = e.checkInDate
                          //                     ..bookingID = e.bookingID
                          //                     ..amount = e.amount
                          //                     ..paymentMode = e.paymentMode
                          //                     ..phoneNo = e.phoneNo
                          //                     ..type = e.type
                          //                     ..guestImage = e.type
                          //                     ..guestsId = e.guestsId
                          //                     ..pendingAmount = e.pendingAmount
                          //                     ..roomsChosen = e.roomsChosen;
                          //
                          //                   widget.bookedRoomModelBox.putAt(idx, room);
                          //
                          //                 }
                          //               }).toList();
                          //
                          //               print("CHECKOUTDATE 2 :: ${checkedOutDate}");
                          //
                          //
                          //               widget.userModelBox.putAt(index, userModel);
                          //               print("CHECKOUTDATE 3 :: ${checkedOutDate}");
                          //
                          //
                          //               setState(() {
                          //
                          //               });
                          //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
                          //               // await Hive.box('betaUserBox').putAt(index, userModel);
                          //
                          //               /// Add for BookedRoomModel too
                          //             },
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // )))
              ) : _buildList(),
            ),
          ],
        ),
      ),
    );
  }
}
