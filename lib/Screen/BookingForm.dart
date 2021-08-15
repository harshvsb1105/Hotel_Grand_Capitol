import 'package:flutter/material.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Widgets/NeuButtons.dart';
import 'package:hotel_grand_capitol/Widgets/TextFieldWidget.dart';
import 'package:nb_utils/nb_utils.dart';

enum Type { OYO, WalkIn }
enum Payment { Paytm, Cash, BTC, WebPortal, Due}


class BookingForm extends StatefulWidget {
  const BookingForm({Key key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  Type _type = Type.OYO;
  Payment _payment = Payment.Paytm;

  String selectedType = "OYO";

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
                  ),
                  25.height,
                  Text("Number of Person", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Person 1",
                  ),
                  10.height,
                  TextFieldWidget(
                    hintText: "Person 2",
                  ),10.height,
                  TextFieldWidget(
                    hintText: "Person 3",
                  ),
                  10.height,
                  Text("Number of People", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Enter number of people",
                  ),
                  Text("Mobile Number", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Enter your mobile number",
                  ),
                  10.height,
                  Text("Type", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  RadioListTile<Type>(
                    title: const Text('OYO'),
                    value: Type.OYO,
                    groupValue: _type,
                    onChanged: (Type value) {
                      setState(() {
                        _type = value;
                      });
                    },
                  ),
                  RadioListTile<Type>(
                    title: const Text('WalkIn'),
                    value: Type.WalkIn,
                    groupValue: _type,
                    onChanged: (Type value) {
                      setState(() {
                        _type = value;
                      });
                    },
                  ),
                  Text("Booking ID(If OYO/Portal)", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Enter your booking id",
                  ),
                  10.height,
                  Text("Payment Mode", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  RadioListTile<Payment>(
                    title: const Text('Paytm'),
                    value: Payment.Paytm,
                    groupValue: _payment,
                    onChanged: (Payment value) {
                      setState(() {
                        _payment = value;
                      });
                    },
                  ),
                  RadioListTile<Payment>(
                    title: const Text('Cash'),
                    value: Payment.Cash,
                    groupValue: _payment,
                    onChanged: (Payment value) {
                      setState(() {
                        _payment = value;
                      });
                    },
                  ),
                  RadioListTile<Payment>(
                    title: const Text('BTC '),
                    value: Payment.BTC,
                    groupValue: _payment,
                    onChanged: (Payment value) {
                      setState(() {
                        _payment = value;
                      });
                    },
                  ),
                  RadioListTile<Payment>(
                    title: const Text('Web Portal'),
                    value: Payment.WebPortal,
                    groupValue: _payment,
                    onChanged: (Payment value) {
                      setState(() {
                        _payment = value;
                      });
                    },
                  ),
                  RadioListTile<Payment>(
                    title: const Text('Due'),
                    value: Payment.Due,
                    groupValue: _payment,
                    onChanged: (Payment value) {
                      setState(() {
                        _payment = value;
                      });
                    },
                  ),
                  Text("Amount", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Enter amount",
                  ),
                  Text("Room Number", style: TextStyle(fontSize: 15, color: bluishColor, fontWeight: FontWeight.bold),),
                  10.height,
                  TextFieldWidget(
                    hintText: "Enter room number",
                  ),
                  20.height,
                  Align(
                    alignment: Alignment.center,
                    child: NeuButtons(
                      title: "Save",
                      onTap: () {},
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
