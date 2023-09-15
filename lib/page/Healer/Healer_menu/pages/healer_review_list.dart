import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:trendy_chikitsa/baseurl/baseURL.dart';

import 'package:trendy_chikitsa/models/client_responses/client_appointment_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_review_list_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/submit_review_response.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HealerReviewList extends StatefulWidget {
  String from_page = "", token = "";

  HealerReviewList({super.key});

  @override
  HealerReviewListState createState() => HealerReviewListState();

/* TodayAppointment({
    Key? key,
    required this.from_page
  }) : super(key: key);*/
}

class HealerReviewListState extends State<HealerReviewList>
    with WidgetsBindingObserver {
  static String routeName = '/homePage', appointmentId = "", customer_name = "";
  bool isHovering = false, isLoading = false, isShow = false, isData = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMeetingActive = false;
  final nameController = TextEditingController();
  String appToken = "";
  List<AppointmentResponse?> appointmentList = [];
  final int _selectedIndex = 0;
  bool isBottomNaviVisible = false;
  SharedPreferences? prefs;
  String? selectedSubjectItem,
      selectedChapterItem,
      subjectId = "",
      chapterId = "",
      title = "Live Classes";
  String? meetingId = '';
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});

// Do something
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

/*  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
      storage.write(key: StringUtils.current_page, value: "HOME");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorUtils.lightGreyColor,
          /*drawer: Home_Menu(),*/
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            toolbarHeight: 60,
            backgroundColor: ColorUtils.trendyThemeColor,
            elevation: 0.0,
            automaticallyImplyLeading: true,
            title: Row(
              children: [
                Text('Reviews',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.whiteColor,
                      fontSize: 18,
                    )),
              ],
            ),
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.light,
/*            leading: GestureDetector(
                onTap: () {
                  print('----???   coming inside on pressed');
                  try {
                    _scaffoldKey.currentState!.openDrawer();
                  } catch (ex) {
                    print('rrr----    ${ex}');
                  }
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: new IconButton(
                        icon: new Icon(
                          Icons.menu,
                          color: ColorUtils.whiteColor,
                          size: 21,
                        ),
                        onPressed: () {
                          print('----???   coming inside on pressed');
                          try {
                            _scaffoldKey.currentState!.openDrawer();
                          } catch (ex) {
                            print('rrr----    ${ex}');
                          }
                        }))),*/
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
          body: FutureBuilder<HealerReviewListResponse?>(
            future: getHealerReviews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print('snapshot--  ${snapshot.error}');
                if (_healerReviewListResponse != null &&
                    _healerReviewListResponse!.response!.isNotEmpty) {
                  print('snapshot--  ${snapshot.error}');
                  //   print('value is..  ${new Map<String, dynamic>.from(snapshot.data).}');

                  return ListView.builder(
                      itemCount: _healerReviewListResponse!.response!.length,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            elevation: 2,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 2.w,
                                    right: 2.w,
                                    top: 2.h,
                                    bottom: 1.h),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 1.w,
                                              right: 1.w,
                                              top: 1.h,
                                              bottom: 0.h),
                                          child: SizedBox(
                                              width: 50.w,
                                              child: Text(
                                                _healerReviewListResponse !=
                                                        null
                                                    ? _healerReviewListResponse!
                                                        .response![index]
                                                        .clientName
                                                        .toString()
                                                        .toUpperCase()
                                                    : '---',
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family_bold,
                                                  color: ColorUtils.blackColor,
                                                  letterSpacing: 0.15,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 16,
                                                ),
                                              ))),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 1.w,
                                              right: 1.w,
                                              top: 1.h,
                                              bottom: 0.h),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children:
                                                List.generate(5, (index1) {
                                              return Icon(
                                                index1 <
                                                        int.parse(
                                                            _healerReviewListResponse!
                                                                .response![
                                                                    index]
                                                                .rate
                                                                .toString())
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: index1 < 4
                                                    ? Colors.amber
                                                    : Colors.grey,
                                                size: 20,
                                              );
                                            }),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 1.w,
                                              right: 1.w,
                                              top: 1.h,
                                              bottom: 1.h),
                                          child: SizedBox(
                                              width: 80.w,
                                              child: Text(
                                                _healerReviewListResponse !=
                                                        null
                                                    ? _healerReviewListResponse!
                                                        .response![index].review
                                                        .toString()
                                                    : '---',
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family_regular,
                                                  color: ColorUtils.blackColor,
                                                  letterSpacing: 0,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 17,
                                                ),
                                              )))
                                    ])));
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
                        'assets/images/loading_data.json',
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
            },
          ));
    });
  }

  HealerReviewListResponse? _healerReviewListResponse;

  Future<HealerReviewListResponse?> getHealerReviews() async {
    var data;
    var request = http.MultipartRequest('POST', BaseuURL.healer_reviews);

    request.fields['healer_id'] =
        prefs!.getString(StringUtils.id).toString() /*'52'*/;

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

        _healerReviewListResponse =
            HealerReviewListResponse.fromJson(jsonResponse);
        //  appointmentList = clientAppointmentResponse!.response!;
      } else {
        // appointmentList!.clear();
      }
    }

    return _healerReviewListResponse;

    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }

  showD(String appointment) {
    String appointmentRating;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: const Text("Rate your appointment"),
                content: SizedBox(
                  height: 40.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 70.w,
                          child: RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 5,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              appointmentRating = rating.toString();
                            },
                          )),
                      Container(
                          width: 80.w,
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          margin:
                              EdgeInsets.only(top: 2.h, left: 0.w, right: 1.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ColorUtils.lightGreyBorderColor),
                            color: ColorUtils.whiteColor,
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: ColorUtils.b3Color,
                                    fontFamily:
                                        StringUtils.roboto_font_family_regular,
                                    fontSize: 17),
                                labelStyle: TextStyle(
                                    color: ColorUtils.textFormFieldLabelColor,
                                    fontFamily: StringUtils.roboto_font_family,
                                    fontSize: 17),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: '  Share your experience here'),
                            onChanged: (text) {
                              setState(() {
                                //you can access nameController in its scope to get
                                // the value of text entered as shown below
                                //UserName = nameController.text;
                              });
                            },
                            onTap: () {},
                          )),
                      SizedBox(
                          height: 8.h,
                          child: InkWell(
                              child: SizedBox(
                                height: 8.h,
                                child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(8.w, 2.5.h, 8.w, 0),
                                    child: SizedBox(
                                        width: 100.h,
                                        height: 7.h,
                                        child: ElevatedButton(
                                            child: Text('Submit'.toUpperCase(),
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family_bold,
                                                  fontSize: 15,
                                                  color: ColorUtils.whiteColor,
                                                  letterSpacing: 0.75,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2,
                                                )),
                                            style: ButtonStyle(
                                                elevation: MaterialStateProperty.all(
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
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        side: BorderSide(color: ColorUtils.violetButtonColor)))),
                                            onPressed: () {
                                              submitReview(
                                                  appointmentId,
                                                  appointment,
                                                  _textEditingController.text
                                                      .toString());
                                            }))),
                              ),
                              onTap: () async {
                                submitReview(appointmentId, appointment,
                                    _textEditingController.text.toString());
                              }))
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  SubmitReviewResponse? _submitReviewResponse;

  Future<String?> submitReview(
      String appointmentId, String rating, String comments) async {
    isLoading = true;
    setState(() {});
    var data;
    print('updateScheduleTime   $appointmentId,   $rating,   $comments');
    var request = http.MultipartRequest('POST', BaseuURL.submit_review);

    request.fields['appointment_id'] = appointmentId;
    request.fields['rating'] = rating;

    request.fields['comment'] = comments;

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
                  (data["msg"] ==
                      "Success! Your review has been submitted successfully.")) {
                _submitReviewResponse =
                    SubmitReviewResponse.fromJson(jsonDecode(response.body));

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
