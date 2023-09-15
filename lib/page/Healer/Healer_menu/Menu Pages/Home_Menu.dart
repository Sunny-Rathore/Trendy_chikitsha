import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/global/global.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_profile_fetch_data.dart';
import 'package:trendy_chikitsa/models/healer_responses/total_counting_response.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/Appointments.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/CurrentPlanPage.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/Schedule_Timings.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/change_password.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/healer_profile.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/healer_review_list.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/healer_transaction_list.dart';

import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/social_media.dart';
import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/upgrade_pricing_plan.dart';
import 'package:trendy_chikitsa/page/LoginPage.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../models/healer_responses/healer_review_list_response.dart';

class Home_Menu extends StatefulWidget {
  const Home_Menu({Key? key}) : super(key: key);

  @override
  State<Home_Menu> createState() => _Home_MenuState();
}

class _Home_MenuState extends State<Home_Menu> {
  SharedPreferences? prefs;
  String? total_appointments,
      todays_appointment,
      upcoming_appointment,
      total_amount;
  int? expire_status = 0;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    //  saveValue();

    super.initState();
    saveValue();
    getHealerReviews();
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
      debugPrint("Uploaded! ");
      debugPrint('response.body ' + responsed.body);
      var jsonData = responsed.body;

      debugPrint(jsonData);
      data = json.decode(responsed.body);

      var rest1 = data["msg"];
      data = json.decode(responsed.body);
      debugPrint('--->>?   $data');

      if (data["status"] == "true" && data["msg"] == "success") {
        debugPrint('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        _healerReviewListResponse =
            HealerReviewListResponse.fromJson(jsonResponse);
        //  appointmentList = clientAppointmentResponse!.response!;
      } else {
        // appointmentList!.clear();
      }
    }

    return _healerReviewListResponse;

