import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'dart:ui';
import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/models/all_therapy_response.dart';
import 'package:doctor/models/healer_responses/healer_profile_fetch_data.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:doctor/utils/utils_methods.dart';
import 'package:doctor/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfileSetting extends StatefulWidget {
  String from_page = "";

  @override
  ProfileSettingstate createState() => ProfileSettingstate();

/* ProfileSetting({
    Key? key,
    required this.from_page,
  }) : super(key: key);*/
}

class ProfileSettingstate extends State<ProfileSetting> {
  static const String routeName = '/homePage';
  String appointment_Status = 'Pending Appointment';
  String customer_mobile = '',
      age = '',
      phone_no = '',
      pickup_address = '',
      customer_name = "",
      name = "";
  String dropdownvalue = 'Select Gender';
  bool isVisible = false;
  bool isBottomNaviVisible = false;
  SharedPreferences? preferences;
  var items = [
    'Male',
    'Female',
    'Other',
  ];

  var monthItem = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  List<TherapyList> therapyList = [];
  List<TextEditingController?>? experienceInYearControllerList = [];
  List<String?> _animals = [
    'Depression',
    'Carrer related issue',
    'Confidence issue',
    'Corporate programms',
    'Depression1',
    'Carrer related issue1',
  ];

  List<String> selected = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final myController = TextEditingController();
  final nameController = TextEditingController();

  String appToken = "";
  bool isLoading = false;
  String share_link = "", title = "Profile";
  PickedFile? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
  int _selectedIndex = 0;
  SharedPreferences? prefs;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _aboutMeController = TextEditingController();
  int value = 1, pricingValue = 1;
  List<Expertise?> expertiseList = [];
  List<Pricing?> pricingList = [];


  List<String?> selectTherapyItemList = [];
  List<String?> selectPricingTherapyItemList = [];
  List<String?> expInMonths = [];
  String? selectedSpinnerItem,
      selectedSpinnerItem1,
      selectedCityItem,
      selectedGender,
      selectedStateItem,
      class_id = "",
      stateId = "",selectedPricingTherapyItem="",
      cityId = "",
      image_url = 'https://source.unsplash.com/user/c_v_r';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();
    getTherapies();
    getFetchProfileData();

    /*   _nameController =
        new TextEditingController(text: prefs!.getString(StringUtils.t_name));
    _emailController =
        new TextEditingController(text: prefs!.getString(StringUtils.email));
    _mobileNumberController =
        new TextEditingController(text: prefs!.getString(StringUtils.s_mobile));
    _dobController =
        new TextEditingController(text: prefs!.getString(StringUtils.dob));
    _zipCodeController =
        new TextEditingController(text: prefs!.getString(StringUtils.zipcode));
    _addressController=
    new TextEditingController(text: prefs!.getString(StringUtils.address));
    _classController=
    new TextEditingController(text: prefs!.getString(StringUtils.subject));*/

    print('selcted city   ${prefs!.getString(StringUtils.city)}');

