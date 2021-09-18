import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Model/BookedRoomModel.dart';
import 'package:hotel_grand_capitol/Model/UserModel.dart';
import 'package:hotel_grand_capitol/Screen/BookedDetails.dart';
import 'package:hotel_grand_capitol/Screen/BookingForm.dart';
import 'package:hotel_grand_capitol/Screen/RoomBookingScreen.dart';
import 'package:hotel_grand_capitol/Widgets/DashboardCards.dart';
import 'package:hotel_grand_capitol/Widgets/NeuButtons.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<BookedRoomModel> bookedRoomModel = [];
  List<UserModel> userModelList = [];
  List<String> checkInTypeOyo = [];
  List<String> checkInTypeWalkIn = [];
  List<int> amountListPaytm = [];
  List<int> amountListBTC = [];
  List<int> amountListCash = [];
  int sumPaytm;
  int sumBTC;
  int sumCash;


  getDetails() async {
    final userModelBox =  await Hive.openBox<UserModel>('betaUserBox');
    final bookedRoomModelBox = await Hive.openBox<BookedRoomModel>('betaBookedRoomBox');
    setState(() {
      userModelList = userModelBox.values.toList();
      bookedRoomModel = bookedRoomModelBox.values.toList();
    });
    bookedRoomModel.map((e) {
      print("----- ${e.type}");
      if(e.type == "OYO"){
        setState(() {
          checkInTypeOyo.add(e.type);
        });
      } else {
        setState(() {
          checkInTypeWalkIn.add(e.type);
        });
      }
      print("Length of types :: ${checkInTypeOyo.length} && ${checkInTypeWalkIn.length}");
    }).toList();
    userModelList.map((e) {
      if(e.paymentMode == "Paytm"){
        int amount = int.parse(e.amount);
        amountListPaytm.add(amount);
        sumPaytm = amountListPaytm.sum;
        setState(() {});
        print("Paytm pay : $sumPaytm");
      } else if (e.paymentMode == "BTC") {
        int amount = int.parse(e.amount);
        amountListBTC.add(amount);
        sumBTC = amountListBTC.sum;
        setState(() {});
        print("BTC pay : $sumBTC");
      } else {
        int amount = int.parse(e.amount);
        amountListCash.add(amount);
        sumCash = amountListCash.sum;
        setState(() {});
        print("Cash pay : $sumCash");
      }
    }).toList();
  }


  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE8E8E8),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                color: reddishColor,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(height: 20),
                    Text("Hotel Grand Capitol",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: bluishColor)),
                    Text("Date - ${DateFormat.yMMMMd().format(DateTime.now()).toString()}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: backgroundColor))
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashboardCards(
                            color: reddishColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Rooms Occupied", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 5,),
                                Text(bookedRoomModel.length.toString(), style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("Rooms Left", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 5,),
                                Text("${_dummyData.length - bookedRoomModel.length}", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                // Text("Checkout Today", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                // SizedBox(height: 5,),
                                // Text("7", style: TextStyle(color: backgroundColor, fontSize: 18),),
                              ],
                            ),
                          ),
                          DashboardCards(
                            color: bluishColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Yesterday Continue", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 5,),
                                Text("8", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("Total Rooms Today", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 5,),
                                Text("8", style: TextStyle(color: backgroundColor, fontSize: 18),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashboardCards(
                            color: bluishColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    // Text("ARR - ", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                    // SizedBox(width: 5,),
                                    // Text("7", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                    SizedBox(width: 6,),
                                    Text("WalkIn - ", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                    SizedBox(width: 5,),
                                    Text(checkInTypeWalkIn.length.toString(), style: TextStyle(color: backgroundColor, fontSize: 18),),
                                    SizedBox(width: 6,),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text("OYO - ", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                    SizedBox(width: 3,),
                                    Text(checkInTypeOyo.length.toString(), style: TextStyle(color: backgroundColor, fontSize: 18),),
                                    SizedBox(width: 6,),
                                    // Text("Web - ", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                    // SizedBox(width: 3,),
                                    // Text("2", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                  ],
                                )

                              ],
                            ),
                          ),
                          DashboardCards(
                            color: reddishColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Cash in Hand", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 5,),
                                Text(sumCash != null ? sumCash.toString() : "0", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("Paytm Collection ", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 5,),
                                Text(sumPaytm != null ? sumPaytm.toString() : "0", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("BTC Amount", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 5,),
                                Text(sumBTC != null ? sumBTC.toString() : "0", style: TextStyle(color: backgroundColor, fontSize: 18),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NeuButtons(
                          title: "New Booking Form",
                          color: reddishColor,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookingForm()));
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: NeuButtons(
                          title: "Rooms View",
                          color: bluishColor,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => RoomBookingScreen(dashboard: true,)));
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NeuButtons(
                          title: "Expanses",
                          color: reddishColor,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => BookedDetails()));

                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: NeuButtons(
                          title: "Stay Extension",
                          color: bluishColor,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookedDetails()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
}
