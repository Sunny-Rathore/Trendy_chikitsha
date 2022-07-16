import 'package:flutter/cupertino.dart';


class TextWidgetAlignCenter extends StatelessWidget {
  late String text, font_family;
  late FontWeight fontWeight;
  late Color textColor;
  late double fontSize;


  TextWidgetAlignCenter(
      String text, FontWeight fontWeight, Color textColor, double fontSize, String font_family) {
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

            color: textColor,
            fontSize: fontSize,));
  }
}
