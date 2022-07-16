import 'dart:ui';

class AppColors {
  static Color colorAccent = _colorFromHex("#ffc301");
  static Color colorBlack = _colorFromHex("#000000");
  static Color colorWhite = _colorFromHex("#FFFFFF");
  static Color colorBlue = _colorFromHex("#2e6b99");
  static Color colorJambli = _colorFromHex("#673996");
  static Color colorlal = _colorFromHex("#ed212a");
  static Color colortameti = _colorFromHex("#c22549");
  static Color colorbargandi = _colorFromHex("#A0A4A8");

  static Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse('FF' + hexColor, radix: 16));
  }
}
