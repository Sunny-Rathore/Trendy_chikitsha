import 'dart:convert';

import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/models/client_responses/client_login_response.dart';
import 'package:doctor/models/healer_responses/healer_change_password_response.dart';
import 'package:doctor/models/healer_responses/healer_login_response.dart';
import 'package:doctor/page/Client/Client_menu/pages/Client_Home_Menu.dart';
import 'package:doctor/page/Healer/Choose%20Your%20Expertise/Choose_your_expertise.dart';
import 'package:doctor/page/Healer/Choose%20Your%20Expertise/HealerChooseExperties.dart';
import 'package:doctor/page/Healer/Healer%20Register/Healer_Forgotpass.dart';
import 'package:doctor/page/Healer/Healer%20Register/Healer_Register.dart';
import 'package:doctor/page/Healer/Healer_menu/Healer_Menu.dart';
import 'package:doctor/page/Healer/Healer_menu/Menu%20Pages/Home_Menu.dart';
import 'package:doctor/page/Healer/Healer_menu/Payment/payment_mode.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/healer_pricing_plan.dart';
import 'package:doctor/page/LoginPage.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:doctor/widget/text_widget.dart';
import 'package:doctor/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:http/http.dart' as http;

class HealerChangePassword extends StatefulWidget {
  const HealerChangePassword({Key? key}) : super(key: key);

  @override
  State<HealerChangePassword> createState() => HealerChangePasswordState();
}