    /*  preferences = await SharedPreferences.getInstance();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      name =
          preferences!.getString(StringUtils.customer_mobile_number).toString();
      nameController.text =
          preferences!.getString(StringUtils.customer_name).toString();
     setState(() {});
    }); */
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          builder: (context, widget) {
            // TODO: implement build
            return new Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: true,
                backgroundColor: ColorUtils.lightGreyBorderColor,
                appBar: AppBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  elevation: 10,
                  backgroundColor: ColorUtils.trendyThemeColor,
                  title: Text(
                    "Profile",
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.whiteColor,
                      letterSpacing: 0.15,
                      /*  fontWeight: FontWeight.bold,*/
                      fontSize: 20,
                    ),
                  ),
                  actions: <Widget>[],
                  leading: new IconButton(
                    icon: new Icon(
                      Icons.menu,
                      color: ColorUtils.whiteColor,
                      size: 20,
                    ),
                    onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  ),
                ),
                body: Stack(
                  children: [
                    /* FutureBuilder<HealerProfileFetchData?>(
                      future: getFetchProfileData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          print('snapshot--  ${snapshot.error}');
                          if (snapshot.hasData) {
                            print('snapshot has data--  ${snapshot.hasData}');
                            //   print('value is..  ${new Map<String, dynamic>.from(snapshot.data).}');

                            return */
                    SingleChildScrollView(
                      child: Column(children: [
                        InkWell(
                            child: Container(
                                color: ColorUtils.whiteColor,
                                height: 10.h,
                                child: Column(children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          10.w, 3.h, 10.w, 0.h),
                                      child: SizedBox(
                                          width: 100.h,
                                          height: 7.h,
                                          child: ElevatedButton(
                                              child: Text(
                                                  'Save Changes'.toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    fontSize: 17,
                                                    color:
                                                        ColorUtils.whiteColor,
                                                    letterSpacing: 0.75,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.2,
                                                  )),
                                              style: ButtonStyle(
                                                  elevation: MaterialStateProperty.all(
                                                      0),
                                                  foregroundColor: MaterialStateProperty.all<Color>(ColorUtils
                                                      .violetButtonColor),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(ColorUtils
                                                          .violetButtonColor),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: new BorderRadius.circular(8.0),
                                                          side: BorderSide(color: ColorUtils.violetButtonColor)))),
                                              onPressed: () {}))),
                                ])),
                            onTap: () async {}),
                        Container(
                            margin: EdgeInsets.only(
                                left: 0, right: 0, top: 0.h, bottom: .7.h),
                            color: ColorUtils.whiteColor,
                            child: Center(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                        top: 2.h,
                                        bottom: 5.h),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      'Basic Information',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family_bold,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 19,
                                                      )))),
                                          Container(
                                            height: 20.h,
                                            width: 40.w,
                                            child: Stack(
                                              children: <Widget>[
                                                Center(child: _previewImage()),
                                                Positioned(
                                                  bottom: 2.h,
                                                  right: .5.w,
                                                  //give the values according to your requirement
                                                  child: GestureDetector(
                                                    onTap: _pickImage,
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: ColorUtils
                                                          .darkPinkColor,
                                                      size: 35,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Full Name',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              keyboardType: TextInputType.text,
                                              controller: _nameController,
                                              /*enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 17),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'eg. Topic 1'),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Email',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              controller: _emailController,
                                              keyboardType: TextInputType.text,
                                              /* enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 17),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'eg. Topic 1'),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Mobile No',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*  color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              controller:
                                                  _mobileNumberController,
                                              keyboardType: TextInputType.text,
                                              /* enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 17),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'eg. Topic 1'),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Date of Birth',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*  color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              controller: _dobController,
                                              keyboardType: TextInputType.text,
                                              /*enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 17),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'eg. Topic 1'),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Gender',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),

                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 15),
                                            margin: EdgeInsets.only(
                                                top: 10, left: 15, right: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              color: ColorUtils.whiteColor,
                                            ),
                                            height: 6.h,
                                            child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                              // Initial Value
                                              isExpanded: true,
                                              value: selectedGender,
                                              hint: Container(
                                                child: Text('Select Gender'),
                                              ),
                                              // Down Arrow Icon
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: ColorUtils.greyColor,
                                                size: 30,
                                              ),

                                              items: items.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    style: TextStyle(
                                                        color: ColorUtils
                                                            .textFormFieldLabelColor,
                                                        /*  fontFamily: StringUtils
                                      .roboto_font_family,*/
                                                        fontSize: 16),
                                                  ),
                                                );
                                              }).toList(),
                                              // After selecting the desired option,it will
                                              // change button value to selected value
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selectedGender = newValue!;
                                                });
                                              },
                                            )),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              controller: _addressController,
                                              keyboardType: TextInputType.text,
                                              enabled: true,
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'eg. Topic 1'),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Zip Code',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              controller: _zipCodeController,
                                              keyboardType: TextInputType.text,
                                              enabled: true,
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'eg. Topic 1'),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),

                                          //row
                                        ])))),
                        SizedBox(height: 0.h),
                        Container(
                            margin: EdgeInsets.only(
                                left: 0, right: 0, top: 0.h, bottom: 0.7.h),
                            color: ColorUtils.whiteColor,
                            child: Center(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                        top: 2.h,
                                        bottom: 5.h),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('About Me',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family_bold,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 19,
                                                      )))),

                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              controller: _aboutMeController,
                                              /*enabled: false,*/
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 17),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText:
                                                      'Lorem Ipsum is simply '),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Keywords',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              controller: _emailController,
                                              keyboardType: TextInputType.text,
                                              /* enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 17),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: ''),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Video',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 6.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 2.w),
                                            margin: EdgeInsets.only(
                                                top: 1.h,
                                                left: 4.w,
                                                right: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                              ),
                                              /*  color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                            ),
                                            child: new TextField(
                                              controller:
                                                  _mobileNumberController,
                                              keyboardType: TextInputType.text,
                                              /* enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: new InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 17),
                                                  labelStyle: TextStyle(
                                                      color:
                                                          ColorUtils.blackColor,
                                                      fontSize: 16),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: ''),
                                              onChanged: (text) {
                                                setState(() {
                                                  /* customer_mobile =
                                          text.toString();*/
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ),

                                          //row
                                        ])))),
                        ColoredBox(
                            color: ColorUtils.whiteColor,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                /*  physics: NeverScrollableScrollPhysics(),*/
                                itemCount: /*expertiseList.length*/ value,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Column(
                                    children: [
                                      Visibility(
                                          visible: index == 0,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Your Expertise',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family_bold,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 19,
                                                      ))))),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, top: 2.h),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child:
                                                  Text('Expertise ${index + 1}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 18,
                                                      )))),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, top: 2.h),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Select Therapy',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color:
                                                        ColorUtils.blackColor,
                                                    fontSize: 16,
                                                  )))),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 15),
                                        margin: EdgeInsets.only(
                                            top: 10, left: 15, right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: ColorUtils.greyColor
                                                .withOpacity(.4),
                                          ),
                                          color: ColorUtils.whiteColor,
                                        ),
                                        height: 6.h,
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          // Initial Value
                                          isExpanded: true,
                                          value: selectTherapyItemList.length >=
                                                      index &&
                                                  selectTherapyItemList[
                                                          index] ==
                                                      ''
                                              ? selectedCityItem
                                              : selectTherapyItemList[index],
                                          hint: Container(
                                            child: Text('Select Therapy'),
                                          ),
                                          // Down Arrow Icon
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ColorUtils.greyColor,
                                            size: 30,
                                          ),

                                          items: therapyList!.map((item) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                  item.therapy_name.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                      fontSize: 15)),
                                              value:
                                                  item.therapy_name.toString(),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectTherapyItemList[index] =
                                                  newValue!;
                                            });
                                          },
                                        )),
                                      ),

                                      /*       Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              // DropDownMultiSelect comes from multiselect
                                              child: DropDownMultiSelect(

                                                onChanged: (List<String> x) {
                                                  setState(() {
                                                    selected =x;
                                                  });
                                                },
                                                options: ['Depression' , 'Carrer related issue' , 'Confidence issue' , 'Corporate programms','Depression1' , 'Carrer related issue1' , 'Confidence issue1' , 'Corporate programms1','Depression2' , 'Carrer related issue2' , 'Confidence issue2' , 'Corporate programms2'],
                                                selectedValues: selected,

                                                whenEmpty: 'Select Something',
                                              ),
                                            ),*/
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h, left: 2.w, right: 2.w),
                                          child: GFMultiSelect(
                                            items: _animals,
                                            onSelect: (value1) {
                                              print('selected $value1');
                                            },
                                            dropdownTitleTileMargin:
                                                EdgeInsets.only(
                                                    top: 1.h,
                                                    left: 2.w,
                                                    right: 2.w,
                                                    bottom: 1.h),
                                            dropdownTitleTilePadding:
                                                EdgeInsets.all(10),
                                            dropdownUnderlineBorder:
                                                const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 2),
                                            dropdownTitleTileBorder: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                                width: 1),
                                            dropdownTitleTileBorderRadius:
                                                BorderRadius.circular(5),
                                            expandedIcon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black54,
                                            ),
                                            collapsedIcon: const Icon(
                                              Icons.keyboard_arrow_up,
                                              color: Colors.black54,
                                            ),
                                            submitButton: Text('OK'),
                                            cancelButton: Text('Cancel'),
                                            dropdownTitleTileTextStyle:
                                                const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                            padding: const EdgeInsets.all(0),
                                            margin: const EdgeInsets.all(0),
                                            type: GFCheckboxType.basic,
                                            activeBgColor: GFColors.SUCCESS,
                                            activeBorderColor: GFColors.SUCCESS,
                                            inactiveBorderColor:
                                                ColorUtils.greyColor,
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, top: 2.h),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Experience(in Year)',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color:
                                                        ColorUtils.blackColor,
                                                    fontSize: 16,
                                                  )))),
                                      Container(
                                        height: 6.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 2.w),
                                        margin: EdgeInsets.only(
                                            top: 1.h, left: 4.w, right: 4.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: ColorUtils.greyColor
                                                .withOpacity(.4),
                                          ),
                                        ),
                                        child: new TextField(
                                          controller: experienceInYearControllerList !=
                                                      null &&
                                                  experienceInYearControllerList!
                                                          .length >
                                                      0
                                              ? experienceInYearControllerList![
                                                  index]
                                              : null,
                                          keyboardType: TextInputType.number,
                                          enabled: true,
                                          textAlign: TextAlign.left,
                                          decoration: new InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: ColorUtils.greyColor,
                                                  fontSize: 16),
                                              labelStyle: TextStyle(
                                                  color: ColorUtils.blackColor,
                                                  fontSize: 16),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: 'eg. 2'),
                                          onChanged: (text) {
                                            setState(() {
                                              /* customer_mobile =
                                          text.toString();*/
                                              //you can access nameController in its scope to get
                                              // the value of text entered as shown below
                                              //UserName = nameController.text;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, top: 2.h),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child:
                                                  Text('Experience(in Months)',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 15),
                                        margin: EdgeInsets.only(
                                            top: 10, left: 15, right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: ColorUtils.greyColor
                                                .withOpacity(.4),
                                          ),
                                          color: ColorUtils.whiteColor,
                                        ),
                                        height: 6.h,
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          // Initial Value
                                          isExpanded: true,
                                          value: expInMonths.length >= index &&
                                                  expInMonths[index] == ''
                                              ? selectedCityItem
                                              : expInMonths[index],
                                          /*expInMonths[index]*/
                                          hint: Container(
                                            child: Text('0'),
                                          ),
                                          // Down Arrow Icon
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ColorUtils.greyColor,
                                            size: 30,
                                          ),

                                          items: monthItem.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                items,
                                                style: TextStyle(
                                                    color: ColorUtils
                                                        .textFormFieldLabelColor,
                                                    /*  fontFamily: StringUtils
                                      .roboto_font_family,*/
                                                    fontSize: 16),
                                              ),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              expInMonths[index] = newValue!;
                                            });
                                          },
                                        )),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, top: 20),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child:
                                                  Text('Choose File To Upload',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 17,
                                                      )))),
                                      Container(
                                          height: 6.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 1),
                                          margin: EdgeInsets.only(
                                              top: 10, left: 15, right: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: ColorUtils.greyColor,
                                            ),
                                            color: ColorUtils.whiteColor,
                                          ),
                                          child: new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              /*  new Text('+91 ',
                                textAlign:
                                TextAlign.left,
                                style: TextStyle(

                                  color:Constant
                                      .blackColor,
                                  fontSize: 19,
                                )),*/
                                              SizedBox(
                                                width: 0,
                                              ),
                                              new Container(
                                                child: new Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        /*fileName*/
                                                        'File Name',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily: StringUtils
                                                              .roboto_font_family,
                                                          color: ColorUtils
                                                              .blackColor,
                                                          fontSize: 17,
                                                        ))),

                                                //flexible
                                              ),
                                              InkWell(
                                                  onTap: () async {
                                                    /*     FilePickerResult? result =
                                                          await FilePicker.platform
                                                              .pickFiles(
                                                              type: FileType.any);
                                                          */ /*  allowedExtensions: ['.csv', 'doc','pdf']);*/ /*
                                                          */ /* allowedExtensions: [
                                                    'doc',
                                                    'pdf','csv',
                                                  ]);*/ /*
                                                          if (result == null) return;
                                                          file = result!.files.first;
                                                          print('File Name: ${file?.name}');
                                                          print('File Size: ${file?.size}');
                                                          print(
                                                              'File Extension: ${file?.extension}');
                                                          print('File Path: ${file?.path}');

                                                          fileName = file!.name.toString();
                                                          await uploadFile(
                                                              file
                                                                  ?.path);
                                                          setState(() {});*/
                                                  },
                                                  child: SizedBox(
                                                      height: 50,
                                                      width: 80,
                                                      child: ColoredBox(
                                                        color: ColorUtils
                                                            .lightGreyBorderColor,
                                                        child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                'Browse',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      StringUtils
                                                                          .roboto_font_family,
                                                                  color: ColorUtils
                                                                      .blackColor,
                                                                  fontSize: 15,
                                                                ))),
                                                      ))),
                                            ], //widget
                                          )),
                                      Visibility(
                                          visible: index + 1 == value,
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (value < 9) {
                                                    value = value + 1;
                                                    selectTherapyItemList
                                                        .add('');
                                                    expInMonths.add('0');
                                                    experienceInYearControllerList!
                                                        .add(
                                                            TextEditingController());
                                                  }
                                                });
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      top: 2.h,
                                                      bottom: 3.h),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          'Add More Expertise',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontFamily: StringUtils
                                                                .roboto_font_family_bold,
                                                            color: Colors
                                                                .lightBlue,
                                                            fontSize: 19,
                                                          )))))),
                                    ],
                                  );
                                })),
                        SizedBox(height: 0.7.h),
                        ColoredBox(
                            color: ColorUtils.whiteColor,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                /*  physics: NeverScrollableScrollPhysics(),*/
                                itemCount: pricingValue,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Column(
                                    children: [
                                      Visibility(
                                          visible: index == 0,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Pricing ',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family_bold,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 19,
                                                      ))))),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, top: 2.h),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Select Therapy',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color:
                                                        ColorUtils.blackColor,
                                                    fontSize: 16,
                                                  )))),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 15),
                                        margin: EdgeInsets.only(
                                            top: 10, left: 15, right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: ColorUtils.greyColor
                                                .withOpacity(.4),
                                          ),
                                          color: ColorUtils.whiteColor,
                                        ),
                                        height: 6.h,
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          // Initial Value
                                          isExpanded: true,
                                              value: selectPricingTherapyItemList.length >=
                                                  index &&
                                                  selectPricingTherapyItemList[
                                                  index] ==
                                                      ''
                                                  ? selectedPricingTherapyItem
                                                  : selectPricingTherapyItemList[index],
                                          hint: Container(
                                            child: Text('Select Therapy'),
                                          ),
                                          // Down Arrow Icon
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ColorUtils.greyColor,
                                            size: 30,
                                          ),

                                              items: therapyList!.map((item) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                      item.therapy_name.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.normal,
                                                          color: Colors.black,
                                                          fontSize: 15)),
                                                  value:
                                                  item.therapy_name.toString(),
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
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, top: 2.h),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Custom Price',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color:
                                                        ColorUtils.blackColor,
                                                    fontSize: 16,
                                                  )))),
                                      Container(
                                        height: 6.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 2.w),
                                        margin: EdgeInsets.only(
                                            top: 1.h, left: 4.w, right: 4.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: ColorUtils.greyColor
                                                .withOpacity(.4),
                                          ),
                                          /*color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
                                        ),
                                        child: new TextField(
                                          controller: _addressController,
                                          keyboardType: TextInputType.number,
                                          enabled: true,
                                          textAlign: TextAlign.left,
                                          decoration: new InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: ColorUtils.greyColor,
                                                  fontSize: 16),
                                              labelStyle: TextStyle(
                                                  color: ColorUtils.blackColor,
                                                  fontSize: 16),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: 'eg. 2'),
                                          onChanged: (text) {
                                            setState(() {
                                              /* customer_mobile =
                                          text.toString();*/
                                              //you can access nameController in its scope to get
                                              // the value of text entered as shown below
                                              //UserName = nameController.text;
                                            });
                                          },
                                        ),
                                      ),
                                      Visibility(
                                          visible: index + 1 == pricingValue,
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {

                                                  pricingValue =
                                                      pricingValue + 1;
                                                });
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      top: 2.h,
                                                      bottom: 3.h),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          'Add More Pricing',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontFamily: StringUtils
                                                                .roboto_font_family_bold,
                                                            color: Colors
                                                                .lightBlue,
                                                            fontSize: 19,
                                                          )))))),
                                    ],
                                  );
                                })),
                        InkWell(
                            child: Container(
                                color: ColorUtils.whiteColor,
                                height: 12.h,
                                child: Column(children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          10.w, 4.h, 10.w, 1.h),
                                      child: SizedBox(
                                          width: 100.h,
                                          height: 7.h,
                                          child: ElevatedButton(
                                              child: Text(
                                                  'Save Changes'.toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    fontSize: 17,
                                                    color:
                                                        ColorUtils.whiteColor,
                                                    letterSpacing: 0.75,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.2,
                                                  )),
                                              style: ButtonStyle(
                                                  elevation: MaterialStateProperty.all(
                                                      0),
                                                  foregroundColor: MaterialStateProperty.all<Color>(ColorUtils
                                                      .violetButtonColor),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(ColorUtils
                                                          .violetButtonColor),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: new BorderRadius.circular(8.0),
                                                          side: BorderSide(color: ColorUtils.violetButtonColor)))),
                                              onPressed: () {}))),
                                ])),
                            onTap: () async {}),
                        SpinKitFadingCircleWidget(isLoading)
                      ]),
                    ) /*;
                          } else {
                            return SizedBox(
                                height: 500,
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/images/no_data.json',
                                    repeat: true,
                                    height: 70,
                                    width: 35.w,
                                    reverse: false,
                                    animate: true,
                                  ),
                                  */ /*     Image.asset(
                                                          'assets/images/no_data.png',
                                                          width: 200,
                                                          height: 200,
                                                        ),*/ /*
                                ));
                          }
                        } else {
                          return SizedBox(
                              height: 500,
                              child: Center(
                                child: Lottie.asset(
                                  'assets/images/loading_data.json',
                                  repeat: true,
                                  height: 70,
                                  width: 35.w,
                                  reverse: false,
                                  animate: true,
                                ),
                                */ /*     Image.asset(
                                                          'assets/images/no_data.png',
                                                          width: 200,
                                                          height: 200,
                                                        ),*/ /*
                              ));
                        }
*/ /*},
                    )*/
                  ],
                ));
          });
    });
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
      //  var res = await uploadImage(_imageFile!.path.toString());
      // print(res);
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  Future<String?> updateProfile() async {
    var data;

    var request = http.MultipartRequest('POST',
        Uri.parse('https://www.techtradedu.com/conceptlive/api/edit_profile'));
    request.fields['user_type'] = '2';
    request.fields['address'] = _addressController.text.toString();
    request.fields['city_id'] = cityId.toString();
    request.fields['state_id'] = stateId.toString();
    request.fields['zip_code'] = _zipCodeController.text.toString();
    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'user_profile', _imageFile!.path.toString()));
    }
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
                  data["msg"] == "Login successful!!!") {
                print('Login succssfull---    ');

                UtilMethods.showSnackBar(context, "Login successful!!!");

                //  showAlertDialog(context, "Uploaded KYC successfully" );
              } else {
                UtilMethods.showSnackBar(context, data["msg"]);
              }
            }

            return response.body;
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return CircleAvatar(
        radius: 90.0,
        backgroundImage: FileImage(File(_imageFile!.path.toString())),
        backgroundColor: Colors.transparent,
      );
    } else if (image_url != null) {
      return CircleAvatar(
        radius: 90.0,
        backgroundImage: NetworkImage(image_url.toString()),
        backgroundColor: Colors.transparent,
      );
    } else {
      return CircleAvatar(
        radius: 90.0,
        backgroundImage: AssetImage(
          ('assets/images/student.jpg'),
        ),
      );
    }
  }

  HealerProfileFetchData? _healerProfileFetchData;

  Future<HealerProfileFetchData?> getFetchProfileData() async {
    var data;
    try {
      var request =
          await http.MultipartRequest('POST', BaseuURL.healerprofile_detail);

      request.fields['healer_id'] =
          /*prefs!.getString(StringUtils.id).toString()*/ '52';
      // var res = await request.send();
      // var res = await request.send();
      var response = await request.send();
      final responsed = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        print("Uploaded! ");
        print('response.body ' + responsed.body);
        var jsonData = responsed.body;

        print(jsonData);
        data = json.decode(responsed.body);

        var rest1 = data["msg"];
        data = json.decode(responsed.body);
        print('--->>?   ${data}');

        if (data["status"] == "true" && data["response"] == "success") {
          print('getFetchProfileData--    ');

          final jsonResponse = json.decode(responsed.body);

          _healerProfileFetchData =
              new HealerProfileFetchData.fromJson(jsonResponse);
          expertiseList =
              _healerProfileFetchData!.expertise!.cast<Expertise?>();
          pricingList = _healerProfileFetchData!.pricing!.cast<Pricing?>();


          _nameController.text = _healerProfileFetchData!.healerName.toString();
          _emailController.text =
              _healerProfileFetchData!.healerEmail.toString();
          _mobileNumberController.text =
              _healerProfileFetchData!.healerTelephone.toString();
          _dobController.text = _healerProfileFetchData!.dateOfBirth.toString();
          _zipCodeController.text = _healerProfileFetchData!.pinCode.toString();
          _addressController.text = _healerProfileFetchData!.address.toString();
          selectedGender = _healerProfileFetchData!.gender.toString();
          if (_healerProfileFetchData!.healerProfile.toString().trim().length >
              0) {
            image_url = _healerProfileFetchData!.healerProfile.toString();
          }
          print('expertiseList.length--${expertiseList.length}    ');
          value=expertiseList.length;
          pricingValue=pricingList.length;
          if (expertiseList.length > 0) {
            value = expertiseList.length;

            print('expertiseList.length--dfdsfds${expertiseList.length}    ');

            for (int i = 0; i < expertiseList.length; i++) {
              print(
                  'expertiseList.length inside loop --   ${expertiseList[i]!.therapyName1.toString()}    ');
              selectTherapyItemList
                  .add(expertiseList[i]!.therapyName1.toString());
              expInMonths.add(expertiseList[i]!.experienceMonth1.toString());
              experienceInYearControllerList!.add(new TextEditingController());
              experienceInYearControllerList![i]!.text =
                  expertiseList[i]!.experienceYear1.toString();
              print(
                  'expertiseList.length inside loop --   ${selectTherapyItemList[i]}    ');
            }


          }

          if (pricingList.length > 0) {
            pricingValue = pricingList.length;
            print('pricingList.length--dfdsfds${pricingList.length}    ');

            for (int i = 0; i < pricingList.length; i++) {
              print(
                  'pricingList.length inside loop --   ${pricingList[i]!.therapyName.toString()}    ');
              selectPricingTherapyItemList
                  .add(pricingList[i]!.therapyName.toString());

              print(
                  'pricingList.length inside loop --   ${ selectPricingTherapyItemList[i]}    ');
            }


          }

        } else {
          expertiseList!.clear();
          selectTherapyItemList.clear();
          experienceInYearControllerList!.clear();
          expInMonths.clear();
        }
      }

      setState(() {});
    } catch (e) {
      print('exce --   ${e.toString()}    ');
    }
    return _healerProfileFetchData;
  }

  Future<List<TherapyList>?> getTherapies() async {
    var data;
    AllTherapyResponse? studentAllChapterResponse;
    var request = await http.MultipartRequest('GET', BaseuURL.allTherapies);

    // var res = await request.send();
    var response = await request.send();
    final responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      print("Uploaded! ");
      print('response.body ' + responsed.body);
      var jsonData = responsed.body;

      print(jsonData);
      data = json.decode(responsed.body);

      var rest1 = data["msg"];
      data = json.decode(responsed.body);
      print('--->>?   ${data}');

      if (data["status"] == "true" && data["msg"] == "success") {
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        studentAllChapterResponse =
            new AllTherapyResponse.fromJson(jsonResponse);
        /*  setState(() {*/
        therapyList = studentAllChapterResponse!.response!;

        //   leadList.add(person.campaignData.indexOf(0));
        /*   });*/
        //  showAlertDialog(context, "Uploaded KYC successfully" );
      } else {
        therapyList!.clear();
        setState(() {});
      }
    }
    /*request
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

          if (data["status"] == "true" && data["msg"] == "success") {
            print('Login succssfull---    ');

            final jsonResponse = json.decode(response.body);

            AllTherapyResponse studentAllChapterResponse =
            new AllTherapyResponse.fromJson(jsonResponse);
            */ /*  setState(() {*/ /*
            therapyList = studentAllChapterResponse!.response!;

            //   leadList.add(person.campaignData.indexOf(0));
            */ /*   });*/ /*
            //  showAlertDialog(context, "Uploaded KYC successfully" );
          } else {
            therapyList!.clear();
            setState(() {});
          }
        }

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});*/
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
    return studentAllChapterResponse!.response;
  }



}
