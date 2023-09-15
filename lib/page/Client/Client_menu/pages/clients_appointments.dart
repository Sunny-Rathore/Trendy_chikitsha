import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';

import 'package:trendy_chikitsa/api.dart';
import 'package:trendy_chikitsa/baseurl/baseURL.dart';

import 'package:trendy_chikitsa/models/client_responses/client_appointment_response.dart';
import 'package:trendy_chikitsa/models/client_responses/create_meeting_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/submit_review_response.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/video_sdk_utils/screens/meeting_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientAppointments extends StatefulWidget {
  String from_page = "", token = "";

  ClientAppointments({super.key});

  @override
  ClientAppointmentsState createState() => ClientAppointmentsState();

/* TodayAppointment({
    Key? key,
    required this.from_page
  }) : super(key: key);*/
}

class ClientAppointmentsState extends State<ClientAppointments>
    with WidgetsBindingObserver {
  static String routeName = '/homePage', appointmentId = "", customer_name = "";
  bool isHovering = false, isLoading = false, isShow = false, isData = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMeetingActive = false;
  final nameController = TextEditingController();
  String appToken = "";
  List<AppointmentResponse?> appointmentList = [];
  int? _selectedIndex = 0, index1;
  bool isBottomNaviVisible = false;
  SharedPreferences? prefs;
  String? selectedSubjectItem,
      selectedChapterItem,
      subjectId = "",
      chapterId = "",
      title = "Live Classes";
  String? meetingId = '';
  final TextEditingController _textEditingController = TextEditingController();

  /*// Payment Details
  String? phone, email, productName, firstName, txnID, amount;*/
  // Payment Details
  String phone = "6265564364";
  String email = "jyoti@gmail.com";
  String productName = "Name";
  String firstName = "Vaibhav";
  String txnID = "7837473784";
  String amount = "1.0";

  // Creating PayuMoneyFlutter Instance
  /*PayuMoneyFlutter payuMoneyFlutter = PayuMoneyFlutter();*/
  final String _platformVersion = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken();
    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<void> initializePayment(
      String amountParam, String productInfo, String transactionID) async {
    // print('all params---   $amountParam  $productInfo,   $transactionID');
    final response = await PayumoneyProUnofficial.payUParams(
        email: prefs!.getString(StringUtils.email).toString(),
        firstName: prefs!.getString(StringUtils.name).toString(),
        merchantName: 'Trendy Chikitsa' /*Tanushree Zirwar*/,
        isProduction: true,
        merchantKey: 'YlWDlr',
        merchantSalt: 'd2vfL9AcKegkvpV8LJ57Rl9dBjBJCWXE',
        amount: amountParam,
        hashUrl: 'https://trendychikitsa.com/Payumoney/checkout',
        //nodejs code is included. Host the code and update its url here.
        productInfo: productInfo,
        transactionId: transactionID,
        showExitConfirmation: false,
        showLogs: false,
        // true for debugging, false for production
        userCredentials:
            'YlWDlr:' + prefs!.getString(StringUtils.email).toString(),
        userPhoneNumber: prefs!.getString(StringUtils.mobile).toString());

    if (response['status'] == PayUParams.success) {
      handlePaymentSuccess(transactionID);
    }
    if (response['status'] == PayUParams.failed) {
      handlePaymentFailure(response['message']);
    }
  }

// Function for setting up the payment details
  /*setupPayment() async {
    bool response = await payuMoneyFlutter.setupPaymentKeys(

        merchantKey: "YlWDlr",
        merchantID: "8649137",
        isProduction: true,
        activityTitle: "Trendy Chikitsa",
        disableExitConfirmation: true);

    print('setup response--    ${response}');
  }
*/
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

  handlePaymentSuccess(String transID) async {
    // print('---->payment success>>  $index1');

    meetingId = await createMeeting();
    // print('Meeting ID--   $meetingId');
    createMeetingForAppointment(
        meetingId.toString(),
        clientAppointmentResponse!.response![index1!].book_id.toString(),
        transID);

//Implement Your Success Logic
  }

  handlePaymentFailure(String errorMessage) {
    // print(errorMessage);
//Implement Your Failed Payment Logic
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorUtils.lightGreyColor,
          /* drawer: NavDrawer(),*/
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
            title: Text('My Appointments',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: StringUtils.roboto_font_family,
                  color: ColorUtils.whiteColor,
                  fontSize: 18,
                )),
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            /*           leading: GestureDetector(
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
          ),
          body: FutureBuilder<ClientAppointmentResponse?>(
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
                                              clientAppointmentResponse != null
                                                  ? clientAppointmentResponse!
                                                      .response![index]
                                                      .healerProfile
                                                      .toString()
                                                  : "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        Container(
                                            width: 21.w,
                                            height: 10.h,
                                            margin: EdgeInsets.only(top: 2.h),
                                            child: Text(
                                              clientAppointmentResponse != null
                                                  ? clientAppointmentResponse!
                                                      .response![index].status
                                                      .toString()
                                                  : '---',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: StringUtils
                                                    .roboto_font_family,
                                                color:
                                                    ColorUtils.appDarkBlueColor,
                                                letterSpacing: 0.15,
                                                /*  fontWeight: FontWeight.bold,*/
                                                fontSize: 15,
                                              ),
                                            )),
                                      ]),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Flexible(
                                          child: Column(
                                        children: [
                                          Row(children: [
                                            SizedBox(
                                                width: 60.w,
                                                child: Text(
                                                  clientAppointmentResponse !=
                                                          null
                                                      ? clientAppointmentResponse!
                                                          .response![index]
                                                          .healerName
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
                                            Visibility(
                                                visible:
                                                    clientAppointmentResponse !=
                                                            null
                                                        ? clientAppointmentResponse!
                                                                .response![
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            'Completed'
                                                        /*'Paid'*/
                                                        : true,
                                                child: InkWell(
                                                    onTap: () {
                                                      showD(
                                                          clientAppointmentResponse!
                                                              .response![index]
                                                              .book_id
                                                              .toString());
                                                    },
                                                    child: Row(children: [
                                                      Text(
                                                        '3',
                                                        style: TextStyle(
                                                          fontFamily: StringUtils
                                                              .roboto_font_family_bold,
                                                          color: ColorUtils
                                                              .appDarkBlueColor,
                                                          letterSpacing: 0.15,
                                                          /*  fontWeight: FontWeight.bold,*/
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                        size: 25,
                                                      ),
                                                    ])))
                                          ]),
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
                                                        clientAppointmentResponse !=
                                                                null
                                                            ? clientAppointmentResponse!
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
                                                  child: SizedBox(
                                                      width: 50.w,
                                                      child: Text(
                                                        clientAppointmentResponse !=
                                                                null
                                                            ? '${clientAppointmentResponse!.response![index].status.toString()}(${clientAppointmentResponse!.response![index].slot} on ${clientAppointmentResponse!.response![index].date})'
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
                                                        clientAppointmentResponse !=
                                                                null
                                                            ? clientAppointmentResponse!
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
                                          InkWell(
                                              onTap: () {
                                                launch(
                                                    'mailto:${clientAppointmentResponse!.response![index].healerEmail.toString()}');
                                              },
                                              child: Row(
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
                                                          child: Text(
                                                            clientAppointmentResponse !=
                                                                    null
                                                                ? clientAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .healerEmail
                                                                    .toString()
                                                                : '---',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              color: Colors
                                                                  .lightBlue,
                                                              letterSpacing:
                                                                  0.15,
                                                              /*  fontWeight: FontWeight.bold,*/
                                                              fontSize: 16,
                                                            ),
                                                          ))),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          InkWell(
                                              onTap: () async {
                                                launch(
                                                    'tel:+91${clientAppointmentResponse!.response![index].healerMobile.toString()}');
                                              },
                                              child: Row(
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
                                                          child: Text(
                                                            clientAppointmentResponse !=
                                                                    null
                                                                ? clientAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .healerMobile
                                                                    .toString()
                                                                : '---',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              color: Colors
                                                                  .lightBlue,
                                                              letterSpacing:
                                                                  0.15,
                                                              /*  fontWeight: FontWeight.bold,*/
                                                              fontSize: 16,
                                                            ),
                                                          ))),
                                                ],
                                              )),
                                        ],
                                      ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Visibility(
                                          visible:
                                              clientAppointmentResponse != null
                                                  ? clientAppointmentResponse!
                                                          .response![index]
                                                          .status
                                                          .toString() ==
                                                      'Confirmed'
                                                  /*'Paid'*/
                                                  : true,
                                          child: InkWell(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0.w, 1.h, 0.w, 0.h),
                                                child: SizedBox(
                                                    width: 15.h,
                                                    height: 5.h,
                                                    child: ElevatedButton(
                                                        child: Text(
                                                            clientAppointmentResponse!
                                                                        .response![
                                                                            index]
                                                                        .amount
                                                                        .toString()
                                                                        .trim() ==
                                                                    'Free'
                                                                ? 'Start'
                                                                : 'Pay'
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
                                                                        .greenColor),
                                                            backgroundColor:
                                                                MaterialStateProperty.all<Color>(
                                                                    ColorUtils.greenColor),
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: ColorUtils.greenColor)))),
                                                        onPressed: () async {
                                                          /*isLoading = true;*/

                                                          if (clientAppointmentResponse!
                                                                  .response![
                                                                      index]
                                                                  .amount
                                                                  .toString()
                                                                  .trim() ==
                                                              'Free') {
                                                            meetingId =
                                                                await createMeeting();
                                                            print(
                                                                'Meeting ID--   $meetingId');
                                                            createMeetingForAppointment(
                                                                meetingId
                                                                    .toString(),
                                                                clientAppointmentResponse!
                                                                    .response![
                                                                        index]
                                                                    .book_id
                                                                    .toString(),
                                                                '');
                                                          } else {
                                                            index1 = index;
                                                            var rng = Random();
                                                            var code =
                                                                rng.nextInt(
                                                                        900000) +
                                                                    100000;
                                                            String
                                                                randomString =
                                                                '$code${DateTime.now().toString().substring(20, 25)}';
                                                            print(
                                                                'check amount---    ${clientAppointmentResponse!.response![index].amount.toString()}');
                                                            initializePayment(
                                                              clientAppointmentResponse!
                                                                  .response![
                                                                      index]
                                                                  .amount
                                                                  .toString(),
                                                              clientAppointmentResponse!
                                                                  .response![
                                                                      index]
                                                                  .therapyName
                                                                  .toString(),
                                                              randomString,
                                                            );
                                                          }

                                                          //    startPayment();
                                                        })),
                                              ),
                                              onTap: () async {
                                                isLoading = true;

                                                index1 = index;
                                                var rng = Random();
                                                var code = rng.nextInt(900000) +
                                                    100000;
                                                String randomString =
                                                    '$code${DateTime.now().toString().substring(20, 25)}';
                                                print(
                                                    'check amount---    ${clientAppointmentResponse!.response![index].amount.toString()}');
                                                initializePayment(
                                                  clientAppointmentResponse!
                                                      .response![index].amount
                                                      .toString(),
                                                  clientAppointmentResponse!
                                                      .response![index]
                                                      .therapyName
                                                      .toString(),
                                                  randomString,
                                                );

                                                setState(() {});
                                              })),
                                      Visibility(
                                          visible:
                                              clientAppointmentResponse != null
                                                  ? clientAppointmentResponse!
                                                          .response![index]
                                                          .status
                                                          .toString() ==
                                                      'Paid' /*'Pending'*/
                                                  : true,
                                          child: InkWell(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0.w, 1.h, 0.w, 0.h),
                                                child: SizedBox(
                                                    width: 18.h,
                                                    height: 5.h,
                                                    child: ElevatedButton(
                                                        child: Text(
                                                            'Join Call'
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
                                                                MaterialStateProperty.all<Color>(ColorUtils
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
                                                              'meeting ID is here--   ${clientAppointmentResponse!.response![index].meeting_id.toString()}');
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute<
                                                                dynamic>(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  MeetingScreen(
                                                                meetingId: clientAppointmentResponse!
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
                                                        })),
                                              ),
                                              onTap: () async {
                                                isLoading = true;
                                                setState(() {});
                                                print(
                                                    'meeting ID is here--   ${clientAppointmentResponse!.response![index].meeting_id.toString()}');
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute<dynamic>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        MeetingScreen(
                                                      meetingId:
                                                          clientAppointmentResponse!
                                                              .response![index]
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
                                                /*    Navigator.push(
                                                  context,
                                                  MaterialPageRoute<dynamic>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        MeetingScreen(
                                                          meetingId: clientAppointmentResponse!
                                                              .response![index].meeting_id
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
                                    ],
                                  ),
                                  /*       SizedBox(width:70.w,child:    RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 5,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ))*/
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
                    width: 500,
                    height: 500,
                    child: Center(
                      child: Lottie.asset(
                        'assets/images/loading_data.json',
                        fit: BoxFit.fitWidth,
                        repeat: true,
                        height: 30.w,
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

  ClientAppointmentResponse? clientAppointmentResponse;

  Future<ClientAppointmentResponse?> getClientAppointments() async {
    var data;
    var request = http.MultipartRequest('POST', BaseuURL.client_appointment);

    request.fields['client_id'] =
        prefs!.getString(StringUtils.id).toString() /*'1'*/;
    // var res = await request.send();
    // var res = await request.send();
    var response = await request.send();
    final responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // print("Uploaded!    ${prefs!.getString(StringUtils.id).toString()}");
      // print('response.body ' + responsed.body);
      var jsonData = responsed.body;

      // print(jsonData);
      data = json.decode(responsed.body);

      var rest1 = data["msg"];
      data = json.decode(responsed.body);
      // print('--->>?   $data');

      if (data["status"] == "true" && data["msg"] == "success") {
        // print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        clientAppointmentResponse =
            ClientAppointmentResponse.fromJson(jsonResponse);
        appointmentList = clientAppointmentResponse!.response!;
      } else {
        appointmentList.clear();
      }
    }

    return clientAppointmentResponse;

    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }

  CreateMeetingResponse? _createMeetingResponse;

  Future<CreateMeetingResponse?> createMeetingForAppointment(
      String meetingId, bookId, String txnId) async {
    var data;
    try {
      // print(
      //     'fetched healer id-   ${prefs!.getString(StringUtils.id).toString()},  $bookId, $meetingId');
      var request = http.MultipartRequest('POST', BaseuURL.create_meeting);

      request.fields['book_id'] = bookId;
      request.fields['meeting_id'] = meetingId;
      request.fields['txn_id'] = txnId;
      var response = await request.send();
      final responsed = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        // print('response.body ' + responsed.body);
        var jsonData = responsed.body;

        // print(jsonData);
        data = json.decode(responsed.body);

        if (data["status"] == "true" &&
            data["msg"] == "Success! Your payment is done successfully!!!") {
          // print('createMeetingForAppointment--    ');

          final jsonResponse = json.decode(responsed.body);

          _createMeetingResponse = CreateMeetingResponse.fromJson(jsonResponse);
        } else {}
      }

      setState(() {});
    } catch (e) {
      print('exce --   ${e.toString()}    ');
    }
    return _createMeetingResponse;
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
                content: Flexible(
                  child: SizedBox(
                      height: 50.h,
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
                              margin: EdgeInsets.only(
                                  top: 2.h, left: 0.w, right: 1.w),
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
                                        fontFamily: StringUtils
                                            .roboto_font_family_regular,
                                        fontSize: 17),
                                    labelStyle: TextStyle(
                                        color:
                                            ColorUtils.textFormFieldLabelColor,
                                        fontFamily:
                                            StringUtils.roboto_font_family,
                                        fontSize: 17),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: '  Share your experience here'),
                                onChanged: (text) {},
                                onTap: () {},
                              )),
                          InkWell(
                              child: Container(
                                height: 5.h,
                                width: 100.h,
                                margin: EdgeInsets.only(top: 2.h),
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
                                        elevation: MaterialStateProperty.all(0),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorUtils.violetButtonColor),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorUtils.violetButtonColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                    color:
                                                        ColorUtils.violetButtonColor)))),
                                    onPressed: () {
                                      submitReview(
                                          appointment,
                                          appointment,
                                          _textEditingController.text
                                              .toString());
                                    }),
                              ),
                              onTap: () async {
                                submitReview(appointment, appointment,
                                    _textEditingController.text.toString());
                              })
                        ],
                      )),
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
    // print('updateScheduleTime   $appointmentId,   $rating,   $comments');
    var request = http.MultipartRequest('POST', BaseuURL.submit_review);

    request.fields['appointment_id'] = appointmentId;
    request.fields['rating'] = rating;

    request.fields['comment'] = comments;

    request
        .send()
        .then((result) async {
          http.Response.fromStream(result).then((response) {
            if (response.statusCode == 200) {
              // print("Uploaded! ");
              // print('response.body ' + response.body);

              var jsonData = response.body;
              // print(jsonData);
              data = json.decode(response.body);

              var rest1 = data["msg"];
              data = json.decode(response.body);
              // print('--->>?   $data');

              if (data["status"] == "true" &&
                  (data["msg"] ==
                      "Success! Your review has been submitted successfully.")) {
                _submitReviewResponse =
                    SubmitReviewResponse.fromJson(jsonDecode(response.body));

                Future.delayed(const Duration(seconds: 2), () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                    isLoading = false;

                    setState(() {});
                  }

                  showAlertDialog(context, data["msg"]);
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
                        fontSize: 20))),
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
