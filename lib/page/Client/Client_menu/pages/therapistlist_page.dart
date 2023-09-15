import 'dart:convert';

import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/healerlist_bytherapy_response.dart';
import 'package:trendy_chikitsa/page/Client/Client_menu/pages/therapist_details_page.dart';
import 'package:trendy_chikitsa/page/Client/client_navigation.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/widget/text_widget.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


class TherapistListPage extends StatefulWidget {
  final String therapyId, therapyCategory;

  @override
  TherapistListstate createState() => TherapistListstate();

  const TherapistListPage(
      {Key? key, required this.therapyId, required this.therapyCategory})
      : super(key: key);
}

class TherapistListstate extends State<TherapistListPage> {
  static const String routeName = '/homePage';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
setState(() {
  
});
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
          child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorUtils.lightGreyColor,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
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
          
        ),
        drawer: NavDrawer(),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Center(
            child: Column(
              children: [
                
                FutureBuilder<HealerListByTherapy?>(
                    future: getHealerListByTherapy(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print('snapshot--  ${snapshot.error}');
                        if (snapshot.hasData) {
                          if (healerList.isNotEmpty) {
                            return ListView.builder(
                                itemCount: healerList.isNotEmpty
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                                                    .isNotEmpty
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
                                                          SizedBox(
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
    var request = http.MultipartRequest('POST', BaseuURL.healerByTherapy);

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
      print('--->>?   $data');

      if (data["status"] == "true" && data["msg"] == "success") {
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        healerListByTherapy = HealerListByTherapy.fromJson(jsonResponse);
        /*  setState(() {*/
        healerList =
            healerListByTherapy.response!.cast<HealerListByTherapyResponse?>();

        //   leadList.add(person.campaignData.indexOf(0));
        /*   });*/
        //  showAlertDialog(context, "Uploaded KYC successfully" );
      } else {
        healerList.clear();
      }
    }

    return healerListByTherapy;

    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }
}
