import 'package:flutter/material.dart';
import 'package:hotel_grand_capitol/Constants.dart';

class NeuButtons extends StatelessWidget {
  final Function onTap;
  final String title;
  final Color color;
  final double fontSize;
  final Color buttonBackground;
  final Color shadow1;
  final Color shadow2;
  final double height;
  final double width;
  const NeuButtons(
      {Key key,
      this.onTap,
      this.title,
      this.color,
      this.fontSize = 18,
      this.buttonBackground = const Color(0xffE8E8E8),
      this.shadow1 = const Color(
        0xffc5c5c5,
      ),
      this.shadow2 = const Color(0xffffffff),
      this.height = 50,
      this.width = 170})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonBackground,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(offset: Offset(2, 2), blurRadius: 6, color: shadow1),
              BoxShadow(offset: Offset(-2, -2), blurRadius: 6, color: shadow2)
            ]),
        child: Text(
          title,
          style: TextStyle(color: color, fontSize: fontSize),
        ),
      ),
    );
  }
}
