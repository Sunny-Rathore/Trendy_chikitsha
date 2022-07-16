import 'dart:convert';
import 'dart:io';

import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/models/all_therapy_response.dart';
import 'package:doctor/models/healerlist_bytherapy_response.dart';
import 'package:doctor/page/Client/Client_menu/pages/therapist_details_page.dart';
import 'package:doctor/page/Client/client_navigation.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:doctor/widget/text_widget.dart';
import 'package:doctor/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:url_launcher/url_launcher.dart';

class TherapistListPage extends StatefulWidget {
  final String therapyId, therapyCategory;

  @override
  TherapistListstate createState() => TherapistListstate();

  TherapistListPage(
      {Key? key, required this.therapyId, required this.therapyCategory})
      : super(key: key);
}

class TherapistListstate extends State<TherapistListPage> {
  static const String routeName = '/homePage';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isSearching = false, isLoading = false;
  String search_text = "", appointmentId = "", appointmentCaseId = "";

  List<HealerListByTherapyResponse?> healerList = [];
  String label = "Search doctor name or category", appToken = "";
SharedPreferences? prefs;
  String share_link = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    saveValue();
  }

  saveValue() async {
       prefs = await SharedPreferences.getInstance();

 /*   Future.delayed(Duration(seconds: 1), () {
      setState(() {
        ;
      });
      // Do something
    });*/
    //  getVideoThumbnail('');
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: new Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorUtils.lightGreyColor,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          elevation: 5,
          backgroundColor: ColorUtils.trendyThemeColor,
          title: Text(
            widget.therapyCategory,
            style: TextStyle(
              fontFamily: StringUtils.roboto_font_family,
              color: ColorUtils.whiteColor,
              letterSpacing: 0.15,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          /*     actions: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(3, 0, 20, 00),
                        child: SvgPicture.asset(
                          'assets/images/profile.svg',
                          height: 22,
                          width: 22,
                        )))
              ],*/
          /*       leading: new IconButton(
                icon: new Icon(
                  Icons.menu,
                  color: ColorUtils.appDarkBlueColor,
                  size: 20,
                ),
              onPressed: (){},
              */ /*  onPressed: () => _scaffoldKey.currentState!.openDrawer(),*/ /*
              ),*/
        ),
        drawer: NavDrawer(),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Center(
            child: Column(
              children: [
                /*     Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 00),
                  child: Card(
                      elevation: 0,
                      color: ColorUtils.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(
                            color: ColorUtils.borderLineGreyColor, width: 0.4),
                      ),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 10, 10, 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/search_icon.png',
                                fit: BoxFit.fill,
                                height: 19,
                                width: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                StringUtils.search_doctor_text,
                                style: TextStyle(
                                  fontFamily: StringUtils.roboto_font_family,
                                  color: ColorUtils.greyColor.withOpacity(0.5),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )))),*/
                FutureBuilder<HealerListByTherapy?>(
                    future: getHealerListByTherapy(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print('snapshot--  ${snapshot.error}');
                        if (snapshot.hasData) {
                          if (healerList!.length > 0) {
                            return ListView.builder(
                                itemCount: healerList.length > 0
                                    ? healerList.length
                                    : 0,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  // access element from list using index
                                  // you can create and return a widget of your choice
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TherapyDetailsPage(
                                                      healerId:
                                                          healerList[index]!
                                                              .healerId
                                                              .toString(),
                                                      therapyCategory: widget
                                                          .therapyCategory,
                                                    )));
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 20, left: 1.w, right: 1.w),
                                          child: /* Card
                            color: Colors.white,
                            child: */
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      /* Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [ */
                                                      CircleAvatar(
                                                        radius: 40,
                                                        backgroundImage:
                                                            NetworkImage(healerList
                                                                        .length >
                                                                    0
                                                                ? healerList[
                                                                        index]!
                                                                    .healerProfile
                                                                    .toString()
                                                                : "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                                                      ) /*])*/,
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          //   String text, FontWeight fontWeight, Color textColor, double fontSize, String font_family
                                                          Container(
                                                              width: 60.w,
                                                              child: TextWidget(
                                                                  healerList[
                                                                          index]!
                                                                      .healerName
                                                                      .toString()
                                                                  /*therapyList.length>0
                                                                  ? therapyList[index]
                                                                  .className
                                                                  .toString()
                                                                  : ''*/
                                                                  ,
                                                                  FontWeight
                                                                      .normal,
                                                                  Colors.black,
                                                                  17,
                                                                  StringUtils
                                                                      .roboto_font_family)),
                                                          TextWidget(
                                                              healerList[index]!
                                                                  .experience
                                                                  .toString()
                                                              /*therapyList.length>0
                                                                  ? therapyList[index]
                                                                  .className
                                                                  .toString()
                                                                  : ''*/
                                                              ,
                                                              FontWeight.normal,
                                                              ColorUtils
                                                                  .greyTextColor,
                                                              15,
                                                              StringUtils
                                                                  .roboto_font_family),
                                                        ],
                                                      ),
                                                    ],
                                                  )))) /*)*/;
                                });
                          } else {
                            return SizedBox(
                                height: 500,
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/images/no_data.json',
                                    repeat: false,
                                    height: 40.h,
                                    width: 35.w,
                                    reverse: false,
                                    animate: true,
                                  ),

                                ));
                          }
                        } else {
                          return SizedBox(
                              height: 500,
                              child: Center(
                                child: Lottie.asset(
                                  'assets/images/no_data.json',
                                  repeat: false,
                                  height: 40.h,
                                  width: 35.w,
                                  reverse: false,
                                  animate: true,
                                ),

                              ));
                        }
                      } else {
                        return SpinKitFadingCircleWidget(true);
                      }
                    }),
              ],
            ),
          )))
        ]),
      ));
    });
  }

  Future<HealerListByTherapy?> getHealerListByTherapy() async {
    var data;
    HealerListByTherapy? healerListByTherapy;
    var request = await http.MultipartRequest('POST',BaseuURL.healerByTherapy);

     request.fields['therapy_id'] = widget.therapyId;
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

         healerListByTherapy =
        new HealerListByTherapy.fromJson(jsonResponse);
        /*  setState(() {*/
        healerList = healerListByTherapy!.response!
            .cast<HealerListByTherapyResponse?>();

        //   leadList.add(person.campaignData.indexOf(0));
        /*   });*/
        //  showAlertDialog(context, "Uploaded KYC successfully" );
      } else {
        healerList!.clear();

      }
    }

    return healerListByTherapy;




    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }
}
