import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/healer_responses/forgotpass_response.dart';
import 'package:flutter/material.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/widget/text_widget.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:http/http.dart' as http;

class Healer_Forgotpass extends StatefulWidget {
  const Healer_Forgotpass({Key? key}) : super(key: key);

  @override
  State<Healer_Forgotpass> createState() => _Healer_ForgotpassState();
}

class _Healer_ForgotpassState extends State<Healer_Forgotpass> {
  bool isChecked = false, isLoading = false;
  final int? _value = 0;
  final bool _isObscure = false;
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  SharedPreferences? prefs;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    //  saveValue();

    super.initState();
    saveValue();
  }
  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    setState(() {
      
    });
    // _register();
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: ColorUtils.trendyThemeColor,
              elevation: 0.0,
              /*  automaticallyImplyLeading: false,*/
              title: Text('ForgotPassword',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: StringUtils.roboto_font_family,
                    color: ColorUtils.whiteColor,
                    fontSize: 18,
                  )),
              centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.light,
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
                                child: Text('Email',
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
                            const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                            margin:
                            EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorUtils.lightGreyBorderColor),
                              color: ColorUtils.whiteColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /*        new Text('+91 ',
                                                        textAlign:
                                                        TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily: StringUtils
                                                              .roboto_font_family,
                                                          color: ColorUtils
                                                              .blackColor,
                                                          fontSize: 19,
                                                        )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),*/
                                Container(
                                  child: Flexible(
                                    child: TextField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: ColorUtils.b3Color,
                                              fontFamily: StringUtils
                                                  .roboto_font_family_regular,
                                              fontSize: 17),
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
                                          hintText: 'Enter Email'),
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
                              ], //widget
                            )),


                      ],
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10.h),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  if (_emailController.text.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(_emailController.text)) {
                                    showAlertDialog(
                                        context, "Please enter valid email");
                                  } else {
                                   forgotPass();
                                  }
                                },
                                child: SizedBox(
                                    width: 280,
                                    height: 46,
                                    child: ElevatedButton(
                                        child: TextWidget(
                                            'Login',
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
                                                    BorderRadius.circular(10.0),
                                                    side: BorderSide(color: ColorUtils.trendyButtonColor)))),
                                        onPressed: () async {
                                          if (_emailController.text.isEmpty ||
                                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(_emailController
                                                  .text)) {
                                            showAlertDialog(context,
                                                "Please enter valid email");
                                          }else {
                                            forgotPass();
                                          }
                                        }))),
                            SizedBox(
                              height: 2.h,
                            ),

                          ]))),
              SpinKitFadingCircleWidget(isLoading)
            ]))
    );});
  }


  showAlertDialog(BuildContext context, String msg) {
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
                    width: 60.w,
                    child: Text(msg,
                        textAlign: TextAlign.left,
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

  ForgotPassResponse? forgotPassword;

  Future<ForgotPassResponse?> forgotPass() async {
    var data;
    isLoading=true;
    setState(() {

    });
    print('type---    ');
    print('type---    ${prefs!.getString(StringUtils.type).toString()}');
    var request =  http.MultipartRequest('POST', BaseuURL.forgot_password);
    //   request.headers.addAll(headers);
    request.fields['type'] = prefs!.getString(StringUtils.type).toString();
    request.fields['email_id'] = _emailController.text.toString().trim();


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
          print('--->>?   $data');
          if (data["status"] == "true" &&
              data["msg"] ==
                  "Success! An email with a reset password link has been sent to your email address.") {

           forgotPassword =
            ForgotPassResponse.fromJson(jsonDecode(response.body));
              showAlertDialog(context, data["msg"]);
              Future.delayed(const Duration(seconds: 2), () {
                isLoading=false;
                setState(() {

                });
           /*     if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }*/

              });
            } else {
              isLoading=false;
              setState(() {

              });
              showAlertDialog(context, data["msg"]);
            }
          }


        return forgotPassword;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    return null;
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }
}
