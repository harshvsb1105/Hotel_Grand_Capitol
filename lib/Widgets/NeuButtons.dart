import 'package:flutter/material.dart';

class NeuButtons extends StatelessWidget {
  final Function onTap;
  final String title;
  final Color color;
  final double fontSize;
  const NeuButtons({Key key, this.onTap, this.title, this.color, this.fontSize = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 170,
        decoration: BoxDecoration(
          color: Color(0xffE8E8E8),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 6,
              color: Color(0xffc5c5c5,)
            ),
            BoxShadow(
                offset: Offset(-2, -2),
                blurRadius: 6,
                color: Color(0xffffffff)
            )
          ]
        ),
        child: Text(title, style: TextStyle(
          color: color,
          fontSize: fontSize
        ),),
      ),
    );
  }
}
