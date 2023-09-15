import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/all_therapy_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_issue_list.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_profile_fetch_data.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/healer_pricing_plan.dart';
import 'package:trendy_chikitsa/page/hp.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/utils/utils_methods.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';

class ProfileSetting extends StatefulWidget {
  String from_page = "";

  ProfileSetting({super.key});

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
  List<TextEditingController?>? custom_rating = [];
  List<List<MyList>> issueIndex = [];
  List<String> fileNameList = [];
  final List<String> _animals = [
    'Career related issues',
    'Excellence in sports',
    'Excellence in academics',
    'Memory and concentration issue',
    'Depression',
    'Stress',
    'Anxiety',
    'Sleep issues',
    'Physical health and injury',
    'Sexual wellbeing',
    'Personal issues',
    'Child counselling',
    'Parenting issues',
    'Public and peer relationships',
    'Differently abled people',
    'Confidence issue',
    'Indecision',
    'Recruitment Analysis',
    'Planning, Curiosity, Problem solving ability',
    'Corporate programs',
    'All of the above'
  ];
  List<String> selected1 = [];
  List<String> selected = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();
  final nameController = TextEditingController();
  List<int> listOfInt = [];
  String appToken = "";
  bool isLoading = false;
  String share_link = "", title = "Profile";
  PickedFile? _imageFile;
  List<List<String>> issueList = [];
  List<List<String>> multiSelectIssueList = [];
  List<List<int>> issueIndexList = [];
  List<PickedFile?> therapy_certificate = [];
  final ImagePicker _picker = ImagePicker();
  final int _selectedIndex = 0;
  SharedPreferences? prefs;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _keywordsController = TextEditingController();
  final TextEditingController _videoController = TextEditingController();
  int value = 1, pricingValue = 1, maxValue = 9;
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
      stateId = "",
      selectedPricingTherapyItem,
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
    if (prefs!
            .getString(StringUtils.subscriptionPlan)
            .toString()
            .trim()
            .toLowerCase() ==
        'free') {
      setState(() {
        maxValue = 1;
      });
    } else if (prefs!
            .getString(StringUtils.subscriptionPlan)
            .toString()
            .trim()
            .toLowerCase() ==
        '3 months') {
      setState(() {
        maxValue = 3;
      });
    } else if (prefs!
            .getString(StringUtils.subscriptionPlan)
            .toString()
            .trim()
            .toLowerCase() ==
        '6 months') {
      setState(() {
        maxValue = 5;
      });
    } else if (prefs!
            .getString(StringUtils.subscriptionPlan)
            .toString()
            .trim()
            .toLowerCase() ==
        '1 year') {
      setState(() {
        maxValue = 9;
      });
    }
    print(maxValue);
    print(prefs!.getString(StringUtils.subscriptionPlan));
    print('selcted city   ${prefs!.getString(StringUtils.city)}');

