import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/global/global.dart';
import 'package:doctor/models/all_therapy_response.dart';
import 'package:doctor/models/client_responses/top_reviewed_healer_response.dart';
import 'package:doctor/models/healer_responses/pricing_plan_response.dart';
import 'package:doctor/page/Client/Client_menu/pages/therapist_details_page.dart';
import 'package:doctor/page/Client/Client_menu/pages/therapistlist_page.dart';
import 'package:doctor/page/Client/Client_menu/pages/therapy_category.dart';
import 'package:doctor/page/Healer/Choose%20Your%20Expertise/HealerChooseExperties.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/size_util.dart';
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
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ClientHomePage extends StatefulWidget {
/*  String tabNumber;*/

/*
  ClientHomePage({
    Key? key,
    required this.tabNumber,
  }) : super(key: key);
*/

  @override
  State<ClientHomePage> createState() => ClientHomePageState();
}

class ClientHomePageState extends State<ClientHomePage> {
  int _value = 1;
  List<TherapyList> therapyList = [];
  List<TopFeaturedHealersResponse> topFeaturedHealerList = [];
  List<TopFeaturedHealersResponse> topReviewedHealerList = [];
  SharedPreferences? prefs;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

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
 /*   Future.delayed(Duration(seconds: 3), () {
      setState(() {
        ;
      });
      // Do something
    });*/
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
      return Scaffold(
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 200,
                    child: CarouselSlider(
                      items: [
                        //1st Image of Slider
                        Container(
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage("assets/images/handshake.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        //2nd Image of Slider
                        Container(
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image: AssetImage("assets/images/ic_medical.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        //3rd Image of Slider
                        Container(
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage("assets/images/hong.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        //4th Image of Slider
                        Container(
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage("assets/images/handshake.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        //5th Image of Slider
                        Container(
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage("assets/images/hong.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],

                      //Slider Container properties
                      options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    )),
            Align(
              alignment:
              Alignment.center,
              child:      Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Text('Therapies',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: StringUtils.roboto_font_family,
                          color: ColorUtils.blackColor.withOpacity(1),
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                        )))),
                Container(
                    height: 200,
                    child: FutureBuilder(
                        future: getTherapies(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  therapyList != null ? therapyList!.length : 0,
                              /*physics: NeverScrollableScrollPhysics(),*/
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TherapistListPage(
                                                  therapyId: therapyList[index]
                                                      .therapyId
                                                      .toString(),
                                                  therapyCategory:
                                                      therapyList[index]
                                                          .therapy_name
                                                          .toString(),
                                                )));
                                  },
                                  child: /* Card(
                                            elevation: 0,
                                            shadowColor:
                                                ColorUtils.lightGreyColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: */
                                      Container(
                                          height: 18.h,
                                          width: 125,
                                          margin: EdgeInsets.fromLTRB(
                                              1.w, 2.h, 1.w, 1.h),
                                          child: Column(children: [
                                            Container(
                                              height: 18.h,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5)),
                                                image: DecorationImage(
                                                  image: NetworkImage(therapyList
                                                              .length >
                                                          0
                                                      ? therapyList[index]
                                                          .therapy_image
                                                          .toString()
                                                      : "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Text(""),
                                            ),
                                            Expanded(
                                                child: Container(
                                              height: 7.h,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorUtils.trendyThemeColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                    therapyList.length > 0
                                                        ? therapyList[index]
                                                            .therapy_name
                                                            .toString()
                                                        : '',
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils
                                                          .roboto_font_family,
                                                      color: ColorUtils
                                                          .whiteColor
                                                          .withOpacity(1),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15,
                                                    )),
                                              ),
                                            ))
                                          ])),
                                );
                              });
                        })),
            Align(
              alignment:
              Alignment.center,
              child:   Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Text('Top Featured Healers',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: StringUtils.roboto_font_family,
                          color: ColorUtils.blackColor.withOpacity(1),
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                        )))),
              SizedBox(
                  height: 35.h,
                  child: FutureBuilder(
                      future: getTopFeaturedHealer(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasData) {
                            print('snapshot--  ${snapshot.error}');

                            if (topFeaturedHealerList!.length > 0) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:topFeaturedHealerList != null
                                      ? topFeaturedHealerList!.length
                                      : 0,
                                  /*physics: NeverScrollableScrollPhysics(),*/
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TherapyDetailsPage(
                                                      healerId:
                                                      topFeaturedHealerList[index]!
                                                          .healerId
                                                          .toString(),
                                                      therapyCategory: topFeaturedHealerList[index].therapyName.toString(),
                                                    )));
                                      },
                                      child: /* Card(
                                            elevation: 0,
                                            shadowColor:
                                                ColorUtils.lightGreyColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: */
                                      Container(
                                          height: 18.h,
                                          width: 125,
                                          margin: EdgeInsets.fromLTRB(
                                              1.w, 2.h, 1.w, 1.h),
                                          child: Column(children: [
                                            Container(
                                              height: 18.h,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft: Radius
                                                        .circular(5),
                                                    topRight: Radius
                                                        .circular(5)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      topFeaturedHealerList.length >
                                                          0
                                                          ? topFeaturedHealerList[
                                                      index]
                                                          .healerImage
                                                          .toString()
                                                          : "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Text(""),
                                            ),
                                            Container(
                                              height: 7.h,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                color: ColorUtils
                                                    .trendyThemeColor,
                                                borderRadius:
                                                BorderRadius.only(
                                                    bottomLeft: Radius
                                                        .circular(5),
                                                    bottomRight:
                                                    Radius
                                                        .circular(
                                                        5)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                    topFeaturedHealerList.length > 0
                                                        ? topFeaturedHealerList[
                                                    index]
                                                        .healerName
                                                        .toString()
                                                        : '',
                                                    maxLines: 3,
                                                    textAlign:
                                                    TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils
                                                          .roboto_font_family,
                                                      color: ColorUtils
                                                          .whiteColor
                                                          .withOpacity(1),
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      fontSize: 15,
                                                    )),
                                              ),
                                            )
                                          ])),
                                    );
                                  });
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
                                    /*     Image.asset(
                                                          'assets/images/no_data.png',
                                                          width: 200,
                                                          height: 200,
                                                        ),*/
                                  ));
                            }
                          } else {
                            return SizedBox(
                                height: 500,
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/images/no_data.json',
                                    repeat: true,
                                    height: 50.h,
                                    width: 45.w,
                                    reverse: false,
                                    animate: true,
                                  ),
                                  /*     Image.asset(
                                                          'assets/images/no_data.png',
                                                          width: 200,
                                                          height: 200,
                                                        ),*/
                                ));
                          }
                        } else {
                          return SpinKitFadingCircleWidget(true);
                        }
                      })),
                Align(
                    alignment:
                    Alignment.center,
                    child:   Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: Text('Top Reviewed Healers',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: StringUtils.roboto_font_family,
                          color: ColorUtils.blackColor.withOpacity(1),
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                        )))),
                SizedBox(
                    height: 35.h,
                    child: FutureBuilder(
                        future: getTopReviewedHealer(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              print('snapshot--  ${snapshot.error}');

                              if (topReviewedHealerList!.length > 0) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:topReviewedHealerList != null
                                        ? topReviewedHealerList!.length
                                        : 0,
                                    /*physics: NeverScrollableScrollPhysics(),*/
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TherapyDetailsPage(
                                                        healerId:
                                                        topReviewedHealerList[index]!
                                                            .healerId
                                                            .toString(),
                                                        therapyCategory: topReviewedHealerList[index].therapyName.toString(),
                                                      )));
                                        },
                                        child: /* Card(
                                            elevation: 0,
                                            shadowColor:
                                                ColorUtils.lightGreyColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: */
                                            Container(
                                                height: 18.h,
                                                width: 125,
                                                margin: EdgeInsets.fromLTRB(
                                                    1.w, 2.h, 1.w, 1.h),
                                                child: Column(children: [
                                                  Container(
                                                    height: 18.h,
                                                    width: 140,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(5)),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            topReviewedHealerList.length >
                                                                    0
                                                                ? topReviewedHealerList[
                                                                        index]
                                                                    .healerImage
                                                                    .toString()
                                                                : "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    child: Text(""),
                                                  ),
                                                  Container(
                                                    height: 7.h,
                                                    width: 140,
                                                    decoration: BoxDecoration(
                                                      color: ColorUtils
                                                          .trendyThemeColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                          topReviewedHealerList.length > 0
                                                              ? topReviewedHealerList[
                                                                      index]
                                                                  .healerName
                                                                  .toString()
                                                              : '',
                                                          maxLines: 3,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: StringUtils
                                                                .roboto_font_family,
                                                            color: ColorUtils
                                                                .whiteColor
                                                                .withOpacity(1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15,
                                                          )),
                                                    ),
                                                  )
                                                ])),
                                      );
                                    });
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
                                      /*     Image.asset(
                                                          'assets/images/no_data.png',
                                                          width: 200,
                                                          height: 200,
                                                        ),*/
                                    ));
                              }
                            } else {
                              return SizedBox(
                                  height: 500,
                                  child: Center(
                                    child: Lottie.asset(
                                      'assets/images/no_data.json',
                                      repeat: true,
                                      height: 50.h,
                                      width: 45.w,
                                      reverse: false,
                                      animate: true,
                                    ),
                                    /*     Image.asset(
                                                          'assets/images/no_data.png',
                                                          width: 200,
                                                          height: 200,
                                                        ),*/
                                  ));
                            }
                          } else {
                            return SpinKitFadingCircleWidget(true);
                          }
                        })),
                Align(
                    alignment:
                    Alignment.center,
                    child:       Padding(
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
                    child: SizedBox(
                        width: 280,
                        height: 46,
                        child: ElevatedButton(
                            child: TextWidget(
                                'Book Appointment',
                                FontWeight.normal,
                                ColorUtils.whiteColor,
                                19,
                                StringUtils.roboto_font_family),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(20),
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    ColorUtils.trendyButtonColor),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    ColorUtils.trendyButtonColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: ColorUtils.trendyButtonColor)))),
                            onPressed: () {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TherapyCategories(),));
                            }))))
              ],
            ),
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
                  Navigator.of(context).push(MaterialPageRoute(
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

  Future<List<TherapyList>?> getTherapies() async {
    var data;
    AllTherapyResponse? studentAllChapterResponse;
    var request = http.MultipartRequest('GET', BaseuURL.allTherapies);

    // var res = await request.send();
    // var res = await request.send();
    var response = await request.send();
    // var res = await request.send();
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
    return studentAllChapterResponse!.response;
/*    request
        .send()
        .then((result) async {
          http.Response.fromStream(result).then((response) {


            return response.body;
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});*/
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }

  Future<TopFeaturedHealers?> getTopFeaturedHealer() async {
    var data;
    TopFeaturedHealers? topFeaturedHealers;
    var request = http.MultipartRequest('GET', BaseuURL.top_featured_healer);

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

      if (data["status"] == "true" && data["msg"] == "success") {
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        topFeaturedHealers= new TopFeaturedHealers.fromJson(jsonResponse);
        topFeaturedHealerList = topFeaturedHealers!.response!;

        //   leadList.add(person.campaignData.indexOf(0));
        /*   });*/
        //  showAlertDialog(context, "Uploaded KYC successfully" );
      } else {
        topFeaturedHealerList!.clear();
      }
    }

    return topFeaturedHealers;

    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }


  Future<TopFeaturedHealers?> getTopReviewedHealer() async {
    var data;
    TopFeaturedHealers? topFeaturedHealers;
    var request = http.MultipartRequest('GET', BaseuURL.top_reviewed_healer);

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

      if (data["status"] == "true" && data["msg"] == "success") {
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        topFeaturedHealers= new TopFeaturedHealers.fromJson(jsonResponse);
        topReviewedHealerList = topFeaturedHealers!.response!;

        //   leadList.add(person.campaignData.indexOf(0));
        /*   });*/
        //  showAlertDialog(context, "Uploaded KYC successfully" );
      } else {
        topReviewedHealerList!.clear();
      }
    }

    return topFeaturedHealers;

    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }
}
