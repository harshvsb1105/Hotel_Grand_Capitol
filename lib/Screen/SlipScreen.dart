import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:printing/printing.dart';

class SlipScreen extends StatefulWidget {
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
  final List<String> roomNo;
  final File image;

  const SlipScreen(
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
      this.dashboard,
      this.checkIn,
      this.checkOut, this.roomNo, this.image})
      : super(key: key);

  @override
  _SlipScreenState createState() => _SlipScreenState();
}

class _SlipScreenState extends State<SlipScreen> {
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  List<Widget> roomWidget = [];

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  List<Widget> roomList() {
    widget.roomNo.map((e) {
      setState(() {
        roomWidget.add(Text(e, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),));
      });
    }).toList();
    return roomWidget;
  }
  @override
  void initState() {
    roomList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButton: FloatingActionButton(
          child: Text("Print"),
          onPressed: () {
            _printScreen();
          },
        ),
        body: RepaintBoundary(
          key: _printKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Slip", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                ),
                50.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date - ${widget.checkIn}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                    Text("Time - ${TimeOfDay.now().format(context)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                  ],
                ),
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Registration Number - ${widget.regNo}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                        13.height,
                        Text("Guest Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                        10.height,
                        Text("1. ${widget.userName.first}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                        5.height,
                        Text("2. _____", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                        5.height,
                        Text("3. _____", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    Container(
                      height: 180,
                      width: 130,
                      color: Colors.blue,
                      child: Image.file(widget.image, fit: BoxFit.cover,),
                    )
                  ],
                ),
                20.height,
                Text("Mobile Number - ${widget.phoneNo}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                10.height,
                Text("Booking ID - ${widget.bookingId}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                20.height,
                Row(
                  children: [
                    Row(
                      children: [
                        Text("Room Number -", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                        10.width,
                        Column(
                          children: roomWidget.map((e) =>  Container(
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: e
                          )).toList(),
                        ),

                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 60,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                      child: Text("Amount - ${widget.amount}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
