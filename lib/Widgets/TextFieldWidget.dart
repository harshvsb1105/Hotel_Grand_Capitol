import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_grand_capitol/Constants.dart';
import 'package:hotel_grand_capitol/Widgets/NeuButtons.dart';
import 'package:nb_utils/nb_utils.dart';

class TextFieldWidget extends StatelessWidget {
  final Function(String) onSubmit;
  final String hintText;
  final bool prefixIcon;
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool suffix;
  final Function suffixOnPressed;
  final String suffixTitle;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final Function(String) validator;
  final TextInputType keyboardType;
  final Widget suffixWidget;
  final bool boxShape;
  final bool suffixButton;
  final Function suffixOnTap;
  final double suffixHeight;
  final double suffixWidth;

  const TextFieldWidget(
      {Key key,
      this.onSubmit,
      this.hintText,
      this.prefixIcon = false,
      this.controller,
      this.onChanged,
      this.suffix = false,
      this.suffixOnPressed,
      this.suffixTitle = "Upload",
      this.minLines,
      this.maxLines,
      this.maxLength,
      this.validator,
      this.keyboardType,
      this.boxShape = false,
      this.suffixWidget,
      this.suffixOnTap,
      this.suffixButton = false, this.suffixHeight, this.suffixWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        border: NeumorphicBorder(
          color: Color(0xFFffffff),
          width: 1,
        ),
        shadowDarkColorEmboss: Color(0xFF9D9D9D),
        intensity: 0.6,
        color: backgroundColor,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
        depth: -1.5,
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          shadowDarkColorEmboss: Color(0xFF9D9D9D),
          intensity: 0.4,
          color: backgroundColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          depth: -3,
        ),
        child: TextFormField(
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: suffixButton
              ? InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      hintText: hintText,
                      prefixIcon: prefixIcon ? Icon(Icons.search) : null,
                      hintStyle: TextStyle(color: Color(0xFF575F6B)))
                  .copyWith(
                      suffixIcon: NeuButtons(
                  title: suffixTitle,
                  color: Color(0xFF575F6B),
                  fontSize: 10,
                  onTap: suffixOnTap,
                        height: suffixHeight,
                        width: suffixWidth,
                ).paddingAll(10).visible(true))
              : InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  hintText: hintText,
                  prefixIcon: prefixIcon ? Icon(Icons.search) : null,
                  hintStyle: TextStyle(color: Color(0xFF575F6B))),
          onFieldSubmitted: onSubmit,
          onChanged: onChanged,
          // initialValue: name,
        ),
      ),
    );
  }
}
