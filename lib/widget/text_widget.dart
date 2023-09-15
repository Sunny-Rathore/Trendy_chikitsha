import 'package:flutter/cupertino.dart';


class TextWidget extends StatelessWidget {
  late String text, font_family;
  late FontWeight fontWeight;
  late Color textColor;
  late double fontSize;


  TextWidget(
      String text, FontWeight fontWeight, Color textColor, double fontSize, String font_family, {super.key}) {
    this.text = text;
    this.fontWeight = fontWeight;
    this.textColor = textColor;
    this.fontSize = fontSize;
    this.font_family=font_family;
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily:font_family  ,
            fontWeight: fontWeight,
            color: textColor,
            fontSize: fontSize,));
  }
}
