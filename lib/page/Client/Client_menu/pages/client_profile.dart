import 'dart:convert';
import 'dart:io';

import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/client_responses/fetch_client_profile_detail_response.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/utils/utils_methods.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';

import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ClientProfileSetting extends StatefulWidget {
  String from_page = "";

  ClientProfileSetting({super.key});

  @override
  ClientProfileSettingstate createState() => ClientProfileSettingstate();

/* ProfileSetting({
    Key? key,
    required this.from_page,
  }) : super(key: key);*/
}

class ClientProfileSettingstate extends State<ClientProfileSetting> {
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
  ];
  final List<String?> _animals = [
    'Depression',
    'Carrer related issue',
    'Confidence issue',
    'Corporate programms',
    'Depression1',
    'Carrer related issue1',
  ];

  List<String> selected = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();
  final nameController = TextEditingController();

  String appToken = "";
  bool isLoading = false;
  String share_link = "", title = "Profile";
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final int _selectedIndex = 0;
  SharedPreferences? prefs;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  int value = 1, pricingValue = 1;

  String? selectedSpinnerItem,
      selectedSpinnerItem1,
      selectedCityItem,
      selectedStateItem,
      class_id = "",
      stateId = "",
      cityId = "",
      image_url = 'https://source.unsplash.com/user/c_v_r',
      selectedGender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();
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
    getFetchProfileData();
    setState(() {});
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
            return Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: true,
                backgroundColor: ColorUtils.lightGreyBorderColor,
                appBar: AppBar(
                  shape: const RoundedRectangleBorder(
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
                  actions: const <Widget>[],
                  /*  leading: new IconButton(
                    icon: new Icon(
                      Icons.menu,
                      color: ColorUtils.whiteColor,
                      size: 20,
                    ),
                    onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  ),*/
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(children: [
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
                                          /*   Container(
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
                                          ),*/

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
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: _nameController,
                                              /*enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
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
                                                  hintText: 'Enter full name'),
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
                                            child: TextField(
                                              controller: _emailController,
                                              keyboardType: TextInputType.text,
                                              /* enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
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
                                                  hintText: 'Enter email'),
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
                                            child: TextField(
                                              controller:
                                                  _mobileNumberController,
                                              keyboardType: TextInputType.text,
                                              /* enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
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
                                                  hintText:
                                                      'Enter mobile number'),
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
                                          InkWell(
                                              onTap: () {
                                                _selectDate(
                                                    context); // Call Function that has showDatePicker()
                                              },
                                              child: IgnorePointer(
                                                  child: Container(
                                                height: 6.h,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3,
                                                    horizontal: 2.w),
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
                                                child: TextField(
                                                  controller: _dobController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  /*enabled: false,*/
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: ColorUtils
                                                              .blackColor,
                                                          fontSize: 17),
                                                      labelStyle: TextStyle(
                                                          color: ColorUtils
                                                              .blackColor,
                                                          fontSize: 16),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'Enter date of birth'),
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
                                              ))),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 2.h),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('Age',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: StringUtils
                                                            .roboto_font_family,
                                                        color: ColorUtils
                                                            .blackColor,
                                                        fontSize: 16,
                                                      )))),
                                          Container(
                                            height: 9.5.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.only(
                                                top: 3.h,
                                                left: 4.w,
                                                right: 4.w,
                                                bottom: 1.h),
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
                                            child: TextField(
                                              controller: _ageController,
                                              maxLength: 2,
                                              keyboardType:
                                                  TextInputType.number,
                                              /*enabled: false,*/
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
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
                                                  hintText: 'Your age'),
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 15),
                                            margin: const EdgeInsets.only(
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
                                                child:
                                                    const Text('Select Gender'),
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
                                            height: 15.h,
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
                                            child: TextField(
                                              controller: _addressController,
                                              keyboardType: TextInputType.text,
                                              enabled: true,
                                              minLines: 6,
                                              maxLines: null,
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
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
                                                  hintText: 'Enter address'),
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
                                            child: TextField(
                                              controller: _zipCodeController,
                                              keyboardType: TextInputType.text,
                                              enabled: true,
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
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
                                                  hintText: 'Enter zipcode'),
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

                                          InkWell(
                                              child: Container(
                                                  color: ColorUtils.whiteColor,
                                                  height: 12.h,
                                                  child: Column(children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10.w,
                                                                4.h,
                                                                10.w,
                                                                1.h),
                                                        child: SizedBox(
                                                            width: 100.h,
                                                            height: 7.h,
                                                            child:
                                                                ElevatedButton(
                                                                    child: Text(
                                                                        'Save Changes'
                                                                            .toUpperCase(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              StringUtils.roboto_font_family,
                                                                          fontSize:
                                                                              17,
                                                                          color:
                                                                              ColorUtils.whiteColor,
                                                                          letterSpacing:
                                                                              0.75,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          height:
                                                                              1.2,
                                                                        )),
                                                                    style: ButtonStyle(
                                                                        elevation:
                                                                            MaterialStateProperty.all(
                                                                                0),
                                                                        foregroundColor:
                                                                            MaterialStateProperty.all<Color>(ColorUtils
                                                                                .violetButtonColor),
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(ColorUtils
                                                                                .violetButtonColor),
                                                                        shape:
                                                                            MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: ColorUtils.violetButtonColor)))),
                                                                    onPressed: () {
                                                                      if (_nameController
                                                                          .text
                                                                          .isEmpty) {
                                                                        showAlertDialog(
                                                                            context,
                                                                            "Please enter name");
                                                                      } else if (_emailController
                                                                              .text
                                                                              .isEmpty ||
                                                                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController
                                                                              .text)) {
                                                                        showAlertDialog(
                                                                            context,
                                                                            "Please enter valid email");
                                                                      } else if (_mobileNumberController
                                                                          .text
                                                                          .isEmpty) {
                                                                        showAlertDialog(
                                                                            context,
                                                                            "Please enter mobile number");
                                                                      }
                                                                      /*      else if (_dobController
                                                            .text.length ==
                                                            0) {
                                                          showAlertDialog(context,
                                                              "Please enter date of birth");
                                                        }*/
                                                                      else if (_ageController
                                                                          .text
                                                                          .isEmpty) {
                                                                        showAlertDialog(
                                                                            context,
                                                                            "Please enter age");
                                                                      } else if (selectedGender!
                                                                          .isEmpty) {
                                                                        showAlertDialog(
                                                                            context,
                                                                            "Please enter gender");
                                                                      } else if (_addressController
                                                                          .text
                                                                          .isEmpty) {
                                                                        showAlertDialog(
                                                                            context,
                                                                            "Please enter address");
                                                                      } else if (_zipCodeController
                                                                          .text
                                                                          .isEmpty) {
                                                                        showAlertDialog(
                                                                            context,
                                                                            "Please enter zipcode");
                                                                      } else {
                                                                        updateProfile();
                                                                      }
                                                                    }))),
                                                  ])),
                                              onTap: () async {
                                                if (_nameController
                                                    .text.isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter name");
                                                } else if (_emailController
                                                        .text.isEmpty ||
                                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(
                                                            _emailController
                                                                .text)) {
                                                  showAlertDialog(context,
                                                      "Please enter valid email");
                                                } else if (_mobileNumberController
                                                    .text.isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter mobile number");
                                                } else if (_dobController
                                                    .text.isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter date of birth");
                                                } else if (_ageController
                                                    .text.isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter age");
                                                } else if (selectedGender!
                                                    .isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter gender");
                                                } else if (_addressController
                                                    .text.isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter address");
                                                } else if (_zipCodeController
                                                    .text.isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter zipcode");
                                                } else {
                                                  updateProfile();
                                                }
                                              }),
                                          //row
                                        ])))),
                        SpinKitFadingCircleWidget(isLoading)
                      ]),
                    )
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
    debugPrint('gender---   ${selectedGender.toString()} ');
    var request = http.MultipartRequest('POST',
        Uri.parse('https://trendychikitsa.com/api/client_edit_profile/'));

    request.fields['client_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['client_name'] = _nameController.text.toString();
    request.fields['client_email'] = _emailController.text.toString();
    request.fields['client_phone'] = _mobileNumberController.text.toString();
    if (selectedGender!.toString().trim() == 'Female') {
      debugPrint('gender---  2 ');
      request.fields['client_gender'] = '2';
    } else if (selectedGender!.toString().trim() == 'Male') {
      request.fields['client_gender'] = '1';
      debugPrint('gender---  1 ');
    }
    /* request.fields['client_gender'] = selectedGender.toString();
*/
    request.fields['client_age'] = _ageController.text.toString();
    request.fields['client_pincode'] = _zipCodeController.text.toString();
    request.fields['client_dob'] = _dobController.text.toString();
    request.fields['client_address'] = _addressController.text.toString();

    /*  if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'user_profile', _imageFile!.path.toString()));
    }*/
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
                  data["msg"] == "Profile Updated Successfully!!!") {
                showAlertDialog(context, "Success! Updated Successfully.");
                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  setState(() {});
                  /*   Navigator.pop(context);*/
                });
              } else {
                showAlertDialog(context, data["msg"]);
                Future.delayed(const Duration(seconds: 1), () {
                  isLoading = false;
                  setState(() {});
                });
                UtilMethods.showSnackBar(context, data["msg"]);
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

  Widget _previewImage() {
    if (_imageFile != null) {
      return CircleAvatar(
        radius: 90.0,
        backgroundImage: FileImage(File(_imageFile!.path.toString())),
        backgroundColor: Colors.transparent,
      ) /*Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: FileImage(File(_imageFile!.path.toString())),
              fit: BoxFit.fill),
        ),
      )*/
          ;
    } else if (image_url != null) {
      return CircleAvatar(
        radius: 90.0,
        backgroundImage: NetworkImage(image_url.toString()),
        backgroundColor: Colors.transparent,
      ) /*Container(
        margin: EdgeInsets.only(top: 1.h),

        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(image_url.toString()), fit: BoxFit.fill),
        ),
      )*/
          ;
    } else {
      return const CircleAvatar(
        radius: 90.0,
        backgroundImage: AssetImage(
          ('assets/images/student.jpg'),
        ),
      );
      Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 100,
        height: 100,
        child: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(
            ('assets/images/fb_logo.png'),
          ),
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(
                'assets/images/profile_bg.png',
              ),
              fit: BoxFit.fill),
        ),
      );
    }
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: Container(
            height: 50,
            alignment: Alignment.center,
            color: ColorUtils.trendyButtonColor,
            child: const Text(
              "Alert !!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            )),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     GestureDetector(
        //         onTap: () {
        //           Navigator.of(context).pop();
        //         },
        //         child: SizedBox(
        //             width: 60.w,
        //             child: Text(msg,
        //                 textAlign: TextAlign.left,
        //                 style: const TextStyle(
        //                     fontWeight: FontWeight.normal,
        //                     color: Colors.black87,
        //                     fontSize: 18)))),
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
                        border:
                            Border.all(color: ColorUtils.trendyButtonColor)),
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

          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //         onTap: () {
          //           Navigator.of(context).pop();
          //         },
          //         child: Text("Ok",
          //             textAlign: TextAlign.left,
          //             style: TextStyle(
          //                 fontWeight: FontWeight.normal,
          //                 color: ColorUtils.appDarkBlueColor,
          //                 fontSize: 18))),
          //   ],
          // )
        ]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  DateTime selectedDate = DateTime.now();
  bool currentDate = true;
  String initialdate = "", selectedInitialDate = "";
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorUtils.appDarkBlueColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black87, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    ColorUtils.headerTextColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        var temp = DateTime.now().toUtc();
        var d1 = DateTime.utc(temp.year, temp.month, temp.day);
        var d2 = DateTime.utc(selected.year, selected.month,
            selected.day); //you can add today's date here
        if (d2.compareTo(d1) == 0) {
          currentDate = true;
          print('true');
        } else {
          currentDate = false;
          print('false');
        }

        selectedDate = selected;
        print('selected date--   $selectedDate');
        final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
        final String formatted1 = formatter1.format(selected);

        selectedInitialDate = selectedDate.toString().substring(0, 10);
        print('selected initial date---   $selectedInitialDate');
        _dobController.text = selectedInitialDate;
        final DateFormat formatter = DateFormat('MMMM d, yyyy');
        final String formatted = formatter.format(selectedDate);
        //   initialdate = formatted;
        /*   initialdate=selectedDate.toString();*/
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {});
        });
      });
    }
  }

  FetchClientProfileDetails? _clientProfileDetails;

  Future<FetchClientProfileDetails?> getFetchProfileData() async {
    var data;
    try {
      print(
          'fetched healer id-   ${prefs!.getString(StringUtils.id).toString()}');
      var request = http.MultipartRequest('POST', BaseuURL.client_details);

      request.fields['client_id'] =
          prefs!.getString(StringUtils.id).toString() /*'52'*/;
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
        print('--->>?   $data');

        if (data["status"] == "true" && data["msg"] == "success") {
          print('getFetchProfileData--    ');

          final jsonResponse = json.decode(responsed.body);

          _clientProfileDetails =
              FetchClientProfileDetails.fromJson(jsonResponse);

          _nameController.text =
              _clientProfileDetails!.response![0].clName.toString();
          _emailController.text =
              _clientProfileDetails!.response![0].clEmail.toString();
          _mobileNumberController.text =
              _clientProfileDetails!.response![0].clTelephone.toString();
          /* _dobController.text =_clientProfileDetails!.response![0].clDob.toString();
         */
          _zipCodeController.text =
              _clientProfileDetails!.response![0].clPin.toString();
          _addressController.text =
              _clientProfileDetails!.response![0].clAddress.toString();
          _ageController.text =
              _clientProfileDetails!.response![0].clAge.toString();
          selectedGender =
              _clientProfileDetails!.response![0].clGender.toString();
          print(
              'client dob--   ${_clientProfileDetails!.response![0].clDob.toString()}');
          if (_clientProfileDetails!.response![0].clDob.toString() == 'null') {
            _dobController.text = "--";
          } else {
            _dobController.text =
                _clientProfileDetails!.response![0].clDob.toString();
          }
        }
      }

      setState(() {});
    } catch (e) {
      print('exce --   ${e.toString()}    ');
    }
    return _clientProfileDetails;
  }
}
