import 'dart:convert';

import 'package:trendy_chikitsa/api.dart';
import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/MaskasCompleteResponse.dart';

import 'package:trendy_chikitsa/models/healer_responses/approve_meeting_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_appointment_response.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/video_sdk_utils/screens/meeting_screen.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class TodayAppointment extends StatefulWidget {
  String from_page = "", token = "", tab_value = '';

  @override
  TodayAppointmentState createState() => TodayAppointmentState();

  TodayAppointment({Key? key, required this.tab_value}) : super(key: key);
}

class TodayAppointmentState extends State<TodayAppointment>
    with WidgetsBindingObserver {
  static String routeName = '/homePage', appointmentId = "", customer_name = "";
  bool isHovering = false, isLoading = false, isShow = false, isData = true;
  bool isMeetingActive = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final nameController = TextEditingController();
  String appToken = "";
  List<HealerAppointmentListResponse?> appointmentList = [];
  final int _selectedIndex = 0;
  bool isBottomNaviVisible = false;
  SharedPreferences? prefs;
  String? selectedSubjectItem,
      selectedChapterItem,
      subjectId = "",
      chapterId = "",
      title = "Live Classes";
  TextEditingController timeController = TextEditingController();

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
          body: Stack(children: [
            FutureBuilder<HealerAppointmentResponse?>(
              future: getClientAppointments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print('snapshot--  ${snapshot.error}');
                  if (appointmentList.isNotEmpty) {
                    print('snapshot--  ${snapshot.error}');
                    //   print('value is..  ${new Map<String, dynamic>.from(snapshot.data).}');

                    return ListView.builder(
                        itemCount: appointmentList.length,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              elevation: 2,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 2.h,
                                      bottom: 1.h),
                                  child: Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                healerAppointmentResponse !=
                                                        null
                                                    ? healerAppointmentResponse!
                                                        .response![index]
                                                        .clProfile
                                                        .toString()
                                                    : "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          Container(
                                              width: 25.w,
                                              height: 10.h,
                                              margin: EdgeInsets.only(top: 2.h),
                                              child: Text(
                                                healerAppointmentResponse !=
                                                        null
                                                    ? healerAppointmentResponse!
                                                        .response![index].status
                                                        .toString()
                                                    : '---',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils
                                                      .appDarkBlueColor,
                                                  letterSpacing: 0.15,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 17,
                                                ),
                                              ))
                                        ]),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Flexible(
                                            child: Column(
                                          children: [
                                            SizedBox(
                                                width: 60.w,
                                                child: Text(
                                                  healerAppointmentResponse !=
                                                          null
                                                      ? healerAppointmentResponse!
                                                          .response![index]
                                                          .clientName
                                                          .toString()
                                                      : '---',
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family_bold,
                                                    color: ColorUtils
                                                        .appDarkBlueColor,
                                                    letterSpacing: 0.15,
                                                    /*  fontWeight: FontWeight.bold,*/
                                                    fontSize: 18,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.radio_button_checked,
                                                  color: ColorUtils.greyColor,
                                                  size: 18,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2.w),
                                                    child: SizedBox(
                                                        width: 50.w,
                                                        child: Text(
                                                          healerAppointmentResponse !=
                                                                  null
                                                              ? healerAppointmentResponse!
                                                                  .response![
                                                                      index]
                                                                  .therapyName
                                                                  .toString()
                                                              : '---',
                                                          style: TextStyle(
                                                            fontFamily: StringUtils
                                                                .roboto_font_family,
                                                            color: ColorUtils
                                                                .blackColor,
                                                            letterSpacing: 0.15,
                                                            /*  fontWeight: FontWeight.bold,*/
                                                            fontSize: 16,
                                                          ),
                                                        ))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time_outlined,
                                                  color: ColorUtils.greyColor,
                                                  size: 18,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.w),
                                                  child: Text(
                                                      healerAppointmentResponse!
                                                          .response![index].date
                                                          .toString()),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.w),
                                                      child: SizedBox(
                                                          width: 50.w,
                                                          child: Text(
                                                            healerAppointmentResponse !=
                                                                    null
                                                                ? '${healerAppointmentResponse!.response![index].status.toString()}(${healerAppointmentResponse!.response![index].slot})'
                                                                : '---',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              color: ColorUtils
                                                                  .blackColor,
                                                              // letterSpacing:
                                                              //     0.15,
                                                              // /*  fontWeight: FontWeight.bold,*/
                                                              // fontSize: 16,
                                                            ),
                                                          ))),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: ColorUtils.greyColor,
                                                  size: 18,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2.w),
                                                    child: SizedBox(
                                                      width: 50.w,
                                                      child: Text(
                                                          healerAppointmentResponse !=
                                                                  null
                                                              ? healerAppointmentResponse!
                                                                  .response![
                                                                      index]
                                                                  .address
                                                                  .toString()
                                                              : '---',
                                                          style: TextStyle(
                                                            fontFamily: StringUtils
                                                                .roboto_font_family,
                                                            color: ColorUtils
                                                                .blackColor,
                                                            letterSpacing: 0.15,
                                                            /*  fontWeight: FontWeight.bold,*/
                                                            fontSize: 16,
                                                          )),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.email_outlined,
                                                  color: ColorUtils.greyColor,
                                                  size: 18,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2.w),
                                                    child: SizedBox(
                                                        width: 50.w,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            String email =
                                                                healerAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .clientEmail
                                                                    .toString();
                                                            String subject =
                                                                ' ';
                                                            String body = ' ';

                                                            String emailUrl =
                                                                "mailto:$email?subject=$subject&body=$body";

                                                            if (await canLaunch(
                                                                emailUrl)) {
                                                              await launch(
                                                                  emailUrl);
                                                            } else {
                                                              throw "Error occured sending an email";
                                                            }
                                                          },
                                                          child: Text(
                                                            healerAppointmentResponse !=
                                                                    null
                                                                ? healerAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .clientEmail
                                                                    .toString()
                                                                : '---',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              color: ColorUtils
                                                                  .blackColor,
                                                              letterSpacing:
                                                                  0.15,
                                                              /*  fontWeight: FontWeight.bold,*/
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.call,
                                                  color: ColorUtils.greyColor,
                                                  size: 18,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2.w),
                                                    child: SizedBox(
                                                        width: 50.w,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            String mobnum =
                                                                healerAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .clientMobile
                                                                    .toString();
                                                            String url =
                                                                "tel:$mobnum ";

                                                            // 'https://www.twitter.com';

                                                            // 'tel:' + number;
                                                            if (await canLaunch(
                                                                url)) {
                                                              await launch(url);
                                                            } else {
                                                              throw 'Application unable to open dialer.';
                                                            }
                                                          },
                                                          child: Text(
                                                            healerAppointmentResponse !=
                                                                    null
                                                                ? healerAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .clientMobile
                                                                    .toString()
                                                                : '---',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              color: ColorUtils
                                                                  .blackColor,
                                                              letterSpacing:
                                                                  0.15,
                                                              /*  fontWeight: FontWeight.bold,*/
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ))),
                                              ],
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Visibility(
                                            visible: healerAppointmentResponse !=
                                                    null
                                                ? healerAppointmentResponse!
                                                        .response![index].status
                                                        .toString() ==
                                                    'Pending' /*'Paid'*/ /*'Confirmed'*/
                                                : false,
                                            child: InkWell(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.w, 1.h, 0.w, 0.h),
                                                  child: SizedBox(
                                                      width: 20.h,
                                                      height: 5.h,
                                                      child: ElevatedButton(
                                                          child: Text(
                                                              'Accept'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    StringUtils
                                                                        .roboto_font_family,
                                                                fontSize: 16,
                                                                color: ColorUtils
                                                                    .whiteColor,
                                                                letterSpacing:
                                                                    0.75,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 1.2,
                                                              )),
                                                          style: ButtonStyle(
                                                              elevation:
                                                                  MaterialStateProperty
                                                                      .all(0),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<Color>(
                                                                      ColorUtils
                                                                          .greenColor),
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<Color>(
                                                                      ColorUtils
                                                                          .greenColor),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                  side: BorderSide(color: ColorUtils.greenColor)))),
                                                          onPressed: () {
                                                            showD(
                                                                healerAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .book_id
                                                                    .toString(),
                                                                index);
                                                          })),
                                                ),
                                                onTap: () async {
                                                  showD(
                                                      healerAppointmentResponse!
                                                          .response![index]
                                                          .book_id
                                                          .toString(),
                                                      index);
                                                })),
                                        Visibility(
                                            visible: healerAppointmentResponse !=
                                                    null
                                                ? healerAppointmentResponse!
                                                    .response![index].status
                                                    .toString() == /*'Confirmed'*/ 'Pending'
                                                : false,
                                            child: InkWell(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.w, 1.h, 0.w, 0.h),
                                                  child: SizedBox(
                                                      width: 20.h,
                                                      height: 5.h,
                                                      child: ElevatedButton(
                                                          child: Text(
                                                              'Reject'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    StringUtils
                                                                        .roboto_font_family,
                                                                fontSize: 16,
                                                                color: ColorUtils
                                                                    .whiteColor,
                                                                letterSpacing:
                                                                    0.75,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 1.2,
                                                              )),
                                                          style: ButtonStyle(
                                                              elevation:
                                                                  MaterialStateProperty.all(
                                                                      0),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<Color>(
                                                                      ColorUtils
                                                                          .gradientRedColor),
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<Color>(
                                                                      ColorUtils
                                                                          .gradientRedColor),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8.0),
                                                                      side: BorderSide(color: ColorUtils.gradientRedColor)))),
                                                          onPressed: () {
                                                            isLoading = true;
                                                            setState(() {});

                                                            rejectAppointment(
                                                                healerAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .book_id
                                                                    .toString());
                                                          })),
                                                ),
                                                onTap: () async {
                                                  isLoading = true;
                                                  setState(() {});
                                                  rejectAppointment(
                                                      healerAppointmentResponse!
                                                          .response![index]
                                                          .book_id
                                                          .toString());
                                                })),
                                        Visibility(
                                            visible:
                                                healerAppointmentResponse !=
                                                        null
                                                    ? healerAppointmentResponse!
                                                            .response![index]
                                                            .status
                                                            .toString() ==
                                                        'Paid'
                                                    : true,
                                            child: InkWell(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.w, 1.h, 0.w, 0.h),
                                                  child: SizedBox(
                                                      width: 23.h,
                                                      height: 5.h,
                                                      child: ElevatedButton(
                                                          child: Text(
                                                              'Join Call'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    StringUtils
                                                                        .roboto_font_family,
                                                                fontSize: 15,
                                                                color: ColorUtils
                                                                    .whiteColor,
                                                                letterSpacing:
                                                                    0.75,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 1.2,
                                                              )),
                                                          style: ButtonStyle(
                                                              elevation:
                                                                  MaterialStateProperty.all(
                                                                      0),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<Color>(
                                                                      ColorUtils
                                                                          .trendyButtonColor),
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<Color>(
                                                                      ColorUtils
                                                                          .trendyButtonColor),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8.0),
                                                                      side: BorderSide(color: ColorUtils.trendyButtonColor)))),
                                                          onPressed: () {
                                                            isLoading = true;
                                                            setState(() {});
                                                            print(
                                                                'meeting id in healer--   ${healerAppointmentResponse!.response![index].meeting_id.toString()}');
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute<
                                                                  dynamic>(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    MeetingScreen(
                                                                  meetingId: healerAppointmentResponse!
                                                                      .response![
                                                                          index]
                                                                      .meeting_id
                                                                      .toString(),
                                                                  token: token,
                                                                  displayName:
                                                                      'User',
                                                                  camEnabled:
                                                                      true,
                                                                  chatEnabled:
                                                                      false,
                                                                  /* leaveMeeting:
                                                                    () {
                                                                  setState(() =>
                                                                      isMeetingActive =
                                                                          false);
                                                                },*/
                                                                ),
                                                              ),
                                                            );
                                                            /*    Navigator.push(
                                                            context,
                                                            MaterialPageRoute<dynamic>(
                                                              builder: (BuildContext
                                                              context) =>
                                                                  MeetingScreen(
                                                                    meetingId:healerAppointmentResponse!
                                                                        .response![
                                                                    index].meeting_id
                                                                        .toString(),
                                                                    token: token,
                                                                    leaveMeeting: () {
                                                                      setState(() =>
                                                                      isMeetingActive =
                                                                      false);
                                                                    },
                                                                  ),
                                                            ),
                                                          );*/
                                                          })),
                                                ),
                                                onTap: () async {
                                                  isLoading = true;
                                                  setState(() {});
                                                  print(
                                                      'meeting id in healer--   ${healerAppointmentResponse!.response![index].meeting_id.toString()}');
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute<dynamic>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          MeetingScreen(
                                                        meetingId:
                                                            healerAppointmentResponse!
                                                                .response![
                                                                    index]
                                                                .meeting_id
                                                                .toString(),
                                                        token: token,
                                                        displayName: 'User',
                                                        camEnabled: true,
                                                        chatEnabled: false,
                                                        /* leaveMeeting:
                                                                    () {
                                                                  setState(() =>
                                                                      isMeetingActive =
                                                                          false);
                                                                },*/
                                                      ),
                                                    ),
                                                  );

                                                  /*  Navigator.push(
                                                  context,
                                                  MaterialPageRoute<dynamic>(
                                                    builder: (BuildContext
                                                    context) =>
                                                        MeetingScreen(
                                                          meetingId: healerAppointmentResponse!
                                                              .response![
                                                          index].meeting_id
                                                              .toString(),
                                                          token: token,
                                                          leaveMeeting: () {
                                                            setState(() =>
                                                            isMeetingActive =
                                                            false);
                                                          },
                                                        ),
                                                  ),
                                                );*/
                                                })),
                                        Expanded(
                                          child: 
                                          SizedBox(
                                            width: 23.h,
                                            height: 5.h,
                                            child: ElevatedButton(
                                                child: Text(
                                                    'Mark as complete'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontFamily: StringUtils
                                                          .roboto_font_family,
                                                      fontSize: 15,
                                                      color:
                                                          ColorUtils.whiteColor,
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
                                                                .trendyButtonColor),
                                                    backgroundColor:
                                                        MaterialStateProperty.all<Color>(
                                                            ColorUtils
                                                                .trendyButtonColor),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            side: BorderSide(color: ColorUtils.trendyButtonColor)))),
                                                onPressed: () async {
                                                  print("object");
                                                  await mark_asReadResponse();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(mydata
                                                              .response
                                                              .toString())));
                                                }),
                                          ),
                                        )
                                      ],
                                    )
                                  ])));
                        });
                  } else {
                    return SizedBox(
                        height: 500,
                        child: Center(
                          child: Lottie.asset(
                            'assets/images/no_data.json',
                            repeat: true,
                            height: 50.h,
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
                          height: 50.h,
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
            ),
            SpinKitFadingCircleWidget(isLoading)
          ]));
    });
  }

  var mydata;
  Future mark_asReadResponse() async {
    var map = <String, dynamic>{};
    map['appointment_id'] = '1';
    var respopnse = await http.post(
        Uri.parse("https://trendychikitsa.com/api/mark_as_complete"),
        body: map);
    if (respopnse.statusCode == 200) {
      setState(() {
        mydata = MarkasCompleteModel.fromJson(jsonDecode(respopnse.body));
      });
      print("sunny");
      print(jsonEncode(mydata));
    }
  }

  HealerAppointmentResponse? healerAppointmentResponse;

  Future<HealerAppointmentResponse?> getClientAppointments() async {
    var data;
    var request = http.MultipartRequest('POST', BaseuURL.healer_appointment);

    request.fields['healer_id'] =
        prefs!.getString(StringUtils.id).toString() /*'52'*/;
    request.fields['tab_value'] = widget.tab_value;

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
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        healerAppointmentResponse =
            HealerAppointmentResponse.fromJson(jsonResponse);
        appointmentList = healerAppointmentResponse!.response!;
      } else {
        appointmentList.clear();
      }
    }

    return healerAppointmentResponse;

    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }

  ApproveMeetingResponse? _approveMeetingResponse;

  Future<ApproveMeetingResponse?> approveAppointment(
      String appointmentId, String appointmentTime) async {
    var data;
    try {
      var request = http.MultipartRequest('POST', BaseuURL.approve_booking);

      request.fields['appointment_id'] = appointmentId;
      request.fields['appointment_time'] = appointmentTime;
      var response = await request.send();
      final responsed = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        print('response.body ' + responsed.body);
        var jsonData = responsed.body;

        print(jsonData);
        data = json.decode(responsed.body);

        if (data["status"] == "true" && data["msg"] == "success") {
          print('createMeetingForAppointment--    ');

          final jsonResponse = json.decode(responsed.body);

          _approveMeetingResponse =
              ApproveMeetingResponse.fromJson(jsonResponse);
          showAlertDialog(context, data["response"]);
        } else {
          showAlertDialog(context, data["response"]);
        }

        Future.delayed(const Duration(seconds: 1), () {
          timeController.text = '';
          setState(() {
            isLoading = false;
          });
          // Do something
        });
      }

      setState(() {});
    } catch (e) {
      print('exce --   ${e.toString()}    ');
    }
    return _approveMeetingResponse;
  }

  ApproveMeetingResponse? _rejectMeetingResponse;

  Future<ApproveMeetingResponse?> rejectAppointment(
      String appointmentId) async {
    var data;
    try {
      var request = http.MultipartRequest('POST', BaseuURL.reject_booking);

      request.fields['appointment_id'] = appointmentId;

      var response = await request.send();
      final responsed = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        print('response.body ' + responsed.body);
        var jsonData = responsed.body;

        print(jsonData);
        data = json.decode(responsed.body);

        if (data["status"] == "true" && data["msg"] == "success") {
          print('createMeetingForAppointment--    ');

          final jsonResponse = json.decode(responsed.body);

          _approveMeetingResponse =
              ApproveMeetingResponse.fromJson(jsonResponse);
          showAlertDialog(context, data["response"]);
        } else {
          showAlertDialog(context, data["response"]);
        }

        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
          });
          // Do something
        });
      }

      setState(() {});
    } catch (e) {
      print('exce --   ${e.toString()}    ');
    }
    return _approveMeetingResponse;
  }

  TimeOfDay currentTime = TimeOfDay.now();
  bool _isTimeSelected = false;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: currentTime,
        initialEntryMode: TimePickerEntryMode.dial,
        helpText: 'Choose Your Time',
        confirmText: 'Choose Now',
        cancelText: 'Later');
    if (pickedTime != null && pickedTime != currentTime) {
      setState(() {
        currentTime = pickedTime;
        timeController.text = '${pickedTime.hour}:${pickedTime.minute}';
        setState(() {});
        _isTimeSelected = true;
      });
    }
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

  showD(String appointmentID, int index) {
    showDialog(
      context: context,
      builder: (context) {
        int value = 2;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Time"),
              content: SizedBox(
                  height: 40.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "Please select time in between ${healerAppointmentResponse!.response![index].slot}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorUtils.grayColor,
                              fontSize: 17)),
                      Container(
                        height: 7.h,
                        width: 60.w,
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
                          controller: timeController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: ColorUtils.b3Color,
                                  fontFamily:
                                      StringUtils.roboto_font_family_regular,
                                  fontSize: 15),
                              labelStyle: TextStyle(
                                  color: ColorUtils.textFormFieldLabelColor,
                                  fontFamily: StringUtils.roboto_font_family,
                                  fontSize: 15),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: '  Start Time'),
                          onChanged: (text) {
                            setState(() {
                              //you can access nameController in its scope to get
                              // the value of text entered as shown below
                              //UserName = nameController.text;
                            });
                          },
                          onTap: () {
                            /*   isStartTime = true;*/
                            _selectTime(context);
                          },
                        ),
                        //container
                        /* ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: value,
                          itemBuilder: (BuildContext ctxt, int index) {


                            return InkWell(
                                onTap: () {
                                  _selectedIndex = index;
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Container(
                                        height: 7.h,
                                        width: 30.w,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        margin: EdgeInsets.only(
                                            top: 2.h, left: 0.w, right: 1.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          border: Border.all(
                                              color: ColorUtils
                                                  .lightGreyBorderColor),
                                          color: ColorUtils.whiteColor,
                                        ),
                                        child: new Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(
                                              child: new Flexible(
                                                child: new TextField(

                                                  textAlign: TextAlign.left,
                                                  decoration: new InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: ColorUtils
                                                              .b3Color,
                                                          fontFamily: StringUtils
                                                              .roboto_font_family_regular,
                                                          fontSize: 15),
                                                      labelStyle: TextStyle(
                                                          color: ColorUtils
                                                              .textFormFieldLabelColor,
                                                          fontFamily: StringUtils
                                                              .roboto_font_family,
                                                          fontSize: 15),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                      InputBorder.none,
                                                      enabledBorder:
                                                      InputBorder.none,
                                                      errorBorder:
                                                      InputBorder.none,
                                                      disabledBorder:
                                                      InputBorder.none,
                                                      hintText: '  Start Time'),
                                                  onChanged: (text) {
                                                    setState(() {
                                                      //you can access nameController in its scope to get
                                                      // the value of text entered as shown below
                                                      //UserName = nameController.text;
                                                    });
                                                  },
                                                  onTap: () {
                                                 */ /*   isStartTime = true;*/ /*
                                                    _selectTime(context);
                                                  },
                                                ),
                                              ), //flexible
                                            ), //container
                                          ], //widget
                                        )),
                                    Container(
                                        height: 7.h,
                                        width: 30.w,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 0),
                                        margin: EdgeInsets.only(
                                            top: 2.h, left: 1.w, right: 0.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          border: Border.all(
                                              color: ColorUtils
                                                  .lightGreyBorderColor),
                                          color: ColorUtils.whiteColor,
                                        ),
                                        child: new Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(
                                              child: new Flexible(
                                                child: new TextField(
                                                  controller:
                                                  timeController,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  textAlign: TextAlign.left,
                                                  decoration: new InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: ColorUtils
                                                              .b3Color,
                                                          fontFamily: StringUtils
                                                              .roboto_font_family_regular,
                                                          fontSize: 15),
                                                      labelStyle: TextStyle(
                                                          color: ColorUtils
                                                              .textFormFieldLabelColor,
                                                          fontFamily: StringUtils
                                                              .roboto_font_family,
                                                          fontSize: 15),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                      InputBorder.none,
                                                      enabledBorder:
                                                      InputBorder.none,
                                                      errorBorder:
                                                      InputBorder.none,
                                                      disabledBorder:
                                                      InputBorder.none,
                                                      hintText: '   End Time'),
                                                  onChanged: (text) {
                                                    setState(() {
                                                      //you can access nameController in its scope to get
                                                      // the value of text entered as shown below
                                                      //UserName = nameController.text;
                                                    });
                                                  },
                                                  onTap: () {
                                                  */ /*  isStartTime = false;*/ /*
                                                    _selectTime(context);
                                                  },
                                                ),
                                              ), //flexible
                                            ), //container
                                          ], //widget
                                        )),
                                  ],
                                ));
                          })*/
                      ),
                      /*       Expanded(child: new SizedBox(
                      height: 7.h,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              value = value + 1;
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 2.w, right: 8.w, top: 2.h),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('Add More',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                        StringUtils.roboto_font_family_bold,
                                        color: ColorUtils.appDarkBlueColor,
                                        fontSize: 18,
                                      ))))))),*/
                      Flexible(
                          child: SizedBox(
                              height: 10.h,
                              child: InkWell(
                                  child: SizedBox(
                                    height: 10.h,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            8.w, 4.h, 8.w, 0),
                                        child: SizedBox(
                                            width: 100.h,
                                            height: 10.h,
                                            child: ElevatedButton(
                                                child: Text(
                                                    'Approve'.toUpperCase(),
                                                    style: TextStyle(
                                                      fontFamily: StringUtils
                                                          .roboto_font_family_bold,
                                                      fontSize: 15,
                                                      color:
                                                          ColorUtils.whiteColor,
                                                      letterSpacing: 0.75,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                onPressed: () async {
                                                  isLoading = true;
                                                  setState() {}
                                                  Navigator.of(context).pop();
                                                  await approveAppointment(
                                                      appointmentID,
                                                      currentTime.toString());
                                                }))),
                                  ),
                                  onTap: () async {
                                    isLoading = true;
                                    Navigator.of(context).pop();
                                    setState() {}
                                  }))),
                    ],
                  )),
            );
          },
        );
      },
    );
  }
}