    setState(() {});
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
                  /* leading: new IconButton(
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
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          side: BorderSide(color: ColorUtils.violetButtonColor)))),
                                              onPressed: () {
                                                isLoading = true;
                                                setState(() {});
                                                if (_nameController.text
                                                    .toString()
                                                    .trim()
                                                    .isEmpty) {
                                                  showAlertDialog(context,
                                                      'Please enter full name');
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (_emailController
                                                        .text.isEmpty ||
                                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(
                                                            _emailController
                                                                .text)) {
                                                  showAlertDialog(context,
                                                      "Please enter valid email");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (_mobileNumberController
                                                        .text.length !=
                                                    10) {
                                                  showAlertDialog(context,
                                                      "Please enter 10 digit mobile number");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (_ageController
                                                    .text.isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter age");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (selectedGender
                                                            .toString()
                                                            .trim() ==
                                                        "Select Gender" ||
                                                    selectedGender == null ||
                                                    selectedGender
                                                        .toString()
                                                        .trim()
                                                        .isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please select gender");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (selectPricingTherapyItemList
                                                    .isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please add atlease one pricing plan");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else {
                                                  updateProfile();
                                                }
                                              }))),
                                ])),
                            onTap: () async {
                              isLoading = true;
                              setState(() {});
                              if (_nameController.text
                                  .toString()
                                  .trim()
                                  .isEmpty) {
                                showAlertDialog(
                                    context, 'Please enter full name');
                                isLoading = false;
                                setState(() {});
                              } else if (_emailController.text.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(_emailController.text)) {
                                showAlertDialog(
                                    context, "Please enter valid email");
                                isLoading = false;
                                setState(() {});
                              } else if (_mobileNumberController.text.length !=
                                  10) {
                                showAlertDialog(context,
                                    "Please enter 10 digit mobile number");
                                isLoading = false;
                                setState(() {});
                              } else if (_ageController.text.isEmpty) {
                                showAlertDialog(context, "Please enter age");
                                isLoading = false;
                                setState(() {});
                              } else if (selectedGender.toString().trim() ==
                                      "Select Gender" ||
                                  selectedGender == null ||
                                  selectedGender.toString().trim().isEmpty) {
                                showAlertDialog(
                                    context, "Please select gender");
                                isLoading = false;
                                setState(() {});
                              } else if (selectPricingTherapyItemList.isEmpty) {
                                showAlertDialog(context,
                                    "Please add atlease one pricing plan");
                                isLoading = false;
                                setState(() {});
                              } else {
                                updateProfile();
                              }
                            }),
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
                                          SizedBox(
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
                                                  hintText: 'Enter name'),
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
                                                  /*   onTap: (){
                                                _selectDate(context);
                                              },*/

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
                                            height: 20.h,
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
                                              controller: _aboutMeController,
                                              /*enabled: false,*/
                                              minLines: 6,
                                              maxLength: 350,
                                              maxLines: null,
                                              keyboardType:
                                                  TextInputType.multiline,
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
                                                  hintText:
                                                      'Write about you.. '),
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
                                            child: TextField(
                                              controller: _keywordsController,
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
                                            child: TextField(
                                              controller: _videoController,
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Expertise ${index + 1}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color:
                                                        ColorUtils.blackColor,
                                                    fontSize: 18,
                                                  )),
                                              Visibility(
                                                  visible: index > 0,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        if (expertiseList
                                                                .length >
                                                            index) {
                                                          deleteExpertise(
                                                              expertiseList[
                                                                      index]!
                                                                  .expertise_id
                                                                  .toString(),
                                                              (index + 1)
                                                                  .toString());
                                                        } else {
                                                          value = value - 1;
                                                          selectTherapyItemList
                                                              .removeAt(index);
                                                          expInMonths
                                                              .removeAt(index);
                                                          experienceInYearControllerList!
                                                              .removeAt(index);
                                                          multiSelectIssueList
                                                              .removeAt(index);
                                                          fileNameList
                                                              .removeAt(index);
                                                          therapy_certificate
                                                              .removeAt(index);
                                                        }
                                                        setState(() {});
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: ColorUtils
                                                            .darkPinkColor,
                                                        size: 30,
                                                      ))),
                                            ],
                                          ) /*Align(
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
                                                  )))*/
                                          ),
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
                                          value: selectTherapyItemList.length >=
                                                      index &&
                                                  selectTherapyItemList[
                                                          index] ==
                                                      ''
                                              ? selectedCityItem
                                              : selectTherapyItemList[index],
                                          hint: Container(
                                            child: const Text('Select Therapy'),
                                          ),
                                          // Down Arrow Icon
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ColorUtils.greyColor,
                                            size: 30,
                                          ),

                                          items: therapyList.map((item) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                  item.therapy_name.toString(),
                                                  style: const TextStyle(
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.h,
                                            left: 3.5.w,
                                            right: 3.5.w),
                                        child: DropDownMultiSelect<String>(
                                          // Specify the generic type 'String'
                                          onChanged: (List<String> x) {
                                            // Specify the type 'String'
                                            setState(() {
                                              List<String> selected1 = [];

                                              selected1 = x;

                                              var stringList =
                                                  selected1.join(" ");
                                              print(stringList);
                                              multiSelectIssueList
                                                  .removeAt(index);
                                              multiSelectIssueList.insert(
                                                  index, selected1);
                                            });
                                          },
                                          options:
                                              _animals, // Specify the type 'List<String>'
                                          selectedValues: multiSelectIssueList !=
                                                  null
                                              ? multiSelectIssueList[index]
                                              : <String>[], // Specify the type 'List<String>'
                                          whenEmpty: 'Select Something',
                                        ),
                                      ),
                                      /*     Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h, left: 2.w, right: 2.w),
                                          child: GFMultiSelect(
                                            items: _animals,
                                            initialSelectedItemsIndex: issueIndexList[index] !=
                                                null
                                                ? issueIndexList![index]
                                                : [],
                                            onSelect: (value1) {
                                              print('selected $value1');

                                              print('selected $value1');
                                              print(
                                                  'selected ${value1.length}');
                                              for (int j = 0; j <
                                                  value1.length; j++) {
                                                for (int i = 0; i <
                                                    _animals.length; i++) {
                                                  print(
                                                      'selected-- ${value1[j]}   ${_animals[i]}');
                                                }
                                              }
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
                                          )),*/
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
                                        child: TextField(
                                          controller: experienceInYearControllerList !=
                                                      null &&
                                                  experienceInYearControllerList!
                                                      .isNotEmpty
                                              ? experienceInYearControllerList![
                                                  index]
                                              : null,
                                          keyboardType: TextInputType.number,
                                          enabled: true,
                                          textAlign: TextAlign.left,
                                          decoration: InputDecoration(
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
                                              experienceInYearControllerList![
                                                      index]!
                                                  .text = text.toString();

                                              experienceInYearControllerList![
                                                          index]!
                                                      .selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset:
                                                              experienceInYearControllerList![
                                                                      index]!
                                                                  .text
                                                                  .length));
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
                                          value: expInMonths.length >= index &&
                                                  expInMonths[index] == ''
                                              ? selectedCityItem
                                              : expInMonths[index],
                                          /*expInMonths[index]*/
                                          hint: Container(
                                            child: const Text('0'),
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
                                          padding: const EdgeInsets.only(
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
                                      Visibility(
                                          visible: true,
                                          /*expertiseList.length>index?expertiseList[index]!
                                              .therapyCertificate1.toString() ==
                                              "" ? false : true:true,*/
                                          child: Container(
                                              height: 8.h,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 1),
                                              margin: const EdgeInsets.only(
                                                  top: 10, left: 15, right: 15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: ColorUtils.greyColor,
                                                ),
                                                color: ColorUtils.whiteColor,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  /*  new Text('+91 ',
                                textAlign:
                                TextAlign.left,
                                style: TextStyle(

                                  color:Constant
                                      .blackColor,
                                  fontSize: 19,
                                )),*/
                                                  const SizedBox(
                                                    width: 0,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: SizedBox(
                                                        width: 67.w,
                                                        child: Text(
                                                            fileNameList.length >=
                                                                    index
                                                                ? fileNameList[
                                                                        index]
                                                                    .toString()
                                                                    .split('/')
                                                                    .last
                                                                : 'File Name' /* 'File Name'*/,
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              color: ColorUtils
                                                                  .blackColor,
                                                              fontSize: 17,
                                                            ))),

                                                    //flexible
                                                  ),
                                                  Visibility(
                                                      visible:
                                                          fileNameList[index] ==
                                                                  'File Name'
                                                              ? false
                                                              : true,
                                                      child: InkWell(
                                                          onTap: () async {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (context) =>
                                                                    SizedBox(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        //color: Colors
                                                                        //.red,
                                                                        child:
                                                                            SizedBox(
                                                                          child:
                                                                              MyWidget(
                                                                            hid:
                                                                                prefs!.getString(StringUtils.id).toString(),
                                                                          ),
                                                                        )));
                                                          },
                                                          child: SizedBox(
                                                              height: 8.h,
                                                              width: 83,
                                                              child: ColoredBox(
                                                                color: ColorUtils
                                                                    .lightGreyBorderColor,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        'View',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              StringUtils.roboto_font_family,
                                                                          color:
                                                                              ColorUtils.blackColor,
                                                                          fontSize:
                                                                              17,
                                                                        ))),
                                                              )))),
                                                  Visibility(
                                                      visible:
                                                          fileNameList[index] ==
                                                                  'File Name'
                                                              ? true
                                                              : false,
                                                      child: InkWell(
                                                          onTap: () async {
                                                            _pickCertificates(
                                                                index);
                                                          },
                                                          child: SizedBox(
                                                              height: 8.h,
                                                              width: 83,
                                                              child: ColoredBox(
                                                                color: ColorUtils
                                                                    .lightGreyBorderColor,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        'Browse',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              StringUtils.roboto_font_family,
                                                                          color:
                                                                              ColorUtils.blackColor,
                                                                          fontSize:
                                                                              17,
                                                                        ))),
                                                              )))),
                                                ], //widget
                                              ))),
                                      Visibility(
                                          visible: index + 1 == value,
                                          child: InkWell(
                                              onTap: () {
                                                // setState(() {
                                                //   if (value < maxValue) {
                                                //     value = value + 1;
                                                //     selectTherapyItemList
                                                //         .add('');
                                                //     expInMonths.add('0');
                                                //     experienceInYearControllerList!
                                                //         .add(
                                                //             TextEditingController());
                                                //     multiSelectIssueList
                                                //         .add([]);

                                                //     fileNameList
                                                //         .add('File Name');
                                                //     therapy_certificate.insert(
                                                //         index, null);
                                                //   }
                                                // });
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
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (value <
                                                                maxValue) {
                                                              value = value + 1;
                                                              selectTherapyItemList
                                                                  .add('');
                                                              expInMonths
                                                                  .add('0');
                                                              experienceInYearControllerList!
                                                                  .add(
                                                                      TextEditingController());
                                                              multiSelectIssueList
                                                                  .add([]);
                                                              fileNameList.add(
                                                                  'File Name');
                                                              therapy_certificate
                                                                  .insert(index,
                                                                      null);
                                                            } else {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const HealerPricingPlan()));
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                            'Add More Expertise',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family_bold,
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontSize: 19,
                                                            )),
                                                      ))))),
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
                                                  child: Text(
                                                      'Your Pricing Plan ',
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Plan ${index + 1}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color:
                                                        ColorUtils.blackColor,
                                                    fontSize: 18,
                                                  )),
                                              Visibility(
                                                  visible: index > 0,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        if (pricingList.length >
                                                            index) {
                                                          deletePricing(
                                                              pricingList[
                                                                      index]!
                                                                  .thId
                                                                  .toString(),
                                                              index);
                                                        } else {
                                                          pricingValue =
                                                              pricingValue - 1;
                                                          selectPricingTherapyItemList
                                                              .removeAt(index);
                                                          custom_rating!
                                                              .removeAt(index);
                                                        }
                                                        setState(() {});
                                                        /* selectTherapyItemList
                                                .add('');
                                            expInMonths.add('0');
                                            experienceInYearControllerList!
                                                .add(
                                                TextEditingController());
                                            multiSelectIssueList.add([]);
                                            fileNameList.add('File Name');
                                            therapy_certificate.insert(index, null);*/
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: ColorUtils
                                                            .darkPinkColor,
                                                        size: 30,
                                                      ))),
                                            ],
                                          ) /*Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Plan ${index + 1}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color:
                                                        ColorUtils.blackColor,
                                                    fontSize: 18,
                                                  )))*/
                                          ),
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
                                          value: selectPricingTherapyItemList
                                                          .length >=
                                                      index &&
                                                  selectPricingTherapyItemList[
                                                          index] ==
                                                      ''
                                              ? selectedPricingTherapyItem
                                              : selectPricingTherapyItemList[
                                                  index],
                                          /*  value: selectTherapyItemList !=
                                                      null &&
                                                  selectPricingTherapyItemList
                                                          .length >=
                                                      index &&
                                                  selectPricingTherapyItemList[
                                                          index] ==
                                                      ''
                                              ? selectedPricingTherapyItem
                                              : selectPricingTherapyItemList[
                                                  index],*/
                                          hint: Container(
                                            child: const Text('Select Therapy'),
                                          ),
                                          // Down Arrow Icon
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ColorUtils.greyColor,
                                            size: 30,
                                          ),
                                          items: /*therapyList*/
                                              selectTherapyItemList.map((item) {
                                            return DropdownMenuItem(
                                              child: Text(item.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                      fontSize: 15)),
                                              value: item.toString(),
                                            );
                                          }).toList(),

                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectPricingTherapyItemList[
                                                  index] = newValue!;
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
                                        child: TextField(
                                          controller: custom_rating != null &&
                                                  custom_rating!.isNotEmpty
                                              ? custom_rating![index]
                                              : null,
                                          keyboardType: TextInputType.number,
                                          enabled: true,
                                          textAlign: TextAlign.left,
                                          decoration: InputDecoration(
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
                                              custom_rating![index]!.text =
                                                  text.toString();

                                              custom_rating![index]!.selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset:
                                                              experienceInYearControllerList![
                                                                      index]!
                                                                  .text
                                                                  .length));

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
                                                  selectPricingTherapyItemList
                                                      .add('');
                                                  custom_rating!.add(
                                                      TextEditingController());
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
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          side: BorderSide(color: ColorUtils.violetButtonColor)))),
                                              onPressed: () {
                                                isLoading = true;
                                                setState(() {});

                                                print(
                                                    'pricing plan list---   ${selectPricingTherapyItemList.length}   ${selectPricingTherapyItemList[0].toString().trim().length} ');
                                                if (_nameController.text
                                                    .toString()
                                                    .trim()
                                                    .isEmpty) {
                                                  showAlertDialog(context,
                                                      'Please enter full name');
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (_emailController
                                                        .text.isEmpty ||
                                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(
                                                            _emailController
                                                                .text)) {
                                                  showAlertDialog(context,
                                                      "Please enter valid email");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (_mobileNumberController
                                                        .text.length !=
                                                    10) {
                                                  showAlertDialog(context,
                                                      "Please enter 10 digit mobile number");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (_ageController
                                                    .text.isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please enter age");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (selectedGender
                                                            .toString()
                                                            .trim() ==
                                                        "Select Gender" ||
                                                    selectedGender == null ||
                                                    selectedGender
                                                        .toString()
                                                        .trim()
                                                        .isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please select gender");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else if (selectPricingTherapyItemList
                                                        .isNotEmpty &&
                                                    selectPricingTherapyItemList[
                                                            0]
                                                        .toString()
                                                        .trim()
                                                        .isEmpty) {
                                                  showAlertDialog(context,
                                                      "Please add atlease one pricing plan");
                                                  isLoading = false;
                                                  setState(() {});
                                                } else {
                                                  updateProfile();
                                                }
                                              }))),
                                ])),
                            onTap: () async {
                              isLoading = true;
                              setState(() {});
                              if (_nameController.text
                                  .toString()
                                  .trim()
                                  .isEmpty) {
                                showAlertDialog(
                                    context, 'Please enter full name');
                                isLoading = false;
                                setState(() {});
                              } else if (_emailController.text.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(_emailController.text)) {
                                showAlertDialog(
                                    context, "Please enter valid email");
                                isLoading = false;
                                setState(() {});
                              } else if (_mobileNumberController.text.length !=
                                  10) {
                                showAlertDialog(context,
                                    "Please enter 10 digit mobile number");
                                isLoading = false;
                                setState(() {});
                              } else if (_ageController.text.isEmpty) {
                                showAlertDialog(context, "Please enter age");
                                isLoading = false;
                                setState(() {});
                              } else if (selectedGender.toString().trim() ==
                                      "Select Gender" ||
                                  selectedGender == null ||
                                  selectedGender.toString().trim().isEmpty) {
                                showAlertDialog(
                                    context, "Please select gender");
                                isLoading = false;
                                setState(() {});
                              } else if (selectPricingTherapyItemList.isEmpty) {
                                showAlertDialog(context,
                                    "Please add atlease one pricing plan");
                                isLoading = false;
                                setState(() {});
                              } else {
                                updateProfile();
                              }
                            }),
                      ]),
                    ),
                    SpinKitFadingCircleWidget(
                        isLoading) /*;
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

  void _pickCertificates(int index) async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        therapy_certificate.insert(index, pickedFile);
        fileNameList.insert(index, pickedFile!.path.split('/').last);
      });
      //  var res = await uploadImage(_imageFile!.path.toString());
      // print(res);
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  Future<String?> updateProfile() async {
    var data;
    print(
        'fetched healer id-   ${prefs!.getString(StringUtils.id).toString()}');

    var request = http.MultipartRequest('POST', BaseuURL.update_healer_profile);
    request.fields['healer_id'] = /*'52'*/
        prefs!.getString(StringUtils.id).toString();
    request.fields['healer_name'] = _nameController.text.toString();
    request.fields['healer_email'] = _emailController.text.toString();
    request.fields['healer_telephone'] =
        _mobileNumberController.text.toString();
    request.fields['healer_dob'] = _dobController.text.toString();

    request.fields['healer_age'] = _ageController.text.toString();
    if (selectedGender!.toString().trim() == 'Female') {
      debugPrint('healer_gender---  2 ');
      request.fields['healer_gender'] = '2';
    } else if (selectedGender!.toString().trim() == 'Male') {
      request.fields['healer_gender'] = '1';
      debugPrint('healer_gender---  1 ');
    }
    //   request.fields['healer_gender'] = selectedGender.toString();
    request.fields['healer_address'] = _addressController.text.toString();
    request.fields['healer_pin'] = _zipCodeController.text.toString();
    request.fields['healer_about'] = _aboutMeController.text.toString();
    request.fields['healer_keywords'] = _keywordsController.text.toString();

    /*  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'*/
    for (int i = 0; i < pricingValue; i++) {
      print(
          'therapy_name[$i] --    ${selectPricingTherapyItemList[i].toString()}');

      request.fields['therapy_name[$i]'] =
          selectPricingTherapyItemList[i].toString();
    }
    for (int i = 0; i < pricingValue; i++) {
      print(
          'custom_rating_count[$i] --    ${custom_rating![i]!.text.toString()}');

      request.fields['custom_rating_count[$i]'] =
          custom_rating![i]!.text.toString();
    }
    for (int i = 0; i < value; i++) {
      print(
          'therapy_name${i + 1} --    ${selectTherapyItemList[i].toString()}');
      request.fields['therapy_name${i + 1}'] =
          selectTherapyItemList[i].toString();
    }
    for (int i = 0; i < multiSelectIssueList.length; i++) {
      var stringList = multiSelectIssueList[i].join(" ");
      request.fields['issues${i + 1}[]'] = stringList;
      print('issues${i + 1}[]    $stringList');
    }

    for (int i = 0; i < value; i++) {
      print(
          'experience_year${i + 1} --    ${experienceInYearControllerList![i]!.text.toString()}');

      request.fields['experience_year${i + 1}'] =
          experienceInYearControllerList![i]!.text.toString();
    }

    for (int i = 0; i < value; i++) {
      print('experience_month${i + 1} --    ${expInMonths[i]!.toString()}');

      request.fields['experience_month${i + 1}'] = expInMonths[i]!.toString();
    }

    for (int i = 0; i < value; i++) {
      print('therapy_certificate${i + 1} -- ');
      if (therapy_certificate[i] != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'therapy_certificate${i + 1}',
            therapy_certificate[i]!.path.toString()));
      }
    }
    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'healer_profile', _imageFile!.path.toString()));
    }
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

              if (data["status"] == "true" && data["msg"] == "success") {
                print('Success! Updated Successfully.---    ');
                showAlertDialog(context, "Success! Updated Successfully.");
                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  setState(() {});
                  /*  Navigator.pop(context);*/
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
      return const CircleAvatar(
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
      print(
          'fetched healer id-   ${prefs!.getString(StringUtils.id).toString()}');
      var request =
          http.MultipartRequest('POST', BaseuURL.healerprofile_detail);

      request.fields['healer_id'] =
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

        if (data["status"] == "true" && data["response"] == "success") {
          print('getFetchProfileData--    ');

          final jsonResponse = json.decode(responsed.body);
          selectPricingTherapyItemList.clear();
          _healerProfileFetchData =
              HealerProfileFetchData.fromJson(jsonResponse);
          expertiseList =
              _healerProfileFetchData!.expertise!.cast<Expertise?>();
          pricingList = _healerProfileFetchData!.pricing!.cast<Pricing?>();

          _nameController.text = _healerProfileFetchData!.healerName.toString();
          _emailController.text =
              _healerProfileFetchData!.healerEmail.toString();
          _mobileNumberController.text =
              _healerProfileFetchData!.healerTelephone.toString();
          _zipCodeController.text = _healerProfileFetchData!.pinCode.toString();
          _addressController.text = _healerProfileFetchData!.address.toString();

          if (_healerProfileFetchData!.dateOfBirth.toString().trim() ==
              'null') {
            _dobController.text = 'YYYY-MM-DD';
          } else {
            _dobController.text =
                _healerProfileFetchData!.dateOfBirth.toString();
          }

          if (_healerProfileFetchData!.about.toString().trim() == "null") {
            _aboutMeController.text = '';
          } else {
            _aboutMeController.text = _healerProfileFetchData!.about.toString();
          }
          if (_healerProfileFetchData!.keywords.toString().trim() == 'null') {
            _keywordsController.text = '';
          } else {
            _keywordsController.text =
                _healerProfileFetchData!.keywords.toString();
          }

          if (_healerProfileFetchData!.videoLink.toString().trim() == 'null') {
            _videoController.text = '';
          } else {
            _videoController.text =
                _healerProfileFetchData!.videoLink.toString();
          }

          _ageController.text = _healerProfileFetchData!.healer_age.toString();

          selectedGender = _healerProfileFetchData!.gender.toString();
          debugPrint(
              'check profile url--  ${_healerProfileFetchData!.healerProfile.toString()} ');
          if (_healerProfileFetchData!.healerProfile
              .toString()
              .trim()
              .isNotEmpty) {
            image_url = _healerProfileFetchData!.healerProfile.toString();
          }
          print('expertiseList.length--${expertiseList.length}    ');
          value = expertiseList.length;
          if (pricingList.isNotEmpty) {
            pricingValue = pricingList.length;
          } else {
            pricingValue = 1;
          }

          print(
              'pricingValue.length--$pricingValue , ${pricingList.length}   ');

          if (expertiseList.isNotEmpty) {
            value = expertiseList.length;

            print('expertiseList.length--dfdsfds${expertiseList.length}    ');

            for (int i = 0; i < expertiseList.length; i++) {
              print(
                  'expertiseList.length inside loop --   ${expertiseList[i]!.therapyName1.toString()}    ');
              selectTherapyItemList
                  .add(expertiseList[i]!.therapyName1.toString());
              expInMonths.add(expertiseList[i]!.experienceMonth1.toString());
              experienceInYearControllerList!.add(TextEditingController());
              experienceInYearControllerList![i]!.text =
                  expertiseList[i]!.experienceYear1.toString();

              multiSelectIssueList.add(expertiseList[i]!.issues1!.split(', '));
              if (expertiseList[i]!.therapyCertificate1!.isNotEmpty) {
                fileNameList
                    .add(expertiseList[i]!.therapyCertificate1.toString());
              } else {
                fileNameList.add('File Name');
              }
              therapy_certificate.add(null);

              print(' issueList --   ${multiSelectIssueList.length}    ');

              /*   for (int i = 0; i < issueList.length; i++) {
                print(
                    ' value of i --   ${ i}  ${issueList[i].length}  ');

                for (int k = 0; k < issueList[i].length; k++) {
                  print(
                      ' value of k --   ${ k}    ');
                  print(
                      ' issueList[i][k]   -- ${issueList[i][k]} ');
                  for (int j = 0; j < _animals.length; j++) {
                    print(
                        ' value of j --   ${ j}    ');
                    print(
                        ' issueList[i][k]   --${i}, ${k} ${issueList[i][k]} , ${_animals[j]}');

                    if (issueList[i][k].trim() == _animals[j]!.trim()) {
                      print(
                          'issueIn--     ');
                      listOfInt.add(j);
                    }
                  }
                }
                issueIndexList.add(listOfInt);
                print(
                    'In--issueIndexList.length   ${ issueIndexList[0]
                        .length}    ');
                listOfInt.clear();
                setState(() {

                });
              }*/

              print(
                  'expertiseList.length inside loop11 --   ${selectTherapyItemList[i]}    ');
            }
          }

          if (pricingList.isNotEmpty) {
            pricingValue = pricingList.length;
            print('pricingList.length--dfdsfds${pricingList.length}    ');

            for (int i = 0; i < pricingList.length; i++) {
              print(
                  'pricingList.length inside loop --   ${pricingList[i]!.therapyName.toString()}    ');
              selectPricingTherapyItemList
                  .add(pricingList[i]!.therapyName.toString());
              custom_rating!.add(TextEditingController());
              custom_rating![i]!.text = pricingList[i]!.customPrice.toString();

              print(
                  'pricingList.length inside loop --   ${selectPricingTherapyItemList[i]}    ');
            }
          } else {
            selectPricingTherapyItemList.add('');
            custom_rating!.add(TextEditingController());
          }
        } else {
          expertiseList.clear();
          selectTherapyItemList.clear();
          selectPricingTherapyItemList.clear();
          experienceInYearControllerList!.clear();
          expInMonths.clear();
          issueList.clear();
          therapy_certificate.clear();
          fileNameList.clear();
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
    var request = http.MultipartRequest('GET', BaseuURL.allTherapies);

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
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        studentAllChapterResponse = AllTherapyResponse.fromJson(jsonResponse);
        /*  setState(() {*/
        therapyList = studentAllChapterResponse.response!;

        //   leadList.add(person.campaignData.indexOf(0));
        /*   });*/
        //  showAlertDialog(context, "Uploaded KYC successfully" );
        setState(() {});
      } else {
        therapyList.clear();
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

  Future<String?> deleteExpertise(String expertiseID, String parameter) async {
    isLoading = true;
    setState(() {});
    var data;
    var request = http.MultipartRequest('POST', BaseuURL.delete_expertise);

    request.fields['expertise_id'] = expertiseID;
    request.fields['parameter'] = parameter;

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

              if (data["status"] == "true" && (data["msg"] == "success")) {
                expertiseList.removeAt(int.parse(parameter) - 1);
                value = value - 1;
                selectTherapyItemList.removeAt(int.parse(parameter) - 1);
                expInMonths.removeAt(int.parse(parameter) - 1);
                experienceInYearControllerList!
                    .removeAt(int.parse(parameter) - 1);
                multiSelectIssueList.removeAt(int.parse(parameter) - 1);
                fileNameList.removeAt(int.parse(parameter) - 1);
                therapy_certificate.removeAt(int.parse(parameter) - 1);
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

  Future<String?> deletePricing(String therapyId, int index) async {
    isLoading = true;
    setState(() {});
    var data;
    var request = http.MultipartRequest('POST', BaseuURL.delete_price);

    request.fields['therapy_id'] = therapyId;

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

              if (data["status"] == "true" && (data["msg"] == "success")) {
                pricingList.removeAt(index);
                pricingValue = pricingValue - 1;
                selectPricingTherapyItemList.removeAt(index);
                custom_rating!.removeAt(index);

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
}
