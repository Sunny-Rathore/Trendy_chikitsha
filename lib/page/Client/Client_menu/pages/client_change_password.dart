import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_change_password_response.dart';
import 'package:trendy_chikitsa/page/Client/Client_menu/pages/Client_Home_Menu.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/widget/text_widget.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ClientChangePassword extends StatefulWidget {
  String from_page = "";

  ClientChangePassword({super.key});

  @override
  ClientChangePasswordstate createState() => ClientChangePasswordstate();

/* StudentLogin({
    Key? key,
    required this.from_page,
  }) : super(key: key);*/
}

class ClientChangePasswordstate extends State<ClientChangePassword> {
  static const String routeName = '/homePage';
  String appointment_Status = 'Pending Appointment';
  String customer_mobile = '', age = '', phone_no = '', pickup_address = '';
  String dropdownvalue = 'Select Gender';
  bool isVisible = false, isLoading = false;
  SharedPreferences? prefs;
  var items = [
    'Select Gender',
    'Male',
    'Female',
    'Other',
  ];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();
  var isPasswordHidden = true.obs;
  bool isChecked = false;
  final int? _value = 0;
  bool _isNewObscure = false, _isOldObscure = false, _isConfirmObscure = false;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
              /*  resizeToAvoidBottomInset: false,*/
              extendBodyBehindAppBar: true,
              appBar: AppBar(
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
                systemOverlayStyle: SystemUiOverlayStyle.light,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        margin:
                            EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ColorUtils.lightGreyBorderColor),
                          color: ColorUtils.whiteColor,
                        ),
                        child: TextField(
                          controller: _oldPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.left,
                          obscureText: !_isOldObscure,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: ColorUtils.b3Color,
                                  fontFamily:
                                      StringUtils.roboto_font_family_regular,
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
                                  color: ColorUtils.textFormFieldLabelColor,
                                  fontFamily: StringUtils.roboto_font_family,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        margin:
                            EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ColorUtils.lightGreyBorderColor),
                          color: ColorUtils.whiteColor,
                        ),
                        child: TextField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.left,
                          obscureText: !_isNewObscure,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: ColorUtils.b3Color,
                                  fontFamily:
                                      StringUtils.roboto_font_family_regular,
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
                                  color: ColorUtils.textFormFieldLabelColor,
                                  fontFamily: StringUtils.roboto_font_family,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        margin: EdgeInsets.only(
                            top: 1.h, left: 8.w, right: 8.w, bottom: 3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ColorUtils.lightGreyBorderColor),
                          color: ColorUtils.whiteColor,
                        ),
                        child: TextField(
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.left,
                          obscureText: !_isConfirmObscure,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: ColorUtils.b3Color,
                                  fontFamily:
                                      StringUtils.roboto_font_family_regular,
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
                                  color: ColorUtils.textFormFieldLabelColor,
                                  fontFamily: StringUtils.roboto_font_family,
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
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
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
                                    if (_oldPasswordController.text.isEmpty) {
                                      showAlertDialog(
                                          context, "Please enter old password");
                                    } else if (_passwordController
                                        .text.isEmpty) {
                                      showAlertDialog(
                                          context, "Please enter new password");
                                    } else if (_confirmPasswordController
                                        .text.isEmpty) {
                                      showAlertDialog(context,
                                          "Please enter confirm password");
                                    } else if (_confirmPasswordController.text
                                            .toString()
                                            .trim() !=
                                        _passwordController.text
                                            .toString()
                                            .trim()) {
                                      showAlertDialog(context,
                                          "Confirm password does not match with new password.");
                                    } else {
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
                                                          BorderRadius.circular(10.0),
                                                      side: BorderSide(color: ColorUtils.trendyButtonColor)))),
                                          onPressed: () async {
                                            if (_oldPasswordController
                                                .text.isEmpty) {
                                              showAlertDialog(context,
                                                  "Please enter old password");
                                            } else if (_passwordController
                                                .text.isEmpty) {
                                              showAlertDialog(context,
                                                  "Please enter new password");
                                            } else if (_confirmPasswordController
                                                .text.isEmpty) {
                                              showAlertDialog(context,
                                                  "Please enter new password");
                                            } else if (_confirmPasswordController
                                                    .text
                                                    .toString()
                                                    .trim() !=
                                                _passwordController.text
                                                    .toString()
                                                    .trim()) {
                                              showAlertDialog(context,
                                                  "Confirm password does not match with new password.");
                                            } else {
                                              healerChangePass();
                                            }
                                          }))),
                              SizedBox(
                                height: 2.h,
                              ),
                            ]))),
                SpinKitFadingCircleWidget(isLoading)
              ])));
    });
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: Container(
          height: 50,
          alignment: Alignment.center,
          color: ColorUtils.trendyButtonColor,
          child: const Text(
            "Alert !!",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          )),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     GestureDetector(
      //         onTap: () {
      //           Navigator.of(context).pop();
      //         },
      //         child:SizedBox( width: 60.w,child:Text(msg,
      //             textAlign: TextAlign.left,
      //             style: const TextStyle(
      //                 fontWeight: FontWeight.normal,
      //                 color: Colors.black87,
      //                 fontSize: 18)))),
      //   ],
      // ),

      content: Row(
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
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorUtils.trendyButtonColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("OK",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: ColorUtils.appDarkBlueColor,
                            fontSize: 18)),
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<String?> healerChangePass() async {
    isLoading = true;
    setState(() {});
    var data;
    print(
        'Healer Change Password   ${prefs!.getString(StringUtils.id).toString()}');
    var request = http.MultipartRequest('POST', BaseuURL.clientChangePassword);

    request.fields['client_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['oldpassword'] =
        _oldPasswordController.text.toString().trim();
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
              print('--->>?   $data');

              if (data["status"] == "true" &&
                  (data["msg"] == "Password Changed Successfully!!!")) {
                HealerChangePassResponse changePassResponse =
                    HealerChangePassResponse.fromJson(
                        jsonDecode(response.body));

                showSnackBar(context, data["msg"]);
                /*    prefs!.setString(StringUtils.completeProfile, "No");
            prefs!.setString(StringUtils.id, "");
            prefs!.setString(StringUtils.unique_id, "");
            prefs!.setString(StringUtils.type, "");


            prefs!.setString(StringUtils.completeProfile, "NO");*/
                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  setState(() {});
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Client_Home_Menu()));

                  /*    Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => LoginPage(),
                ),
                    (route) => false,//if you want to disable back feature set to false
              );*/
                });
              } else {
                showAlertDialog(context, data["response"]);
                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  setState(() {});
                });
              }
            }

            return response.body;
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    return null;
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }
/*  Future<String?> changePassword() async {
    var data;
   var request = http.MultipartRequest(
        'POST', BaseuURL.clientChangePassword);
    //   request.headers.addAll(headers);
    request.fields['client_id'] = prefs!.getString(StringUtils.student_id).toString();
   request.fields['oldpassword'] = _oldPasswordController.text.toString();
    request.fields['newpassword'] = _newPasswordController.text.toString();
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


      */ /*    if (data["status"] == "true" &&
              data["msg"] == "Password Changed Successfully!!!") {
            print('Password Changed Successfully!!!    ');
            StudentLoginResponse loginUser = StudentLoginResponse.fromJson(
                jsonDecode(response.body));
            print(loginUser.response!.sId.toString());
            prefs!.setString(StringUtils.student_id, "");
            prefs!.setString(StringUtils.class_id, "");
            prefs!.setString(StringUtils.user_type, "");
            prefs!.setString(StringUtils.class_section, "");
            prefs!.setString(StringUtils.s_name, "");
            prefs!.setString(StringUtils.s_mobile, "");
            prefs!.setString(StringUtils.email, "");
            prefs!.setString(StringUtils.dob, "");
            prefs!.setString(StringUtils.city, "");
            prefs!.setString(StringUtils.state, "");
            prefs!.setString(StringUtils.zipcode, "");
            UtilMethods.showSnackBar(context, "Password changed successful!!!");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ChooseRole()),
                    (route) => false);
            //  showAlertDialog(context, "Uploaded KYC successfully" );
          } else {
            showAlertDialog(context,data["msg"]);
            UtilMethods.showSnackBar(context, data["msg"]);
          }*/ /*
        }

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }*/

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
