import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Model/UserModel.dart';
import 'package:nb_utils/nb_utils.dart';

class ListItemWidget extends StatefulWidget {
final UserModel userList;
  ListItemWidget({this.userList});

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  File image;

  createImage() {
    image = File(widget.userList.guestImage);
    setState(() {

    });
  }

  @override
  void initState() {
    createImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color(0xffEDEEF2),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 4,
              color: Color(0xff9F9F9F),
            )
          ]),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            // gradient: backgroundGradientColor(context),
            border: Border.all(color: Color(0xffF8F8FC)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-2, -2),
                  blurRadius: 6,
                  color: Color(0xffFFFFFF))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 178,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  // gradient: backgroundGradientColor(context),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Registration Number - ${widget.userList.registrationNumber}",
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: bluishColor),
                  ),
                  5.height,
                  Text(
                    "Name - ${widget.userList.names.first}",
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: darkBluishColor),
                    // style: fontStyle(14, FontWeight.w500),
                  ),
                  5.height,
                  Text(
                    "Room number -",
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: darkBluishColor),
                    // style: fontStyle(14, FontWeight.w500),
                  ),
                  Row(
                    children: widget.userList.roomNo.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$e", style: TextStyle(
                          fontFamily: "Avenir",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: darkBluishColor),),
                    )).toList(),
                  ),
                  5.height,
                  Text(
                    "CheckIn - ${widget.userList.checkInDate}",
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: darkBluishColor),
                    // style: fontStyle(14, FontWeight.w500),
                  ),
                  5.height,
                  Text(
                    "CheckOut - ${widget.userList.checkOutDate}",
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: darkBluishColor),
                    // style: fontStyle(14, FontWeight.w500),
                  ),
                ],
              ),
            ).expand(),
            8.width,
            Container(
              height: 178, width: 145,
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  ),
              child: Image.file(image, fit: BoxFit.cover,),
            ),
          ],
        ),
      ),
    );
  }
}
