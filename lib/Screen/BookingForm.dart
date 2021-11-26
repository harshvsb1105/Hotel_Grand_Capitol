
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Controllers/BookingController.dart';
import 'package:hotel_grand_capitol/Screen/BookedDetails.dart';
import 'package:hotel_grand_capitol/Screen/RoomBookingScreen.dart';
import 'package:hotel_grand_capitol/Widgets/NeuButtons.dart';
import 'package:hotel_grand_capitol/Widgets/TableView.dart';
import 'package:hotel_grand_capitol/Widgets/TextFieldWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';

enum Type { OYO, WalkIn }
enum Payment { Paytm, Cash, BTC, WebPortal, Due}
enum noOfGuest {one, two, three}



class BookingForm extends StatefulWidget {
  const BookingForm({Key key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  Type type = Type.OYO;
  noOfGuest guestCount = noOfGuest.one;
  Payment payment = Payment.Paytm;
  TextEditingController regController = TextEditingController();
  TextEditingController p1Controller = TextEditingController();
  TextEditingController p2Controller = TextEditingController();
  TextEditingController p3Controller = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController bookingID = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController roomNoController = TextEditingController();
  TextEditingController guestImageController = TextEditingController();
  TextEditingController guestIdController = TextEditingController();
  TextEditingController checkInController = TextEditingController(text: DateTime.now().toString().substring(0,10));
  TextEditingController checkOutController = TextEditingController();

  List<String> selectedRooms = [];
  String selectedType = "OYO";
  String regID;
  DateTime checkedInDate = DateTime.now();
  DateTime checkedOutDate = DateTime.now();
  File images;
  bool checkInChanged = false;


  pickImageGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
        guestImageController.text = image.path;
        images = File(image.path);
    });
    Navigator.pop(context);
  }

  pickImageIDGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
        guestIdController.text = image.path;
    });
    Navigator.pop(context);
  }

  pickImageCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
        guestImageController.text = photo.path;
         });
    Navigator.pop(context);
  }

  pickImageIDCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
        guestIdController.text = photo.path;
        });
    Navigator.pop(context);
  }


  Future<void> _checkedInDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: checkedInDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != checkedInDate)
      setState(() {
        checkedInDate = picked;
        checkInController.text = DateTime.now().toString().substring(0,10);
      });
  }

  Future<void> _checkedOutDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: checkedOutDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != checkedOutDate)
      setState(() {
        checkedOutDate = picked;
        checkOutController.text = checkedOutDate.toString().substring(0,10);
      });
  }


  @override
  void initState() {
  // regID = bookingController.getUid(regID);
  // print("This is regID : $regID");
  super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkBluishColor,
          title: Text("Booking Form"),
          elevation: 0,
        ),
        body: Container(
          color: backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.height,
                  Text("Registration Number", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Enter Registration Number",
                    controller: regController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Registration Number is mandatory';
                      }
                      return null;
                    },
                  ),
                  25.height,
                  Text("Number of People", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  RadioListTile<noOfGuest>(
                    title: const Text('1'),
                    value: noOfGuest.one,
                    groupValue: guestCount,
                    onChanged: (noOfGuest value) {
                      setState(() {
                        guestCount = value;
                      });
                    },
                  ),
                  RadioListTile<noOfGuest>(
                    title: const Text('2'),
                    value: noOfGuest.two,
                    groupValue: guestCount,
                    onChanged: (noOfGuest value) {
                      setState(() {
                        guestCount = value;
                      });
                    },
                  ),
                  RadioListTile<noOfGuest>(
                    title: const Text('3'),
                    value: noOfGuest.three,
                    groupValue: guestCount,
                    onChanged: (noOfGuest value) {
                      setState(() {
                        guestCount = value;
                      });
                    },
                  ),
                  // TextFieldWidget(
                  //   hintText: "Enter number of people",
                  //   controller: numberOfPeopleController,
                  // ),
                  20.height,
                  Text("Name of Person", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Person 1",
                    controller: p1Controller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name of one person is mandatory';
                      }
                      return null;
                    },
                  ),
                  10.height,
                  TextFieldWidget(
                    hintText: "Person 2",
                    controller: p2Controller,
                  ),10.height,
                  TextFieldWidget(
                    hintText: "Person 3",
                    controller: p3Controller,
                  ),
                  20.height,

                  Text("Mobile Number", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    keyboardType: TextInputType.number,
                    hintText: "Enter your mobile number",
                    controller: phoneNoController,
                  ),
                  20.height,
                  Text("Date", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: TextFieldWidget(
                          hintText: DateTime.now().toString().substring(0,10),
                          controller: checkInController,
                          suffixButton: true,
                          suffixTitle: "In",
                          suffixHeight: 30,
                          suffixWidth: 35,
                          suffixOnTap: () async {
                            await _checkedInDate(context);
                            checkInChanged = true;
                          },
                          onSubmit: (val){
                            checkInController.text = val;
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: TextFieldWidget(
                          hintText: "Check-Out",
                          controller: checkOutController,
                          suffixButton: true,
                          suffixHeight: 30,
                          suffixWidth: 35,
                          suffixTitle: "Out",
                          suffixOnTap: () async {
                           await _checkedOutDate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  20.height,
                  Text("Type", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  RadioListTile<Type>(
                    title: const Text('OYO'),
                    value: Type.OYO,
                    groupValue: type,
                    onChanged: (Type value) {
                      setState(() {
                        type = value;
                      });
                    },
                  ),
                  RadioListTile<Type>(
                    title: const Text('WalkIn'),
                    value: Type.WalkIn,
                    groupValue: type,
                    onChanged: (Type value) {
                      setState(() {
                        type = value;
                      });
                    },
                  ),
                  20.height,
                  Text("Booking ID(If OYO/Portal)", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Enter your booking id",
                    controller: bookingID,
                  ),
                  20.height,
                  Text("Payment Mode", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  RadioListTile<Payment>(
                    title: const Text('Paytm'),
                    value: Payment.Paytm,
                    groupValue: payment,
                    onChanged: (Payment value) {
                      setState(() {
                        payment = value;
                      });
                    },
                  ),
                  RadioListTile<Payment>(
                    title: const Text('Cash'),
                    value: Payment.Cash,
                    groupValue: payment,
                    onChanged: (Payment value) {
                      setState(() {
                        payment = value;
                      });
                    },
                  ),
                  RadioListTile<Payment>(
                    title: const Text('BTC '),
                    value: Payment.BTC,
                    groupValue: payment,
                    onChanged: (Payment value) {
                      setState(() {
                        payment = value;
                      });
                    },
                  ),
                  RadioListTile<Payment>(
                    title: const Text('Web Portal'),
                    value: Payment.WebPortal,
                    groupValue: payment,
                    onChanged: (Payment value) {
                      setState(() {
                        payment = value;
                      });
                    },
                  ),
                  RadioListTile<Payment>(
                    title: const Text('Due'),
                    value: Payment.Due,
                    groupValue: payment,
                    onChanged: (Payment value) {
                      setState(() {
                        payment = value;
                      });
                    },
                  ),
                  20.height,
                  Text("Amount", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Enter amount",
                    controller: amountController,
                  ),
                  // 20.height,
                  // Text("Room Number", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  // 10.height,
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.4,
                  //     width: MediaQuery.of(context).size.width,
                  //     child: TableView()
                  // ),
                  // TextFieldWidget(
                  //   hintText: "Enter room number",
                  //   controller: roomNoController,
                  // ),
                  20.height,
                  Text("Guest Image", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Upload the Image",
                    controller: guestImageController,
                   suffixButton: true,
                    suffixHeight: 50,
                    suffixWidth: 170,
                    suffixOnTap: () {
                      showModalBottomSheet(context: context, builder: (context) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeuButtons(
                            title: "Camera",
                            onTap: () {
                              pickImageCamera();
                            },
                          ),
                          20.height,
                          NeuButtons(
                            title: "Gallery",
                            onTap: () {
                              pickImageGallery();
                            },
                          )
                        ],
                      ));
                      },
                  ),
                  20.height,
                  Text("Guest ID Image", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Upload the Image",
                    controller: guestIdController,
                    suffixButton: true,
                    suffixHeight: 50,
                    suffixWidth: 170,
                    suffixOnTap: () {
                      showModalBottomSheet(context: context, builder: (context) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeuButtons(
                            title: "Camera",
                            onTap: () {
                              pickImageIDCamera();
                            },
                          ),
                          20.height,
                          NeuButtons(
                            title: "Gallery",
                            onTap: () {
                              pickImageIDGallery();
                            },
                          )
                        ],
                      ));

                    }
                  ),
                  30.height,
                  Align(
                    alignment: Alignment.center,
                    child: NeuButtons(
                      title: "Save",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RoomBookingScreen(
                          regNo: regController.text,
                          userName: [p1Controller.text, p2Controller.text ?? "", p3Controller.text ?? ""],
                          noOfPeople: guestCount == noOfGuest.one ? "1" : guestCount == noOfGuest.two ? "2" : "3",
                          phoneNo: phoneNoController.text,
                          type: type.toString(),
                          bookingId: bookingID.text,
                          paymentMode: payment.toString(),
                          amount: amountController.text,
                          checkIn: checkInChanged ? checkInController.text : DateTime.now().toString().substring(0,10),
                          checkOut: checkOutController.text,
                          guestImage: guestImageController.text,
                          imageId: guestIdController.text,
                          imageFile: images
                        )));
                      },
                      color: darkBluishColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