    //debugPrint('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }

  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    setState(() {});
    debugPrint('lll---  ${prefs!.getString(StringUtils.name).toString()}');
    getSocialMediaLinks();
    getFetchProfileData();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(animated: true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            extendBody: true,
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                children: [
                  SizedBox(
                      height: 29.h,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: ColorUtils.trendyThemeColor,
                        ), //BoxDecoration
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: ColorUtils.trendyThemeColor,
                          ),
                          accountName: Text(
                            prefs != null
                                ? prefs!.getString(StringUtils.name).toString()
                                : '',
                            style: const TextStyle(
                              fontSize: 20,
                              //color: ColorUtils.trendyThemeColor
                            ),
                          ),
                          accountEmail: Text(
                            prefs != null
                                ? prefs!.getString(StringUtils.email).toString()
                                : '',
                            style: TextStyle(
                              fontSize: 10.sp,
                              //color: ColorUtils.trendyThemeColor
                            ),
                          ),
                          currentAccountPictureSize: const Size.square(90),
                          currentAccountPicture: CircleAvatar(
                            radius: 90.0,
                            backgroundImage: NetworkImage(prefs != null
                                ? 'https://trendychikitsa.com/images/profile/${prefs!.getString(StringUtils.profile_image).toString()}'
                                : 'https://trendychikitsa.com/img/users.png'),
                            backgroundColor: Colors.white,
                          ), //circleAvatar
                        ), //UserAccountDrawerHeader
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      size: 30,
                      // color: Colors.white,
                    ),
                    title: const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 16,
                        //color: Colors.white
                      ),
                    ),
                    /* trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home_Menu()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.place,
                      size: 30,
                      // color: Colors.white
                    ),
                    title: const Text(
                      "Current Plan",
                      style: TextStyle(
                        fontSize: 16,
                        // color: Colors.white
                      ),
                    ),
                    /*  trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CurrentPlanPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.date_range,
                      size: 30,
                      // color: Colors.white
                    ),
                    title: const Text(
                      "Appointments",
                      style: TextStyle(
                        fontSize: 16,
                        // color: Colors.white
                      ),
                    ),
                    /*  trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Appointments(
                                    pageidex: 0,
                                  )));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.lock_clock,
                      size: 30,
                      // color: Colors.white
                    ),
                    title: const Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 16,
                        //color: Colors.white
                      ),
                    ),
                    /* trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HealerChangePassword()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.admin_panel_settings,
                      size: 30,
                      //color: Colors.white
                    ),
                    title: const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 16,
                        // color: Colors.white
                      ),
                    ),
                    /*  trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileSetting()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.reviews,
                      size: 30,
                      //color: Colors.white
                    ),
                    title: Row(
                      children: [
                        const Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 16,
                            //
                            // color: Colors.white
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 20,
                          color: ColorUtils.trendyButtonColor,
                          child: Text(
                              _healerReviewListResponse == null
                                  ? "0"
                                  : _healerReviewListResponse!.response!.length
                                      .toString(),
                              style: TextStyle(
                                  fontFamily: StringUtils.roboto_font_family,
                                  color: ColorUtils.whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    /*  trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HealerReviewList()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.schedule,
                      size: 30,
                      // color: Colors.white
                    ),
                    title: const Text(
                      "Schedule",
                      style: TextStyle(
                        fontSize: 16,
                        // color: Colors.white
                      ),
                    ),
                    /*    trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Schedule_Timings()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.interests,
                      size: 30,
                      //color: Colors.white
                    ),
                    title: const Text(
                      "Social Media",
                      style: TextStyle(
                        fontSize: 16,
                        //color: Colors.white
                      ),
                    ),
                    /* trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SocialMedia()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.history,
                      size: 30,
                      // color: Colors.white
                    ),
                    title: const Text(
                      "Transactions",
                      style: TextStyle(
                        fontSize: 16,
                        //color: Colors.white
                      ),
                    ),
                    /* trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HealerTransactionList()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout, size: 30,
                      // color: Colors.white
                    ),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        //color: Colors.white
                      ),
                    ),
                    /*   trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),*/
                    onTap: () {
                      prefs!.setString(StringUtils.completeProfile, "No");
                      prefs!.setString(StringUtils.id, "");
                      prefs!.setString(StringUtils.unique_id, "");
                      prefs!.setString(StringUtils.type, "");
                      prefs!.setString(StringUtils.name, "");

                      prefs!.setString(StringUtils.profile_image, "");
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const LoginPage(),
                        ),
                        (route) =>
                            false, //if you want to disable back feature set to false
                      );
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: ColorUtils.trendyThemeColor,
              title: const Text("Home", style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
            /*  bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 50,
          buttonBackgroundColor: Colors.blue,
          color: Colors.lightGreen,
          items:   const [
            Icon(Icons.home, size: 30,),
            Icon(Icons.list, size: 30,),
            Icon(Icons.compare_arrows,),
          ],
          onTap: (index) {

          },
        ),
      ),*/
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Visibility(
                        visible: expire_status == 1,
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UpgradePricingPlan()));
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Your plan is expired. ',
                                    style: TextStyle(
                                      fontFamily:
                                          StringUtils.roboto_font_family,
                                      color: ColorUtils.trendyButtonColor,
                                      letterSpacing: 0.15,
                                      /*  fontWeight: FontWeight.bold,*/
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Click Here',
                                    style: TextStyle(
                                      fontFamily:
                                          StringUtils.roboto_font_family,
                                      color: Colors.blueAccent,
                                      letterSpacing: 0.15,
                                      /*  fontWeight: FontWeight.bold,*/
                                      fontSize: 19,
                                    ),
                                  ),
                                  TextSpan(
                                      text: ' to upgrade your pricing plan.',
                                      style: TextStyle(
                                        fontFamily:
                                            StringUtils.roboto_font_family,
                                        color: ColorUtils.trendyButtonColor,
                                        letterSpacing: 0.15,
                                        /*  fontWeight: FontWeight.bold,*/
                                        fontSize: 17,
                                      )),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      CarouselSlider(
                        items: [
                          //1st Image of Slider
                          Container(
                            margin: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/healer_a.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //2nd Image of Slider
                          Container(
                            margin: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/healer_b.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //3rd Image of Slider
                          Container(
                            margin: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/healer_c.png"),
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
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Appointments(
                                          pageidex: 1,
                                        )));
                              },
                              child: SizedBox(
                                  height: 17.h,
                                  width: 22.h,
                                  child: Card(
                                      elevation: 2,
                                      color: Colors.red,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.2.w,
                                              right: 0.2.w,
                                              top: 2.h,
                                              bottom: 1.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                upcoming_appointment != null
                                                    ? upcoming_appointment
                                                        .toString()
                                                    : '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils.whiteColor,
                                                  letterSpacing: 0.15,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                'Upcoming Appointments',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils.whiteColor,
                                                  letterSpacing: 0.15,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          )))),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Appointments(
                                          pageidex: 0,
                                        )));
                              },
                              child: SizedBox(
                                  height: 17.h,
                                  width: 22.h,
                                  child: Card(
                                      elevation: 2,
                                      color: Colors.blueGrey,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.2.w,
                                              right: 0.2.w,
                                              top: 2.h,
                                              bottom: 1.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                todays_appointment != null
                                                    ? todays_appointment
                                                        .toString()
                                                    : '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils.whiteColor,
                                                  letterSpacing: 0.15,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                'Today Appointments',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils.whiteColor,
                                                  letterSpacing: 0.15,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          )))),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: 17.h,
                                width: 22.h,
                                child: Card(
                                    elevation: 2,
                                    color: Colors.green,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.2.w,
                                            right: 0.2.w,
                                            top: 2.h,
                                            bottom: 1.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              total_appointments != null
                                                  ? total_appointments
                                                      .toString()
                                                  : '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: StringUtils
                                                    .roboto_font_family,
                                                color: ColorUtils.whiteColor,
                                                letterSpacing: 0.15,
                                                /*  fontWeight: FontWeight.bold,*/
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              ' Total Appointments',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: StringUtils
                                                    .roboto_font_family,
                                                color: ColorUtils.whiteColor,
                                                letterSpacing: 0.15,
                                                /*  fontWeight: FontWeight.bold,*/
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        )))),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        HealerTransactionList()));
                              },
                              child: SizedBox(
                                  height: 17.h,
                                  width: 22.h,
                                  child: Card(
                                      elevation: 2,
                                      color: Colors.lightBlueAccent,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.2.w,
                                              right: 0.2.w,
                                              top: 2.h,
                                              bottom: 1.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                total_amount != null
                                                    ? '\u{20B9}  ${total_amount.toString()}'
                                                    : '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils.whiteColor,
                                                  letterSpacing: 0.15,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                'Total Earning ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils.whiteColor,
                                                  letterSpacing: 0.15,
                                                  /*  fontWeight: FontWeight.bold,*/
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          )))),
                            ),
                          ]),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              "WHO WE ARE",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorbargandi,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Hola healers!!!!! Trendy Chikitsa facilitates healers to focus on their aim to heal as many souls as '
                              'possible. We at Trendy Chikitsa, are committed to bring seekers to your doorstep. We will leave no stone '
                              'unturned in order to fulfil this objective. We need to ensure that alternative healing therapies are'
                              'propagated positively to the farthest habitat. So Healers, join us and make this world more beautiful.',
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.colorBlack),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft,
                            colors: [
                              Colors.red.shade300,
                              Colors.yellow.shade500,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "WHY CHOOSE TRENDY CHIKITSA",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.colorJambli),
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.asset(
                                              'assets/images/handshake.png')),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: const Center(
                                        child: Text(
                                          "Connect with Seekers",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: const Center(
                                        child: Text(
                                          "Find and help believers with your healing abilities via Trendy Chikitsa.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.asset(
                                              'assets/images/home.png')),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: const Center(
                                        child: Text(
                                          "Sharpen your Healing Skills",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: const Center(
                                        child: Text(
                                          "Trendy Chikitsa brings you in contact with a wide "
                                          "variety of seekers who motivate you to stay updated in your field and enhance your expertise.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.asset(
                                              'assets/images/hong.png')),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: const Center(
                                        child: Text(
                                          "Showcase your Therapy",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: const Center(
                                        child: Text(
                                          "Find success through Trendy Chikitsa. Heal our esteemed clients and become a master of your trade.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: SizedBox(
                                          height: 90,
                                          width: 90,
                                          child: Image.asset(
                                              'assets/images/box.png')),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: const Center(
                                        child: Text(
                                          "Choose your own Working Hours",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: const Center(
                                        child: Text(
                                          "Be your own boss and heal seekers in your own time. No pressure!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }

  TotalCountingResponse? totalCountingResponse;

  Future<TotalCountingResponse?> getSocialMediaLinks() async {
    setState(() {});
    var data;
    debugPrint(
        'getSocialMediaLinks   ${prefs!.getString(StringUtils.id).toString()}');
    var request = http.MultipartRequest('POST', BaseuURL.total_counting);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();

    // var res = await request.send();
    var response = await request.send();
    final responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      debugPrint("Uploaded! ");
      debugPrint('response.body ' + responsed.body);
      var jsonData = responsed.body;

      debugPrint(jsonData);
      data = json.decode(responsed.body);

      var rest1 = data["msg"];
      data = json.decode(responsed.body);
      debugPrint('--->>?   $data');

      if (data["status"] == "true" && (data["msg"] == "success")) {
        totalCountingResponse =
            TotalCountingResponse.fromJson(jsonDecode(responsed.body));
        total_amount =
            totalCountingResponse!.response![0].totalAmount.toString();
        total_appointments =
            totalCountingResponse!.response![0].totalReviews.toString();
        todays_appointment =
            totalCountingResponse!.response![0].todaysAppointments.toString();
        upcoming_appointment =
            totalCountingResponse!.response![0].upcomingAppointments.toString();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {});
        });

        return totalCountingResponse!;
      }

      return totalCountingResponse!;
    }
    return null;
    /*  request
        .send()
        .then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          debugPrint("Uploaded! ");
          debugPrint('response.body ' + response.body);

          var jsonData = response.body;
          debugPrint(jsonData);
          data = json.decode(response.body);

          var rest1 = data["msg"];
          data = json.decode(response.body);
          debugPrint('--->>?   ${data}');

          if (data["status"] == "true" &&
              (data["msg"] == "success")) {
            totalCountingResponse =
                TotalCountingResponse.fromJson(
                    jsonDecode(response.body));



            return totalCountingResponse!;
          }
        }

        return totalCountingResponse!;
      });
    })
        .catchError((err) => debugPrint('error : ' + err.toString()))
        .whenComplete(() {});*/
    //debugPrint('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }

  HealerProfileFetchData? _healerProfileFetchData;

  Future<HealerProfileFetchData?> getFetchProfileData() async {
    var data;
    try {
      debugPrint(
          'fetched healer id-   ${prefs!.getString(StringUtils.id).toString()}');
      var request =
          http.MultipartRequest('POST', BaseuURL.healerprofile_detail);

      request.fields['healer_id'] =
          prefs!.getString(StringUtils.id).toString() /*'52'*/;
      // var res = await request.send();
      // var res = await request.send();
      var response = await request.send();
      final responsed = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        debugPrint("Uploaded! ");
        debugPrint('response.body ' + responsed.body);
        var jsonData = responsed.body;

        debugPrint(jsonData);
        data = json.decode(responsed.body);

        var rest1 = data["msg"];
        data = json.decode(responsed.body);
        debugPrint('--->>?   $data');

        if (data["status"] == "true" && data["response"] == "success") {
          debugPrint('getFetchProfileData--    ');

          final jsonResponse = json.decode(responsed.body);

          _healerProfileFetchData =
              HealerProfileFetchData.fromJson(jsonResponse);

          debugPrint(
              '_healerProfileFetchData!.expire_status.toString()    ${_healerProfileFetchData!.expire_status.toString()}');
          if (_healerProfileFetchData!.expire_status.toString() == '1') {
            expire_status = 1;
          } else {
            expire_status = 0;
          }
          prefs!.setString(
              StringUtils.name, _healerProfileFetchData!.healerName.toString());

          setState(() {});
        }
      }
    } catch (e) {
      debugPrint('exce --   ${e.toString()}    ');
    }
    return _healerProfileFetchData;
  }
}
