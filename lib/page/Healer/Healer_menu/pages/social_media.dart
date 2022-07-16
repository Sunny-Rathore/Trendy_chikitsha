import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'dart:ui';
import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/models/healer_responses/get_healer_social_media_response.dart';
import 'package:doctor/models/healer_responses/healer_social_media_response.dart';
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

class SocialMedia extends StatefulWidget {
  String from_page = "";

  @override
  SocialMediastate createState() => SocialMediastate();

/* ProfileSetting({
    Key? key,
    required this.from_page,
  }) : super(key: key);*/
}

class SocialMediastate extends State<SocialMedia> {
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
  TextEditingController _fbController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _instagramController = TextEditingController();
  TextEditingController _pinterestController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();
  TextEditingController _youtubeController = TextEditingController();
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

   getSocialMediaLinks();

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
                    "Social Media",
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.whiteColor,
                      letterSpacing: 0.15,
                      /*  fontWeight: FontWeight.bold,*/
                      fontSize: 20,
                    ),
                  ),
                  actions: <Widget>[],
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(children: [
                        Container(
                            margin: EdgeInsets.only(
                                left: 0, right: 0, top: 0.h, bottom: 0.h),
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
                                                  child: Text('Facebook URL',
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
                                              controller: _fbController,
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
                                                  child: Text('Twitter URL',
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
                                              controller: _twitterController,
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
                                                  child: Text('Instagram URL',
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
                                              controller: _instagramController,
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
                                                  child: Text('Pinterest URL',
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
                                              controller: _pinterestController,
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
                                                  child: Text('Linkedin URL',
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
                                              controller: _linkedinController,
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
                                                  child: Text('Youtube URL',
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
                                              controller: _youtubeController,
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
                        InkWell(
                            child: Container(
                                color: ColorUtils.whiteColor,
                                height: 12.h,
                                child: Column(children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          10.w, 0.h, 10.w, 1.h),
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
                                              onPressed: () {
                                                isLoading=true;
                                                updateSocialMedia();
                                                Future.delayed(Duration(seconds: 3), () {
                                                  setState(() {

                                                    isLoading=false;
                                                  });
                                                  // Do something
                                                });
                                              }))),
                                ])),
                            onTap: () async {
                              isLoading=true;
                              updateSocialMedia();
                              Future.delayed(Duration(seconds: 3), () {
                                setState(() {

                                  isLoading=false;
                                });
                                // Do something
                              });
                            }),

                      ]),
                    ), SpinKitFadingCircleWidget(isLoading)
                  ],
                ));
          });
    });
  }

  Future<String?> updateSocialMedia() async {
    isLoading = true;
    setState(() {});
    var data;
    print(
        'Healer Change Password   ${prefs!.getString(StringUtils.id).toString()}');
    var request = http.MultipartRequest('POST', BaseuURL.socialMediaHealer);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['h_facebook_link'] = _fbController.text.toString().trim();
    request.fields['h_twitter_link'] =
        _twitterController.text.toString().trim();
    request.fields['h_instagram_link'] =
        _instagramController.text.toString().trim();
    request.fields['h_pinterest_link'] =
        _pinterestController.text.toString().trim();
    request.fields['h_linkedin_link'] =
        _linkedinController.text.toString().trim();
    request.fields['h_youtube_link'] =
        _youtubeController.text.toString().trim();

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
                  (data["msg"] == "Success!  Updated successfully.")) {
                SubmitSocialMediaResponse submitSocialMediaResponse =
                    SubmitSocialMediaResponse.fromJson(
                        jsonDecode(response.body));

                showSnackBar(context, data["msg"]);

                prefs!.setString(
                    StringUtils.fbLink,
                    submitSocialMediaResponse.response!.hFacebookLink
                        .toString());
                prefs!.setString(
                    StringUtils.twitterLink,
                    submitSocialMediaResponse.response!.hTwitterLink
                        .toString());
                prefs!.setString(
                    StringUtils.instagramLink,
                    submitSocialMediaResponse.response!.hInstagramLink
                        .toString());
                prefs!.setString(
                    StringUtils.pinterestLink,
                    submitSocialMediaResponse.response!.hPinterestLink
                        .toString());
                prefs!.setString(
                    StringUtils.linkedinLink,
                    submitSocialMediaResponse.response!.hLinkedinLink
                        .toString());
                prefs!.setString(
                    StringUtils.youtubeLink,
                    submitSocialMediaResponse.response!.hYoutubeLink
                        .toString());

                Future.delayed(Duration(seconds: 2), () {
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
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
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



  Future<GetHealerSocialMediaResponse?> getSocialMediaLinks() async {
    isLoading = true;
    GetHealerSocialMediaResponse? getHealerSocialMediaResponse;
    setState(() {});
    var data;
    print(
        'getSocialMediaLinks   ${prefs!.getString(StringUtils.id).toString()}');
    var request = http.MultipartRequest('POST', BaseuURL.healer_social_media);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();

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
              (data["msg"] == "success")) {
           getHealerSocialMediaResponse=
           GetHealerSocialMediaResponse.fromJson(
                jsonDecode(response.body));

            showSnackBar(context, data["msg"]);
           _fbController.text=getHealerSocialMediaResponse!.response![0].hFacebookLink.toString();
           _twitterController.text=getHealerSocialMediaResponse!.response![0].hTwitterLink.toString();
           _instagramController.text=getHealerSocialMediaResponse!.response![0].hInstagramLink.toString();
          _pinterestController.text=getHealerSocialMediaResponse!.response![0].hPinterestLink.toString();
           _linkedinController.text=getHealerSocialMediaResponse!.response![0].hLinkedinLink.toString();
            _youtubeController.text=getHealerSocialMediaResponse!.response![0].hYoutubeLink.toString();
            prefs!.setString(
                StringUtils.fbLink,
                getHealerSocialMediaResponse!.response![0].hFacebookLink.toString());
            prefs!.setString(
                StringUtils.twitterLink,
                getHealerSocialMediaResponse!.response![0].hTwitterLink.toString());
            prefs!.setString(
                StringUtils.instagramLink,
                getHealerSocialMediaResponse!.response![0].hInstagramLink.toString());
            prefs!.setString(
                StringUtils.pinterestLink,
                getHealerSocialMediaResponse!.response![0].hPinterestLink.toString());
            prefs!.setString(
                StringUtils.linkedinLink,
                getHealerSocialMediaResponse!.response![0].hLinkedinLink.toString());
            prefs!.setString(
                StringUtils.youtubeLink,
                getHealerSocialMediaResponse!.response![0].hYoutubeLink.toString());

            Future.delayed(Duration(seconds: 2), () {
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
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }
}
