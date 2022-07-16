import 'dart:convert';

import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/global/global.dart';
import 'package:doctor/models/healer_responses/pricing_plan_response.dart';
import 'package:doctor/page/Healer/Choose%20Your%20Expertise/HealerChooseExperties.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:doctor/widget/text_widget.dart';
import 'package:doctor/widget/text_widget_align_center.dart';
import 'package:doctor/widget/text_widget_align_right.dart';
import 'package:doctor/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class PricingData extends StatefulWidget {
  String tabNumber;

  PricingData({
    Key? key,
    required this.tabNumber,
  }) : super(key: key);

  @override
  State<PricingData> createState() => PricingDataState();
}

class PricingDataState extends State<PricingData> {
  int _value = 1;
  SharedPreferences? prefs;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController _studentIDController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? dropdownvalue;
  var items = [
    'Male',
    'Female',
    'Other',
  ];

  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = true.obs;
  bool isChecked = false, isLoading = false;
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
  Widget _genderWidget(bool _showOther, bool _alignment) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: _showOther,
        verticalAlignedText: _alignment,
        onChanged: (Gender? _gender) {
          print(_gender);
          final messege = 'your selected Gender :- $_gender';
          Fluttertoast.showToast(msg: messege);
        },
        selectedGender: Gender.Male,
        //By Default
        selectedGenderTextStyle: const TextStyle(
            color: Color(0xFFC41A3B), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: const TextStyle(
            color: Color(0xFF1B1F32), fontWeight: FontWeight.bold),
        equallyAligned: true,
        size: 64.0,
        // default size 40.0
        animationDuration: const Duration(seconds: 1),
        isCircular: true,
        // by default true
        opacityOfGradient: 0.5,
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Padding(
              padding:
                  EdgeInsets.only(left: 0, right: 0, top: 2.h, bottom: 0.h),
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 0.h),
                      child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                              widget.tabNumber == '1'
                                  ? 'assets/svg/pricing_a.svg'
                                  : widget.tabNumber == '2'
                                      ? 'assets/svg/pricing_b.svg'
                                      : widget.tabNumber == '3'
                                          ? 'assets/svg/pricing_c.svg'
                                          : 'assets/svg/pricing_a.svg',
                              height: 20.h,
                              width: 50.w,
                              semanticsLabel: 'A red up arrow'))),
                  Padding(
                      padding: EdgeInsets.only(top: 4.h, left: 3.w, right: 3.w),
                      child: TextWidgetAlignCenter(
                          widget.tabNumber == '1'
                              ? 'No Fee'
                              : widget.tabNumber == '2'
                                  ? 'INR 500'
                                  : widget.tabNumber == '3'
                                      ? 'INR 900'
                                      : 'INR 1500',
                          FontWeight.bold,
                          Colors.redAccent,
                          23,
                          StringUtils.roboto_font_family)),
                  Padding(
                      padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //   String text, FontWeight fontWeight, Color textColor, double fontSize, String font_family
                              Container(
                                  width: 50.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: TextWidget(
                                      'Fee',
                                      FontWeight.normal,
                                      Colors.black,
                                      17,
                                      StringUtils.roboto_font_family)),
                              Container(
                                  width: 50.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: TextWidget(
                                      'Free Workshops',
                                      FontWeight.normal,
                                      Colors.black,
                                      17,
                                      StringUtils.roboto_font_family)),
                              Container(
                                  width: 50.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: TextWidget(
                                      'Priority Listing',
                                      FontWeight.normal,
                                      Colors.black,
                                      17,
                                      StringUtils.roboto_font_family)),
                              Container(
                                  width: 50.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: TextWidget(
                                      'Advertising',
                                      FontWeight.normal,
                                      Colors.black,
                                      17,
                                      StringUtils.roboto_font_family)),
                              Container(
                                  width: 50.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: TextWidget(
                                      'Facilitation Charges',
                                      FontWeight.normal,
                                      Colors.black,
                                      17,
                                      StringUtils.roboto_font_family)),
                              Container(
                                  width: 50.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: TextWidget(
                                      'Multiple Expertise',
                                      FontWeight.normal,
                                      Colors.black,
                                      17,
                                      StringUtils.roboto_font_family)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 30.w,
                                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                child: widget.tabNumber == '1'
                                    ? TextWidgetAlignRight(
                                        'No Fee',
                                        FontWeight.normal,
                                        Colors.black,
                                        17,
                                        StringUtils.roboto_font_family)
                                    : widget.tabNumber == '2'
                                        ? new RichText(
                                            textAlign: TextAlign.right,
                                            text: new TextSpan(
                                              children: <TextSpan>[
                                                new TextSpan(
                                                  text: 'INR 500  ',
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                new TextSpan(
                                                  text: '1200',
                                                  style: new TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : widget.tabNumber == '3'
                                            ? new RichText(
                                                textAlign: TextAlign.right,
                                                text: new TextSpan(
                                                  children: <TextSpan>[
                                                    new TextSpan(
                                                      text: 'INR 900  ',
                                                      style: new TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    new TextSpan(
                                                      text: '2500',
                                                      style: new TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : new RichText(
                                                textAlign: TextAlign.right,
                                                text: new TextSpan(
                                                  children: <TextSpan>[
                                                    new TextSpan(
                                                      text: 'INR 1500  ',
                                                      style: new TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    new TextSpan(
                                                      text: '4500',
                                                      style: new TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                              ),
                              Container(
                                  width: 30.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: widget.tabNumber == '1'
                                      ? TextWidgetAlignRight(
                                          'No',
                                          FontWeight.normal,
                                          Colors.black,
                                          17,
                                          StringUtils.roboto_font_family)
                                      : widget.tabNumber == '2'
                                          ? TextWidgetAlignRight(
                                              '1',
                                              FontWeight.normal,
                                              Colors.black,
                                              17,
                                              StringUtils.roboto_font_family)
                                          : widget.tabNumber == '3'
                                              ? TextWidgetAlignRight(
                                                  '3',
                                                  FontWeight.normal,
                                                  Colors.black,
                                                  17,
                                                  StringUtils
                                                      .roboto_font_family)
                                              : TextWidgetAlignRight(
                                                  '5',
                                                  FontWeight.normal,
                                                  Colors.black,
                                                  17,
                                                  StringUtils
                                                      .roboto_font_family)),
                              Container(
                                  width: 30.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: widget.tabNumber == '1'
                                      ? TextWidgetAlignRight(
                                          'No',
                                          FontWeight.normal,
                                          Colors.black,
                                          15,
                                          StringUtils.roboto_font_family)
                                      : widget.tabNumber == '2'
                                          ? TextWidgetAlignRight(
                                              'No',
                                              FontWeight.normal,
                                              Colors.black,
                                              17,
                                              StringUtils.roboto_font_family)
                                          : widget.tabNumber == '3'
                                              ? TextWidgetAlignRight(
                                                  '2 Weeks/Month',
                                                  FontWeight.normal,
                                                  Colors.black,
                                                  17,
                                                  StringUtils
                                                      .roboto_font_family)
                                              : TextWidgetAlignRight(
                                                  '3 Weeks/Month',
                                                  FontWeight.normal,
                                                  Colors.black,
                                                  17,
                                                  StringUtils
                                                      .roboto_font_family)),
                              Container(
                                  width: 30.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: widget.tabNumber == '1'
                                      ? TextWidgetAlignRight(
                                          'No',
                                          FontWeight.normal,
                                          Colors.black,
                                          17,
                                          StringUtils.roboto_font_family)
                                      : widget.tabNumber == '2'
                                          ? TextWidgetAlignRight(
                                              'Low',
                                              FontWeight.normal,
                                              Colors.black,
                                              17,
                                              StringUtils.roboto_font_family)
                                          : widget.tabNumber == '3'
                                              ? TextWidgetAlignRight(
                                                  'Medium',
                                                  FontWeight.normal,
                                                  Colors.black,
                                                  17,
                                                  StringUtils
                                                      .roboto_font_family)
                                              : TextWidgetAlignRight(
                                                  'High',
                                                  FontWeight.normal,
                                                  Colors.black,
                                                  17,
                                                  StringUtils
                                                      .roboto_font_family)),
                              Container(
                                width: 30.w,
                                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                child: widget.tabNumber == '1'
                                    ? new RichText(
                                        textAlign: TextAlign.right,
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(
                                              text: '10%  ',
                                              style: new TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            new TextSpan(
                                              text: '15%',
                                              style: new TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : widget.tabNumber == '2'
                                        ? new RichText(
                                            textAlign: TextAlign.right,
                                            text: new TextSpan(
                                              children: <TextSpan>[
                                                new TextSpan(
                                                  text: '10%  ',
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                new TextSpan(
                                                  text: '15%',
                                                  style: new TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : widget.tabNumber == '3'
                                            ? new RichText(
                                                textAlign: TextAlign.right,
                                                text: new TextSpan(
                                                  children: <TextSpan>[
                                                    new TextSpan(
                                                      text: '7%  ',
                                                      style: new TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    new TextSpan(
                                                      text: '15%',
                                                      style: new TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : new RichText(
                                                textAlign: TextAlign.right,
                                                text: new TextSpan(
                                                  children: <TextSpan>[
                                                    new TextSpan(
                                                      text: '5%  ',
                                                      style: new TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    new TextSpan(
                                                      text: '15%',
                                                      style: new TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                              ),
                              Container(
                                  width: 30.w,
                                  margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                                  child: widget.tabNumber == '1'
                                      ? TextWidgetAlignRight(
                                          '1',
                                          FontWeight.normal,
                                          Colors.black,
                                          17,
                                          StringUtils.roboto_font_family)
                                      : widget.tabNumber == '2'
                                          ? TextWidgetAlignRight(
                                              '5',
                                              FontWeight.normal,
                                              Colors.black,
                                              17,
                                              StringUtils.roboto_font_family)
                                          : widget.tabNumber == '3'
                                              ? TextWidgetAlignRight(
                                                  '7',
                                                  FontWeight.normal,
                                                  Colors.black,
                                                  17,
                                                  StringUtils
                                                      .roboto_font_family)
                                              : TextWidgetAlignRight(
                                                  'Unlimited',
                                                  FontWeight.normal,
                                                  Colors.black,
                                                  17,
                                                  StringUtils
                                                      .roboto_font_family)),
                            ],
                          ),
                        ],
                      ))
                ]),
              ) //row

              ),
          SpinKitFadingCircleWidget(isLoading),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 2.h, 10, 10.h),
                  child: SizedBox(
                      width: 280,
                      height: 46,
                      child: ElevatedButton(
                          child: TextWidget(
                              'Get Started'.toUpperCase(),
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
                          onPressed: () async {
                            isLoading = true;
                            setState(() {});
                            await updatePricingPlan();
                            isLoading = false;
                            setState(() {});
                          }))))
        ]),
      ));
    });
  }

  Future<String?> updatePricingPlan() async {
    var data;

    var request = http.MultipartRequest('POST', BaseuURL.updatePricing);
    //   request.headers.addAll(headers);
    request.fields['type'] = '1';
    request.fields['unique_id'] =
        prefs!.getString(StringUtils.unique_id).toString();

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
                  data["msg"] == "Submitted successfully") {
                print('Submitted successfully---    ');
                PricingPlanResponse pricingPlanResponse =
                    PricingPlanResponse.fromJson(jsonDecode(response.body));
                print(pricingPlanResponse.response!.hPosition.toString());

                showAlertDialog(context, data["msg"]);
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HealerChooseExperties()));
                });
              } else {
                showAlertDialog(context, data["msg"]);
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
}
