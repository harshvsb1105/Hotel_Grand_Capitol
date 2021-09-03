import 'package:flutter/material.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Screen/BookingForm.dart';
import 'package:hotel_grand_capitol/Screen/RoomBookingScreen.dart';
import 'package:hotel_grand_capitol/Widgets/DashboardCards.dart';
import 'package:hotel_grand_capitol/Widgets/NeuButtons.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

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
                      height: MediaQuery.of(context).size.height * 0.05,
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
                                SizedBox(height: 10,),
                                Text("Rooms Left", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("Checkout Today", style: TextStyle(color: backgroundColor, fontSize: 18),),
                              ],
                            ),
                          ),
                          DashboardCards(
                            color: bluishColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Yesterday Continue", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("Total Rooms Today", style: TextStyle(color: backgroundColor, fontSize: 18),),
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
                                Text("ARR", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("WalkIn", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("OYO", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("Web", style: TextStyle(color: backgroundColor, fontSize: 18),),
                              ],
                            ),
                          ),
                          DashboardCards(
                            color: reddishColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Cash in Hand", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("Paytm Collection ", style: TextStyle(color: backgroundColor, fontSize: 18),),
                                SizedBox(height: 10,),
                                Text("BTC Amount", style: TextStyle(color: backgroundColor, fontSize: 18),),
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
                            Navigator.push(context, MaterialPageRoute(builder: (_) => RoomBookingScreen()));
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
                          onTap: () {},
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
                          onTap: () {},
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
}
