import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:flutter/material.dart';

class UtilMethods {
  static showErrorAlertDialog(BuildContext context, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Ok",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorUtils.appDarkBlueColor,
              fontSize: 20)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: Text("Error",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: ColorUtils.appDarkBlueColor,
                fontSize: 15)),
        content: Text(msg,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black87,
                fontSize: 18)),
        actions: [
          okButton,
        ]);
    /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.appBlueColor,
                        fontSize: 16))),
          ],
        ));*/

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialog(BuildContext context, String msg, bool closeScreen) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                    width: 220,
                    child: Text(msg,
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            fontSize: 18)))),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();

                  if (closeScreen) {
                    Navigator.pop(context);
                  }
                },
                child: Text("Ok",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.appDarkBlueColor,
                        fontSize: 20))),
          ],
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSnackBar(
    BuildContext context,
    String msg,
  ) {
    final snackBar = SnackBar(
      content: Text(msg),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // set up the AlertDialog
}
