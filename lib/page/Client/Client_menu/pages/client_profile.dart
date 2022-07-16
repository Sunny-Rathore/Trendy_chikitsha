import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'dart:ui';
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
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ClientProfileSetting extends StatefulWidget {
  String from_page = "";

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
    'Other',
  ];
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
  TextEditingController _classController = TextEditingController();
  int value = 1, pricingValue = 1;

  String? selectedSpinnerItem,
      selectedSpinnerItem1,
      selectedCityItem,
      selectedStateItem,
      class_id = "",
      stateId = "",
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
                                              value: selectedCityItem,
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
                                                  dropdownvalue = newValue!;
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

                                          InkWell(   child: Container(
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
                                                          'Save Changes'
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            fontFamily: StringUtils
                                                                .roboto_font_family,
                                                            fontSize: 17,
                                                            color: ColorUtils
                                                                .whiteColor,
                                                            letterSpacing: 0.75,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            height: 1.2,
                                                          )),
                                                      style: ButtonStyle(
                                                          elevation:
                                                          MaterialStateProperty.all(
                                                              0),
                                                          foregroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                              ColorUtils
                                                                  .violetButtonColor),
                                                          backgroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                              ColorUtils
                                                                  .violetButtonColor),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0), side: BorderSide(color: ColorUtils.violetButtonColor)))),
                                                      onPressed: () {

                                                      }))),
                                        ])),
                                    onTap: () async {}),
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
    /*   Map<String, String> headers = {'Authorization': prefs.getString(StringConstant.token)};
*/
    var request = http.MultipartRequest('POST',
        Uri.parse('https://www.techtradedu.com/conceptlive/api/edit_profile'));
    //   request.headers.addAll(headers);
   /* request.fields['user_id'] =
        prefs!.getString(StringUtils.teacher_id).toString();*/
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
      return CircleAvatar(
        radius: 90.0,
        backgroundImage: AssetImage(
          ('assets/images/student.jpg'),
        ),
      );
      Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 100,
        height: 100,
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(
            ('assets/images/fb_logo.png'),
          ),
        ),
        decoration: BoxDecoration(
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
}
