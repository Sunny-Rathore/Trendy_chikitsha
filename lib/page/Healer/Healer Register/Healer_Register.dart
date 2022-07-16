import 'dart:convert';

import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/global/global.dart';
import 'package:doctor/models/client_responses/client_register_response.dart';
import 'package:doctor/models/healer_responses/healer_register_response.dart';
import 'package:doctor/page/Healer/Healer_menu/Menu%20Pages/Home_Menu.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/healer_pricing_plan.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:doctor/utils/utils_methods.dart';
import 'package:doctor/widget/text_widget.dart';
import 'package:doctor/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Healer_Login.dart';
import 'MyRadioListTile.dart';

class Healer_Register extends StatefulWidget {
  const Healer_Register({Key? key}) : super(key: key);

  @override
  State<Healer_Register> createState() => _Healer_RegisterState();
}

class _Healer_RegisterState extends State<Healer_Register> {
  int _value = 1;
  SharedPreferences? prefs;
bool  isLoading=false;
/*type:1
full_name:jaya
email_id:jaya12@gmail.com
password:Hello@123
confirm_password:Hello@123
phone_number:6878906751
age:28
gender:2
address:
pincode:452009*/
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? dropdownvalue;
  var items = [
    'Male',
    'Female',
    'Other',
  ];
  late Gender _gender;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = true.obs;
  bool isChecked = false, _isPassObscure = true, _isConfirmObscure = true;
  UtilMethods utilMethods = UtilMethods();
  bool agree = false;
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          brightness: Brightness.dark,
          toolbarHeight: 60,
          backgroundColor: ColorUtils.trendyThemeColor,
          elevation: 0.0,
          /*  automaticallyImplyLeading: false,*/
          title: Text('Register',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: StringUtils.roboto_font_family,
                color: ColorUtils.whiteColor,
                fontSize: 18,
              )),
          centerTitle: true,
        ),
        body: Stack(children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 0, right: 0, top: 7.h, bottom: 10.h),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 3.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Full name',
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
                          child: new Row(
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
                              new Container(
                                child: new Flexible(
                                  child: new TextField(
                                    controller: fullnameController,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    decoration: new InputDecoration(
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
                                        hintText: 'Enter Full Name'),
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
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
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
                              EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          margin:
                              EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorUtils.lightGreyBorderColor),
                            color: ColorUtils.whiteColor,
                          ),
                          child: new Row(
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
                              new Container(
                                child: new Flexible(
                                  child: new TextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    decoration: new InputDecoration(
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
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Password',
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
                          child: new Row(
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
                              new Container(
                                child: new Flexible(
                                  child: new TextField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    textAlign: TextAlign.left,
                                    obscureText: !_isPassObscure,
                                    decoration: new InputDecoration(
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
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              _isPassObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isPassObscure =
                                                    !_isPassObscure;
                                              });
                                            }),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Enter Password'),
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
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
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
                              EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorUtils.lightGreyBorderColor),
                            color: ColorUtils.whiteColor,
                          ),
                          child: new Row(
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
                              new Container(
                                child: new Flexible(
                                  child: new TextField(
                                    controller: confirmController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: !_isConfirmObscure,
                                    textAlign: TextAlign.left,
                                    decoration: new InputDecoration(
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
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              _isConfirmObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isConfirmObscure =
                                                    !_isConfirmObscure;
                                              });
                                            }),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Enter Confirm Password'),
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
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Phone Number',
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
                          child: new Row(
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
                              new Container(
                                child: new Flexible(
                                  child: new TextField(
                                    controller: phoneNumberController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.left,
                                    decoration: new InputDecoration(
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
                                        hintText: 'Enter Phone Number'),
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
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Gender',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: StringUtils.roboto_font_family,
                                    color: ColorUtils.blackColor,
                                    fontSize: 17,
                                  )))),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 1.h),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            margin: EdgeInsets.only(top: 0),
                            decoration: BoxDecoration(
                              color: ColorUtils.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorUtils.lightGreyBorderColor),

                              /*     boxShadow: [
                        BoxShadow( color: ColorUtils.lightGreyBorderColor,spreadRadius: 3),
                      ],*/
                            ),
                            height: 50,
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              // Initial Value
                              hint: Text('Select Gender',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: StringUtils.roboto_font_family,
                                    color: ColorUtils.greyColor,
                                    fontSize: 17,
                                  )),
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: Icon(Icons.keyboard_arrow_down,
                                  color: ColorUtils.lightGreyBorderColor),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(
                                        color: ColorUtils.blackColor,
                                        /*  fontFamily: StringUtils
                                      .roboto_font_family,*/
                                        fontSize: 17),
                                  ),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            )),
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Age',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: StringUtils.roboto_font_family,
                                    color: ColorUtils.blackColor,
                                    fontSize: 17,
                                  )))),
                      Container(
                          height: 9.h,
                          width: 100.w,
                          padding: EdgeInsets.only(
                              top: 2.h, left: 2.5.w, bottom: 1.h, right: 2.w),
                          margin:
                              EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorUtils.lightGreyBorderColor),
                            color: ColorUtils.whiteColor,
                          ),
                          child: new Row(
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
                              new Container(
                                child: new Flexible(
                                  child: new TextField(
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.left,
                                    maxLength: 2,
                                    decoration: new InputDecoration(
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
                                        hintText: 'Enter Age'),
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
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Address',
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
                          child: new Row(
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
                              new Container(
                                child: new Flexible(
                                  child: new TextField(
                                    controller: addressController,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    decoration: new InputDecoration(
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
                                        hintText: 'Enter Address'),
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
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Pincode',
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
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                child: new Flexible(
                                  child: new TextField(
                                    controller: pincodeController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.left,
                                    decoration: new InputDecoration(
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
                                        hintText: 'Enter Pincode'),
                                    onChanged: (text) {
                                      setState(() {
                                        /*customer_mobile =
                                                            text
                                                                .toString();*/
                                      });
                                    },
                                  ),
                                ), //flexible
                              ), //container
                            ], //widget
                          )),

                      Padding(
                        padding:
                        EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                        child:      Row(
                        children: [
                          Material(
                            child: Checkbox(
                              value: agree,
                              activeColor: ColorUtils.trendyThemeColor,
                              onChanged: (value) {
                                setState(() {
                                  agree = value ?? false;
                                });
                              },
                            ),
                          ),
                          new RichText(
                            text: new TextSpan(
                              text: '',
                              style:null,
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'I agree to the Trendy Chikitsa',
                                  style: TextStyle(
                              fontFamily: StringUtils.roboto_font_family,
                              color: ColorUtils.blackColor,
                              fontSize: 16,
                            )),
                                new TextSpan(
                                    text: ' Terms of\n service ',
                                    style: TextStyle(
                                      fontFamily: StringUtils.roboto_font_family,
                                      color: Colors.blue,
                                      fontSize: 16,
                                    )),
                                new TextSpan(
                                    text: 'and ',
                                    style: TextStyle(
                                      fontFamily: StringUtils.roboto_font_family,
                                      color: ColorUtils.blackColor,
                                      fontSize: 16,
                                    )),

                                new TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      fontFamily: StringUtils.roboto_font_family,
                                      color: Colors.blue,
                                      fontSize: 16,
                                    )),

                              ],
                            ),
                          ),
                        ],
                      ),)

                    ]),
                  ) //row

                  )),
          SpinKitFadingCircleWidget(isLoading),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
                  child: SizedBox(
                      width: 280,
                      height: 46,
                      child: ElevatedButton(
                          child: TextWidget(
                              'Signup',
                              FontWeight.normal,
                              ColorUtils.whiteColor,
                              19,
                              StringUtils.roboto_font_family),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(10),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  ColorUtils.trendyButtonColor),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorUtils.trendyButtonColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color:
                                              ColorUtils.trendyButtonColor)))),
                          onPressed: () {
                            if (fullnameController.text.length == 0) {
                              showAlertDialog(
                                  context, "Please enter full name");
                            } else if (emailController.text.length == 0 ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(emailController.text)) {
                              showAlertDialog(
                                  context, "Please enter valid email");
                            } else if (passwordController.text.length == 0) {
                              showAlertDialog(context, "Please enter password");
                            } else if (confirmController.text.length == 0) {
                              showAlertDialog(
                                  context, "Please enter confirm password");
                            } else if (phoneNumberController.text.length !=
                                10) {
                              showAlertDialog(context,
                                  "Please enter 10 digit mobile number");
                            } else if (ageController.text.length == 0) {
                              showAlertDialog(context, "Please enter age");
                            } else if (dropdownvalue == "Select Gender" ||
                                dropdownvalue.toString().trim().length == 0) {
                              showAlertDialog(context, "Please select gender");
                            }
                            /*else if (_referralController.text.length == 0) {
            utilMethods.showErrorAlertDialog(context, "Please enter referral code");
          }*/
                            else if (addressController.text.length == 0) {
                              showAlertDialog(context, "Please enter address");
                            } else if (pincodeController.text.length == 0) {
                              showAlertDialog(context, "Please enter pincode");
                            } else if (!agree) {
                              showAlertDialog(context, "Please agree with terms and conditions.");
                            } else {
                              registerHealer();
                            }
                          }))))
        ]),
      ));
    });
  }

  Future<String?> registerHealer() async {
    var data;
    isLoading=true;
    setState(() {

    });
    print('type---    ${prefs!.getString(StringUtils.type).toString()}');
    var request = http.MultipartRequest('POST', BaseuURL.register_user);
    //   request.headers.addAll(headers);
    request.fields['type'] = prefs!.getString(StringUtils.type).toString();
    request.fields['full_name'] = fullnameController.text.toString().trim();
    request.fields['email_id'] = emailController.text.toString().trim();
    request.fields['password'] = passwordController.text.toString().trim();
    request.fields['confirm_password'] =
        confirmController.text.toString().trim();
    request.fields['phone_number'] =
        phoneNumberController.text.toString().trim();
    request.fields['age'] = ageController.text.toString().trim();
    request.fields['gender'] = dropdownvalue.toString();
    request.fields['address'] = addressController.text.toString().trim();
    request.fields['pincode'] = pincodeController.text.toString().trim();

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
              if (prefs!.getString(StringUtils.type).toString() == "1") {
                if (data["status"] == "true" &&
                    data["msg"] ==
                        "Success! Your account has been created successfully. Please complete your profile to access your account.") {
                  print(
                      'Success! Your account has been created successfully. Please complete your profile to access your account.---    ');
                  HealerRegisterReponse registerUser =
                      HealerRegisterReponse.fromJson(jsonDecode(response.body));
                  print(registerUser.response!.hEmail.toString());
                  prefs!.setString(StringUtils.name,
                      registerUser.response!.hName.toString());
                  prefs!.setString(StringUtils.email,
                      registerUser.response!.hEmail.toString());
                  prefs!.setString(StringUtils.mobile,
                      registerUser.response!.hTelephone.toString());
                  prefs!.setString(
                      StringUtils.age, registerUser.response!.hAge.toString());
                  prefs!.setString(StringUtils.gender,
                      registerUser.response!.hGender.toString());
                  prefs!.setString(StringUtils.address,
                      registerUser.response!.hAddress.toString());
                  prefs!.setString(StringUtils.zipcode,
                      registerUser.response!.hPin.toString());
                  prefs!.setString(StringUtils.unique_id,
                      registerUser.response!.hLinks.toString());
                  prefs!.setBool(StringUtils.loginINAPP, true);
                  prefs!.setString(StringUtils.type, "1");
                  showAlertDialog(context, data["msg"]);
                  Future.delayed(Duration(seconds: 2), () {
                    isLoading=false;
                    setState(() {

                    });
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HealerPricingPlan()));
                  });
                } else {
                  isLoading=false;
                  setState(() {

                  });
                  showAlertDialog(context, data["msg"]);
                }
              } else if (prefs!.getString(StringUtils.type).toString() == "2") {
                if (data["status"] == "true" &&
                    data["msg"] ==
                        "Success! Your account has been created successfully. Please login to access your account.") {
                  print(
                      'Success! Your account has been created successfully. Please login to access your account.---    ');
                  RegisterClientResponse registerUser =
                      RegisterClientResponse.fromJson(
                          jsonDecode(response.body));
                  print(registerUser.response!.clEmail.toString());
                  prefs!.setString(StringUtils.name,
                      registerUser.response!.clName.toString());
                  prefs!.setString(StringUtils.email,
                      registerUser.response!.clEmail.toString());
                  prefs!.setString(StringUtils.mobile,
                      registerUser.response!.clTelephone.toString());
                  prefs!.setString(
                      StringUtils.age, registerUser.response!.clAge.toString());
                  prefs!.setString(StringUtils.gender,
                      registerUser.response!.clGender.toString());
                  prefs!.setString(StringUtils.address,
                      registerUser.response!.clAddress.toString());
                  prefs!.setString(StringUtils.zipcode,
                      registerUser.response!.clPin.toString());
                  prefs!.setString(StringUtils.unique_id,
                      registerUser.response!.clLinks.toString());
                  prefs!.setBool(StringUtils.loginINAPP, true);
                  prefs!.setString(StringUtils.type, "2");
                  showAlertDialog(context, data["msg"]);
                  Future.delayed(Duration(seconds: 2), () {
                    isLoading=false;
                    setState(() {

                    });
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (context) => Healer_Login()
                    ),(route) => false,);
                  });
                } else {
                  isLoading=false;
                  setState(() {

                  });
                  showAlertDialog(context, data["msg"]);
                }
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
