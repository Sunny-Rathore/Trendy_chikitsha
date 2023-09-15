import 'dart:convert';

import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/all_therapy_response.dart';
import 'package:trendy_chikitsa/page/Client/Client_menu/pages/therapistlist_page.dart';
import 'package:trendy_chikitsa/page/Client/client_navigation.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/size_util.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class TherapyCategories extends StatefulWidget {
  const TherapyCategories({Key? key}) : super(key: key);

  @override
  State<TherapyCategories> createState() => TherapyCategoriesState();
}

class TherapyCategoriesState extends State<TherapyCategories> {
  List<TherapyList> therapyList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    saveValue();
  }

  saveValue() async {
 //   prefs = await SharedPreferences.getInstance();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
       
      });
      // Do something
    });
    //  getVideoThumbnail('');
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              elevation: 5,
              backgroundColor: ColorUtils.trendyThemeColor,
              title: Text(
                "Therapies",
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
              *//*  onPressed: () => _scaffoldKey.currentState!.openDrawer(),*//*
              ),*/
            ),
        drawer: NavDrawer(),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
            child: FutureBuilder<TherapyList?>(
              future: getTherapies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print('snapshot--  ${snapshot.error}');
                  if (therapyList.isNotEmpty) {
                    print('snapshot--  ${snapshot.error}');
                    //   print('value is..  ${new Map<String, dynamic>.from(snapshot.data).}');

                    return Container(
                        /* height: MediaQuery.of(context).size.height,*/
                        child: GridView.builder(
                            shrinkWrap: true,
                           /* physics: NeverScrollableScrollPhysics(),*/
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount:therapyList.isNotEmpty? therapyList.length : 0,
                            itemBuilder: (BuildContext ctx, index) {
                              print('lll-   ${therapyList[index].therapy_name}');
                              return GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TherapistListPage(therapyId: therapyList[index].therapyId.toString(),therapyCategory: therapyList[index].therapy_name.toString(),)));
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
                                    SizedBox(
                                        height: 600,
                                        width: 125,
                                        child: Column(children: [
                                          Container(
                                            height: 120,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      DimenUtils.dimen_17),
                                                  topRight: Radius.circular(
                                                      DimenUtils.dimen_17)),
                                              image: DecorationImage(
                                                image: NetworkImage(therapyList.isNotEmpty
                                                    ? therapyList[index]
                                                    .therapy_image
                                                    .toString()
                                                    :
                                                    "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: const Text(""),
                                          ),
                                          Container(
                                            height: 60,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              color: ColorUtils.trendyButtonColor,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                      DimenUtils.dimen_17),
                                                  bottomRight: Radius.circular(
                                                      DimenUtils.dimen_17)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  therapyList.isNotEmpty
                                                      ? therapyList[index]
                                                          .therapy_name
                                                          .toString()
                                                      : '',
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color: ColorUtils.whiteColor
                                                        ,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16,
                                                  )),
                                            ),
                                          )
                                        ])),
                              ) /*)*/;
                            }));
                  } else {
                    return SizedBox(
                        height: 500,
                        child: Center(

                            child:  Lottie.asset(
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
                } else {
                  return SpinKitFadingCircleWidget(true);
                }
              },
            )),
      ));
    });
  }

  Future<TherapyList?> getTherapies() async {
    var data;

    var request = http.MultipartRequest('GET', BaseuURL.allTherapies);

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
              print('--->>?   $data');

              if (data["status"] == "true" && data["msg"] == "success") {
                print('Login succssfull---    ');

                final jsonResponse = json.decode(response.body);

                AllTherapyResponse studentAllChapterResponse =
                    AllTherapyResponse.fromJson(jsonResponse);
              /*  setState(() {*/
                  therapyList = studentAllChapterResponse.response!;

                  //   leadList.add(person.campaignData.indexOf(0));
             /*   });*/
                //  showAlertDialog(context, "Uploaded KYC successfully" );
              } else {
                therapyList.clear();
                setState(() {});
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