class HealerChangePasswordState extends State<HealerChangePassword> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = true.obs;
  bool isChecked = false, isLoading=false;
  int? _value = 0;
  bool _isNewObscure = true,_isOldObscure = true,_isConfirmObscure = true;
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  SharedPreferences? prefs;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    //  saveValue();

    super.initState();
    saveValue();
  }

  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    // _register();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
            /*  resizeToAvoidBottomInset: false,*/
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                brightness: Brightness.dark,
                toolbarHeight: 60,
                backgroundColor: ColorUtils.trendyThemeColor,
                elevation: 0.0,
                /*  automaticallyImplyLeading: false,*/
                title: Text('Change Password',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.whiteColor,
                      fontSize: 18,
                    )),
                centerTitle: true,
                /*   flexibleSpace: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: [AppColors.colorlal, AppColors.colorJambli],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),*/
              ),
              body: Stack(children: [
                SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 0, top: 15.h, bottom: 10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 3.h),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(' Old Password',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: StringUtils.roboto_font_family,
                                        color: ColorUtils.blackColor,
                                        fontSize: 17,
                                      )))),
                          Container(
                            height: 7.h,
                            width: 100.w,
                            padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                            margin:
                            EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorUtils.lightGreyBorderColor),
                              color: ColorUtils.whiteColor,
                            ),
                            child: new Container(
                              child: new Flexible(
                                child: new TextField(
                                  controller: _oldPasswordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  textAlign: TextAlign.left,
                                  obscureText: !_isOldObscure,
                                  decoration: new InputDecoration(
                                      hintStyle: TextStyle(
                                          color: ColorUtils.b3Color,
                                          fontFamily: StringUtils
                                              .roboto_font_family_regular,
                                          fontSize: 17),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _isOldObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isOldObscure = !_isOldObscure;
                                            });
                                          }),
                                      labelStyle: TextStyle(
                                          color: ColorUtils
                                              .textFormFieldLabelColor,
                                          fontFamily:
                                          StringUtils.roboto_font_family,
                                          fontSize: 17),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Enter old password'),
                                  onChanged: (text) {
                                    setState(() {
                                      /*   customer_mobile =
                                                            text
                                                                .toString();*/
                                    });
                                  },
                                ),
                              ), //flexible
                            ), //container
                          ),
                          Padding(
                              padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 3.h),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(' New Password',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: StringUtils.roboto_font_family,
                                        color: ColorUtils.blackColor,
                                        fontSize: 17,
                                      )))),
                          Container(
                              height: 7.h,
                              width: 100.w,
                              padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                              margin:
                              EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: ColorUtils.lightGreyBorderColor),
                                color: ColorUtils.whiteColor,
                              ),
                              child: new Container(
                                    child: new Flexible(
                                      child: new TextField(
                                        controller: _passwordController,
                                        keyboardType: TextInputType.visiblePassword,
                                        textAlign: TextAlign.left,
                                        obscureText: !_isNewObscure,
                                        decoration: new InputDecoration(
                                            hintStyle: TextStyle(
                                                color: ColorUtils.b3Color,
                                                fontFamily: StringUtils
                                                    .roboto_font_family_regular,
                                                fontSize: 17),
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isNewObscure
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isNewObscure = !_isNewObscure;
                                                  });
                                                }),
                                            labelStyle: TextStyle(
                                                color: ColorUtils
                                                    .textFormFieldLabelColor,
                                                fontFamily:
                                                StringUtils.roboto_font_family,
                                                fontSize: 17),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: 'Enter new password'),
                                        onChanged: (text) {
                                          setState(() {
                                            /*   customer_mobile =
                                                            text
                                                                .toString();*/
                                          });
                                        },
                                      ),
                                    ), //flexible
                                  ), //container
                                ),
                          Padding(
                              padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 3.h),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Confirm Password',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: StringUtils.roboto_font_family,
                                        color: ColorUtils.blackColor,
                                        fontSize: 17,
                                      )))),
                          Container(
                            height: 7.h,
                            width: 100.w,
                            padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                            margin:
                            EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w,bottom: 3.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorUtils.lightGreyBorderColor),
                              color: ColorUtils.whiteColor,
                            ),
                            child: new Container(
                              child: new Flexible(
                                child: new TextField(
                                  controller: _confirmPasswordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  textAlign: TextAlign.left,
                                  obscureText: !_isConfirmObscure,
                                  decoration: new InputDecoration(
                                      hintStyle: TextStyle(
                                          color: ColorUtils.b3Color,
                                          fontFamily: StringUtils
                                              .roboto_font_family_regular,
                                          fontSize: 17),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _isConfirmObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isConfirmObscure = !_isConfirmObscure;
                                            });
                                          }),
                                      labelStyle: TextStyle(
                                          color: ColorUtils
                                              .textFormFieldLabelColor,
                                          fontFamily:
                                          StringUtils.roboto_font_family,
                                          fontSize: 17),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Enter confirm password'),
                                  onChanged: (text) {
                                    setState(() {
                                      /*   customer_mobile =
                                                            text
                                                                .toString();*/
                                    });
                                  },
                                ),
                              ), //flexible
                            ), //container
                          ),

                          SizedBox(height: 5.h,),
                        ],
                      ),
                    )),

                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5.h),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (_oldPasswordController.text.length == 0) {
                                      showAlertDialog(
                                          context, "Please enter old password");
                                    } else if (_passwordController
                                        .text.length ==
                                        0) {
                                      showAlertDialog(
                                          context, "Please enter new password");
                                    } else if (_confirmPasswordController
                                        .text.length ==
                                        0) {
                                      showAlertDialog(
                                          context, "Please enter confirm password");
                                    }else if (_confirmPasswordController
                                        .text.toString().trim() !=
                                      _passwordController.text.toString().trim()) {
                                      showAlertDialog(
                                          context, "Confirm password does not match with new password.");
                                    }else {
                                     healerChangePass();
                                    }
                                  },
                                  child: SizedBox(
                                      width: 280,
                                      height: 46,
                                      child: ElevatedButton(
                                          child: TextWidget(
                                              'Continue',
                                              FontWeight.normal,
                                              ColorUtils.whiteColor,
                                              19,
                                              StringUtils.roboto_font_family),
                                          style: ButtonStyle(
                                              elevation:
                                              MaterialStateProperty.all(10),
                                              foregroundColor: MaterialStateProperty.all<Color>(
                                                  ColorUtils.trendyButtonColor),
                                              backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  ColorUtils
                                                      .trendyButtonColor),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      new BorderRadius.circular(10.0),
                                                      side: BorderSide(color: ColorUtils.trendyButtonColor)))),
                                          onPressed: () async {
                                            if (_oldPasswordController.text.length == 0) {
                                              showAlertDialog(
                                                  context, "Please enter old password");
                                            } else if (_passwordController
                                                .text.length ==
                                                0) {
                                              showAlertDialog(
                                                  context, "Please enter new password");
                                            } else if (_confirmPasswordController
                                                .text.length ==
                                                0) {
                                              showAlertDialog(
                                                  context, "Please enter new password");
                                            }else if (_confirmPasswordController
                                                .text.toString().trim() !=
                                                _passwordController.text.toString().trim()) {
                                              showAlertDialog(
                                                  context, "Confirm password does not match with new password.");
                                            }else {
                                              healerChangePass();
                                            }
                                          }))),
                              SizedBox(
                                height: 2.h,
                              ),

                            ]))), SpinKitFadingCircleWidget(isLoading)
              ])));
    });
  }

  Future<String?> healerChangePass() async {
    isLoading=true;
    setState(() {

    });
    var data;
    print('Healer Change Password   ${prefs!.getString(StringUtils.id).toString()}');
    var request = http.MultipartRequest('POST', BaseuURL.healer_change_password);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['oldpassword'] = _oldPasswordController.text.toString().trim();
    request.fields['newpassword'] = _passwordController.text.toString().trim();

    // var res = await request.send();

    request
        .send()
        .then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          print("Uploaded! ");
          print('response.body ' + response.body);

          var jsonData = response.body;
          print(jsonData);
          data = json.decode(response.body);

          var rest1 = data["msg"];
          data = json.decode(response.body);
          print('--->>?   ${data}');

            if (data["status"] == "true" &&
                (data["msg"] ==
                    "Password Changed Successfully!!!"  )) {
              HealerChangePassResponse changePassResponse =
              HealerChangePassResponse.fromJson(jsonDecode(response.body));

                showSnackBar(context, data["msg"]);
              prefs!.setString(StringUtils.completeProfile, "No");
              prefs!.setString(StringUtils.id, "");
              prefs!.setString(StringUtils.unique_id, "");
              prefs!.setString(StringUtils.type, "");


                prefs!.setString(StringUtils.completeProfile, "NO");
                Future.delayed(Duration(seconds: 2), () {
                  isLoading=false;
                  setState(() {

                  });
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => LoginPage(),
                    ),
                        (route) => false,//if you want to disable back feature set to false
                  );
                });

              }


        }

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: 60.w,
                    child: Text(msg,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            fontSize: 18)))),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: ColorUtils.appDarkBlueColor,
                        fontSize: 18))),
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

  showSnackBar(
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
}
