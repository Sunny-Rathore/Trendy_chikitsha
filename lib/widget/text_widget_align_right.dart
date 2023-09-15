import 'package:flutter/cupertino.dart';


class TextWidgetAlignRight extends StatelessWidget {
  late String text, font_family;
  late FontWeight fontWeight;
  late Color textColor;
  late double fontSize;


  TextWidgetAlignRight(
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
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily:font_family  ,

            color: textColor,
            fontSize: fontSize,));
  }
}
