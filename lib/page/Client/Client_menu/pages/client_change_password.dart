import 'dart:collection';
import 'dart:convert';

import 'dart:ui';

import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/global/global.dart';
import 'package:doctor/page/Healer/Healer%20Register/Healer_Forgotpass.dart';
import 'package:doctor/page/Healer/Healer%20Register/Healer_Register.dart';
import 'package:doctor/page/Healer/Healer_menu/Menu%20Pages/Home_Menu.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:doctor/utils/utils_methods.dart';
import 'package:doctor/widget/text_widget.dart';
import 'package:doctor/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ClientChangePassword extends StatefulWidget {
  String from_page = "";

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
  String customer_mobile = '',
      age = '',
      phone_no = '',
      pickup_address = '';
  String dropdownvalue = 'Select Gender';
  bool isVisible = false,
      isLoading = false;
  SharedPreferences? prefs;
  var items = [
    'Select Gender',
    'Male',
    'Female',
    'Other',
  ];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = true.obs;
  bool isChecked = false;
  int? _value = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final myController = TextEditingController();
  TextEditingController  _newPasswordController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();
  }


  @override
  Widget build(BuildContext context) {
    print(
        'responsive---    ${MediaQuery
            .of(context)
            .size
            .width}  ${MediaQuery
            .of(context)
            .size
            .height}');
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          builder: (context, widget) {
            // TODO: implement build
            return new Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: true,
                backgroundColor: ColorUtils.whiteColor.withOpacity(1),
                appBar: AppBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                  elevation: 5,
                  backgroundColor: ColorUtils.whatsapp_icon_color,
                  title: Text(
                    "Change Password",
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.whiteColor,
                      letterSpacing: 0.15,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  /*     actions: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(3, 0, 20, 00),
                        child: SvgPicture.asset(
                          'assets/images/profile.svg',
                          height: 22,
                          width: 22,
                        )))
              ],*/
                  /*       leading: new IconButton(
                icon: new Icon(
                  Icons.menu,
                  color: ColorUtils.appDarkBlueColor,
                  size: 20,
                ),
              onPressed: (){},
              *//*  onPressed: () => _scaffoldKey.currentState!.openDrawer(),*//*
              ),*/
                ),
                body:  SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 80),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                        TextFormField(
                        obscureText: isPasswordHidden.value,
                          decoration: InputDecoration(
                              hintText: 'Old Password',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              suffix: InkWell(
                                child: Icon(
                                  isPasswordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                onTap: () {
                                  isPasswordHidden.value =
                                  !isPasswordHidden.value;
                                },
                              )),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field cannot be empty';
                            } else if (value.length < 5) {
                              return "must be at least 6 chars";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                            TextFormField(
                              obscureText: isPasswordHidden.value,
                              decoration: InputDecoration(
                                  hintText: 'New Password',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffix: InkWell(
                                    child: Icon(
                                      isPasswordHidden.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    onTap: () {
                                      isPasswordHidden.value =
                                      !isPasswordHidden.value;
                                    },
                                  )),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'field cannot be empty';
                                } else if (value.length < 5) {
                                  return "must be at least 6 chars";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                                  () => TextFormField(
                                obscureText: isPasswordHidden.value,
                                decoration: InputDecoration(
                                    hintText: 'Confirm Password',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.lock),
                                    suffix: InkWell(
                                      child: Icon(
                                        isPasswordHidden.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onTap: () {
                                        isPasswordHidden.value =
                                        !isPasswordHidden.value;
                                      },
                                    )),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'field cannot be empty';
                                  } else if (value.length < 5) {
                                    return "must be at least 6 chars";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),


                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
                                    child: SizedBox(
                                        width: 280,
                                        height: 46,
                                        child: ElevatedButton(
                                            child: TextWidget(
                                                'Submit',
                                                FontWeight.normal,
                                                ColorUtils.whiteColor,
                                                19,
                                                StringUtils.roboto_font_family),
                                            style: ButtonStyle(
                                                elevation: MaterialStateProperty.all(20),
                                                foregroundColor: MaterialStateProperty.all<Color>(
                                                    ColorUtils.headerTextColor),
                                                backgroundColor: MaterialStateProperty.all<Color>(
                                                    ColorUtils.headerTextColor),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                        new BorderRadius.circular(30.0),
                                                        side: BorderSide(
                                                            color: ColorUtils.headerTextColor)))),
                                            onPressed: () {

                                            }))))
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          });
    });
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
                child:Container( width: 60.w,child:Text(msg,
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
  Future<String?> changePassword() async {
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


      /*    if (data["status"] == "true" &&
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
          }*/
        }

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }
}
