import 'dart:convert';

import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/models/healer_responses/healer_appointment_response.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:doctor/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class TodayAppointment extends StatefulWidget {
  String from_page = "", token = "", tab_value='';

  @override
  TodayAppointmentState createState() => TodayAppointmentState();

 TodayAppointment({
    Key? key,
    required this.tab_value
  }) : super(key: key);
}

class TodayAppointmentState extends State<TodayAppointment>
    with WidgetsBindingObserver {
  static String routeName = '/homePage', appointmentId = "", customer_name = "";
  bool isHovering = false, isLoading = false, isShow = false, isData = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final nameController = TextEditingController();
  String appToken = "";
  List<HealerAppointmentListResponse?> appointmentList = [];
  int _selectedIndex = 0;
  bool isBottomNaviVisible = false;
  SharedPreferences? prefs;
  String? selectedSubjectItem,
      selectedChapterItem,
      subjectId = "",
      chapterId = "",
      title = "Live Classes";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();

    // Do something
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
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
      return new Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorUtils.lightGreyColor,
          body:

          FutureBuilder<HealerAppointmentResponse?>(
            future: getClientAppointments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print('snapshot--  ${snapshot.error}');
                if (appointmentList!.length > 0) {
                  print('snapshot--  ${snapshot.error}');
                  //   print('value is..  ${new Map<String, dynamic>.from(snapshot.data).}');

                  return ListView.builder(
                      itemCount:appointmentList!.length,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(elevation: 2, child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.w, right: 2.w, top: 2.h, bottom: 1.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                       healerAppointmentResponse!= null
                                            ? healerAppointmentResponse!.response![index]
                                            .clProfile
                                            .toString()
                                            : "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),

                                    backgroundColor: Colors.transparent,
                                  ),
                                  Container(width: 20.w,
                                      height: 10.h,
                                      margin: EdgeInsets.only(top: 2.h),
                                      child: Text(
                                        healerAppointmentResponse!= null
                                            ?healerAppointmentResponse!.response![index]
                                            .status
                                            .toString():'---',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                          StringUtils.roboto_font_family,
                                          color: ColorUtils.appDarkBlueColor,
                                          letterSpacing: 0.15,
                                          /*  fontWeight: FontWeight.bold,*/
                                          fontSize: 18,
                                        ),
                                      ))
                                ]),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Flexible(child: Column(
                                  children: [
                                    Container(width: 60.w, child: Text(
                                      healerAppointmentResponse!= null
                                          ? healerAppointmentResponse!.response![index]
                                          .clientName
                                          .toString():'---',
                                      style: TextStyle(
                                        fontFamily:
                                        StringUtils.roboto_font_family_bold,
                                        color: ColorUtils.appDarkBlueColor,
                                        letterSpacing: 0.15,
                                        /*  fontWeight: FontWeight.bold,*/
                                        fontSize: 18,
                                      ),
                                    )),
                                    SizedBox(height: 1.5.h,),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.radio_button_checked,
                                          color: ColorUtils.greyColor,
                                          size: 18,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 2.w),
                                            child: Container(
                                                width: 50.w, child: Text(
                                              healerAppointmentResponse!= null
                                                  ? healerAppointmentResponse!.response![index]
                                                  .therapyName
                                                  .toString():'---',
                                              style: TextStyle(
                                                fontFamily:
                                                StringUtils.roboto_font_family,
                                                color: ColorUtils.blackColor,
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
                                            padding: EdgeInsets.only(left: 2.w),
                                            child: Container(
                                                width: 50.w, child: Text(
                                              healerAppointmentResponse!= null
                                                  ? '${healerAppointmentResponse!.response![index]
                                                  .status
                                                  .toString()}(${healerAppointmentResponse!.response![index].slot})':'---',
                                              style: TextStyle(
                                                fontFamily:
                                                StringUtils.roboto_font_family,
                                                color: ColorUtils.blackColor,
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
                                            padding: EdgeInsets.only(left: 2.w),
                                            child: Container(
                                              width: 50.w, child: Text(
                                                healerAppointmentResponse!= null
                                                    ? healerAppointmentResponse!.response![index]
                                                    .address
                                                    .toString():'---',
                                                style: TextStyle(
                                                  fontFamily:
                                                  StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils.blackColor,
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
                                            padding: EdgeInsets.only(left: 2.w),
                                            child: Container(
                                                width: 50.w, child: Text(
                                              healerAppointmentResponse!= null
                                                  ? healerAppointmentResponse!.response![index]
                                                  .clientEmail
                                                  .toString():'---',
                                              style: TextStyle(
                                                fontFamily:
                                                StringUtils.roboto_font_family,
                                                color: ColorUtils.blackColor,
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
                                          Icons.call,
                                          color: ColorUtils.greyColor,
                                          size: 18,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 2.w),
                                            child: Container(
                                                width: 50.w, child: Text(
                                              healerAppointmentResponse!= null
                                                  ? healerAppointmentResponse!.response![index]
                                                  .clientMobile
                                                  .toString():'---',
                                              style: TextStyle(
                                                fontFamily:
                                                StringUtils.roboto_font_family,
                                                color: ColorUtils.blackColor,
                                                letterSpacing: 0.15,
                                                /*  fontWeight: FontWeight.bold,*/
                                                fontSize: 16,
                                              ),
                                            ))),
                                      ],
                                    ),
                                  ],
                                ))
                              ],
                            )));
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
          )

          );
    });
  }


 HealerAppointmentResponse? healerAppointmentResponse;

  Future<HealerAppointmentResponse?> getClientAppointments() async {
    var data;
    var request = await http.MultipartRequest('POST',BaseuURL.healer_appointment);

    request.fields['healer_id'] =/*prefs!.getString(StringUtils.id).toString()*/'52';
    request.fields['tab_value'] =widget.tab_value;

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

        healerAppointmentResponse =
        new HealerAppointmentResponse.fromJson(jsonResponse);
      appointmentList= healerAppointmentResponse!.response!;

      } else {

        appointmentList!.clear();
      }
    }

    return healerAppointmentResponse;




    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }
}
