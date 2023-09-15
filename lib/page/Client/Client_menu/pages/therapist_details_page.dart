import 'dart:convert';

import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/all_therapy_response.dart';
import 'package:trendy_chikitsa/models/healer_profile_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/book_appointment_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_therapy_pricing_response.dart';
import 'package:trendy_chikitsa/page/Client/Client_menu/pages/clients_appointments.dart';
import 'package:trendy_chikitsa/page/Client/client_navigation.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/utils/utils_methods.dart';
import 'package:trendy_chikitsa/widget/text_widget.dart';
import 'package:trendy_chikitsa/widget/text_widget_align_center.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class TherapyDetailsPage extends StatefulWidget {
  String? healerId, therapyCategory;

  @override
  TherapyDetailsstate createState() => TherapyDetailsstate();

  TherapyDetailsPage({
    Key? key,
    required this.healerId,
    required this.therapyCategory,
  }) : super(key: key);
}

class TherapyDetailsstate extends State<TherapyDetailsPage> {
  Color gridItemColor = const Color(0xffE6E6E6);
  List<int> selectedIndexList1 = <int>[];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TherapyList> therapyList = [];
  String selected_timeslot = "",
      initialdate = "",
      selectedInitialDate = "",
      appToken = "",
      therapyName = '',
      pricing = '',
      slotID = '';
  HealerProfileResponse? healerProfileResponse;
  DateTime selectedDate = DateTime.now();
  SharedPreferences? preferences;
  HealerTherapyPricingResponse? healerTherapyPricingResponse;
  bool currentDate = true, isLoading = false;
  String share_link = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM d, yyyy');
    /*  final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
*/

    final DateFormat formatter1 = DateFormat('yyyy-MM-dd');

    selectedInitialDate = formatter1.format(now);
    print('++++     $selectedInitialDate');
    final String formatted = formatter.format(now);
    initialdate = formatted;
    print(
        'time format ---  ${DateFormat.jm().format(DateTime.now()).toString()}');
    saveValue();
  }

  saveValue() async {
    preferences = await SharedPreferences.getInstance();
    getHealerTherapyPricing();
    Future.delayed(const Duration(seconds: 2), () {
      // setState(() {});
      // Do something
    });
    //  getVideoThumbnail('');
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorUtils.whiteColor,
        drawer: NavDrawer(),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          elevation: 5,
          backgroundColor: ColorUtils.trendyThemeColor,
          title: Text(
            widget.therapyCategory.toString(),
            style: TextStyle(
              fontFamily: StringUtils.roboto_font_family,
              color: ColorUtils.whiteColor,
              letterSpacing: 0.15,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: Stack(children: [
          SingleChildScrollView(
              child: Center(
                  child: FutureBuilder(
                      future: getHealerProfile(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const Text('')
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 18, 20, 66),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 90,
                                      backgroundImage: NetworkImage(
                                          healerProfileResponse != null
                                              ? healerProfileResponse!
                                                  .healerProfile
                                                  .toString()
                                              : "https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextWidget(
                                        healerProfileResponse != null
                                            ? healerProfileResponse!.healerName
                                                .toString()
                                            : '---',
                                        FontWeight.bold,
                                        Colors.black,
                                        24,
                                        StringUtils.roboto_font_family),
                                    TextWidget(
                                        healerProfileResponse != null
                                            ? healerProfileResponse!.therapyName
                                                .toString()
                                            : '---',
                                        FontWeight.normal,
                                        Colors.black,
                                        19,
                                        StringUtils.roboto_font_family),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 1.h, bottom: 10),
                                      child: Container(
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              healerProfileResponse != null
                                                  ? healerProfileResponse!
                                                      .experience
                                                      .toString()
                                                  : '---',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: const Color(0xff000000),
                                                fontWeight: FontWeight.normal,
                                                fontFamily: StringUtils
                                                    .roboto_font_family,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color:
                                                  ColorUtils.trendyButtonColor,
                                            ),
                                            child: Card(
                                                elevation: 0,
                                                color: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(7, 5, 7, 5),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            initialdate,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          SvgPicture.asset(
                                                              'assets/images/ic_date_range.svg',
                                                              color: ColorUtils
                                                                  .whiteColor,
                                                              semanticsLabel:
                                                                  'A red up arrow'),
                                                        ]))))),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: TextWidget(
                                            
                                            '\nProposed Slots',
                                            FontWeight.normal,
                                            ColorUtils.headerTextColor,
                                            18,
                                            StringUtils.roboto_font_family)),
                                    healerProfileResponse!.slots!.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: GridView.count(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 15.0,
                                              childAspectRatio: (16 / 5),
                                              mainAxisSpacing: 15.0,
                                              shrinkWrap: true,
                                              children: List.generate(
                                                healerProfileResponse!
                                                    .slots!.length,
                                                (index) {
                                                  return GestureDetector(
                                                      onTap: () {
                                                        if (!selectedIndexList1
                                                            .contains(index)) {
                                                          selectedIndexList1
                                                              .clear();
                                                          selectedIndexList1
                                                              .add(index);
                                                          slotID =
                                                              healerProfileResponse!
                                                                  .slots![index]
                                                                  .slotId
                                                                  .toString();
                                                        } else {
                                                          selectedIndexList1
                                                              .remove(index);
                                                        }
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: selectedIndexList1
                                                                          .contains(
                                                                              index)
                                                                      ? ColorUtils
                                                                          .trendyThemeColor
                                                                      : ColorUtils
                                                                          .whiteColor,
                                                                  border: Border
                                                                      .all(
                                                                    color: selectedIndexList1.contains(
                                                                            index)
                                                                        ? ColorUtils
                                                                            .trendyThemeColor
                                                                        : ColorUtils
                                                                            .darkGreyTextColor,
                                                                  ),
                                                                  borderRadius: const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          5))),
                                                          child: Center(
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          2,
                                                                          0,
                                                                          2,
                                                                          0),
                                                                  child: TextWidgetAlignCenter(
                                                                      healerProfileResponse != null ? healerProfileResponse!.slots![index].slot.toString() : '',
                                                                      FontWeight.normal,
                                                                      selectedIndexList1.contains(index) ? ColorUtils.whiteColor : ColorUtils.trendyThemeColor
                                                                      /*.withOpacity(
                                                                  0.5)*/
                                                                      ,
                                                                      15,
                                                                      StringUtils.roboto_font_family)))));
                                                },
                                              ),
                                            ))
                                        : TextWidgetAlignCenter(
                                            '\n \n Slots not available',
                                            FontWeight.normal,
                                            ColorUtils.naviBlueTextColor
                                            /*.withOpacity(
                                                                  0.5)*/
                                            ,
                                            20,
                                            StringUtils
                                                .roboto_font_family_bold),
                                  ],
                                ));
                      }))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
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
                                  healerProfileResponse != null && healerProfileResponse!.slots!.isNotEmpty
                                      ? ColorUtils.trendyButtonColor
                                      : ColorUtils.trendyButtonColor
                                          .withOpacity(0.5)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  healerProfileResponse != null && healerProfileResponse!.slots!.isNotEmpty
                                      ? ColorUtils.trendyButtonColor
                                      : ColorUtils.trendyButtonColor
                                          .withOpacity(0.5)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: healerProfileResponse != null && healerProfileResponse!.slots!.isNotEmpty ? ColorUtils.trendyButtonColor : ColorUtils.trendyButtonColor.withOpacity(0.5))))),
                          onPressed: () {
                            /*  deleteTimeSlotsConfirmationDialog(context);*/
                            SpinKitFadingCircleWidget(true);
                            if (healerProfileResponse != null &&
                                healerProfileResponse!.slots!.isNotEmpty) {
                              if (slotID.trim() == "") {
                                UtilMethods.showErrorAlertDialog(context,
                                    "Please select any appointment time.");
                                SpinKitFadingCircleWidget(false);
                              } 
                              else {
                                SpinKitFadingCircleWidget(false);
                                deleteTimeSlotsConfirmationDialog(context);
                              }
                            } else {
                              showSnackBar(context, "Bookings not available.");
                            }
                          })))),
          SpinKitFadingCircleWidget(isLoading)
        ]),
      ));
    });
  }

  static _makingPhoneCall() async {
    const url = 'tel:8890879707';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorUtils.appDarkBlueColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black87, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorUtils.headerTextColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        var temp = DateTime.now().toUtc();
        var d1 = DateTime.utc(temp.year, temp.month, temp.day);
        var d2 = DateTime.utc(selected.year, selected.month,
            selected.day); //you can add today's date here
        if (d2.compareTo(d1) == 0) {
          currentDate = true;
          print('true');
        } else {
          currentDate = false;
          print('false');
        }

        selectedDate = selected;
        print('selected date--   $selectedDate');
        final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
        final String formatted1 = formatter1.format(selected);

        selectedInitialDate = selectedDate.toString().substring(0, 10);
        print('selected initial date---   $selectedInitialDate');
        final DateFormat formatter = DateFormat('MMMM d, yyyy');
        final String formatted = formatter.format(selectedDate);
        initialdate = formatted;
        /*   initialdate=selectedDate.toString();*/
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {});
        });
      });
    }
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    print(
        'time conversion---    ${TimeOfDay.fromDateTime(format.parse(tod)).hour},  ${TimeOfDay.fromDateTime(format.parse(tod)).minute}');
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  Future<HealerProfileResponse?> getHealerProfile() async {
    var data;
    print("selectedInitialDate   $selectedInitialDate ");
    var request = http.MultipartRequest('POST', BaseuURL.healerProfile);
    // var request =await http.MultipartRequest('POST', Uri.parse(
    // 'https://www.techtradedu.com/conceptlive/api/online_class'));
    request.fields['healer_id'] = widget.healerId.toString() /*'43'*/;

    request.fields['date'] = selectedInitialDate;

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

        healerProfileResponse = HealerProfileResponse.fromJson(jsonResponse);

        return healerProfileResponse;
      } else {
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        healerProfileResponse = HealerProfileResponse.fromJson(jsonResponse);

        return healerProfileResponse;
      }
    }
    return null;
  }

  String _selectedBookingType = '';

  deleteTimeSlotsConfirmationDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Close",
          style: TextStyle(
            fontFamily: StringUtils.roboto_font_family_bold,
            color: Colors.red,
            fontSize: 19,
          )),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Submit",
          style: TextStyle(
            fontFamily: StringUtils.roboto_font_family_bold,
            color: Colors.green,
            fontSize: 19,
          )),
      onPressed: () {
        if (_selectedBookingType == '') {
          UtilMethods.showErrorAlertDialog(
              context, "Please choose booking type.");
        } else {
          Navigator.pop(context, true);
          if (healerTherapyPricingResponse != null) {
            therapyPricingDialog(context);
          } else {
            UtilMethods.showErrorAlertDialog(
                context, "Price not available for this therapy");
          }
        }

        /* Future.delayed(Duration(seconds: 2), () {
          setState(() {});
          // Do something
        });*/
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: StatefulBuilder(// You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
        return Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Booking Type')),
                ListTile(
                  leading: Radio<String>(
                    value: 'online',
                    groupValue: _selectedBookingType,
                    onChanged: (value) {
                      setState(() {
                        _selectedBookingType = value!;
                      });
                    },
                  ),
                  title: const Text('Book online session with the Healer.'),
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'visit',
                    groupValue: _selectedBookingType,
                    onChanged: (value) {
                      setState(() {
                        _selectedBookingType = value!;
                      });
                    },
                  ),
                  title: const Text('Book personal visit with the Healer.'),
                ),
              ],
            ));
      }),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  therapyPricingDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Close",
          style: TextStyle(
            fontFamily: StringUtils.roboto_font_family_bold,
            color: Colors.red,
            fontSize: 19,
          )),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Book",
          style: TextStyle(
            fontFamily: StringUtils.roboto_font_family_bold,
            color: Colors.green,
            fontSize: 20,
          )),
      onPressed: () {
        isLoading = true;
        setState(() {});
        Navigator.pop(context, true);
        bookAnAppointment();
        /*     Future.delayed(Duration(seconds: 2), () {
          setState(() {});
          // Do something
        });*/
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('Booking Price')),
              ListTile(
                minLeadingWidth: 5.w,
                leading: Text("Therapy",
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.blackColor,
                      fontSize: 16,
                    )),
                title: Text(
                    healerTherapyPricingResponse != null
                        ? healerTherapyPricingResponse!.response![0].therapyName
                            .toString()
                        : 'Not found',
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.blackColor,
                      fontSize: 16,
                    )),
              ),
              ListTile(
                minLeadingWidth: 5.w,
                leading: Text("Price ",
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.blackColor,
                      fontSize: 16,
                    )),
                title: Text(
                    healerTherapyPricingResponse != null
                        ? '\u{20B9}${healerTherapyPricingResponse!.response![0].customPrice.toString()}'
                        : 'Price not found',
                    style: TextStyle(
                      fontFamily: StringUtils.roboto_font_family,
                      color: ColorUtils.blackColor,
                      fontSize: 16,
                    )),
              ),
            ],
          )),
      actions: [
        /*     cancelButton,*/
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<HealerTherapyPricingResponse?> getHealerTherapyPricing() async {
    var data;

    var request =
        http.MultipartRequest('POST', BaseuURL.healer_therapy_pricing);
    // var request =await http.MultipartRequest('POST', Uri.parse(
    // 'https://www.techtradedu.com/conceptlive/api/online_class'));
    request.fields['healer_id'] = widget.healerId.toString() /*'43'*/;

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
        print('yes pricing is there---    ');

        final jsonResponse = json.decode(responsed.body);

        healerTherapyPricingResponse =
            HealerTherapyPricingResponse.fromJson(jsonResponse);

        return healerTherapyPricingResponse;
      } else {
        print('No pricing--   ${widget.healerId.toString()} ');

        final jsonResponse = json.decode(responsed.body);
        healerTherapyPricingResponse = null;
        /* healerTherapyPricingResponse =
            new HealerTherapyPricingResponse.fromJson(jsonResponse);*/

        return healerTherapyPricingResponse;
      }
    }
    return null;
  }

  Future<BookAppointmentResponse?> bookAnAppointment() async {
    var data;
    BookAppointmentResponse? bookAppointmentResponse;
    var request = http.MultipartRequest('POST', BaseuURL.book_appointment);
    // var request =await http.MultipartRequest('POST', Uri.parse(
    // 'https://www.techtradedu.com/conceptlive/api/online_class'));
    request.fields['client_id'] =
        preferences!.getString(StringUtils.id).toString();
    request.fields['appoint_date'] = selectedInitialDate /*'43'*/;
    request.fields['slot_id'] = slotID /*'43'*/;
    request.fields['price_id'] =
        healerTherapyPricingResponse!.response![0].thId.toString() /*'43'*/;
    request.fields['healer_id'] = widget.healerId.toString() /*'43'*/;
    request.fields['appoint_type'] = _selectedBookingType /*'43'*/;

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

      if (data["status"] == "true" &&
          data["msg"] ==
              "Success! Your appointment has been booked successfully.") {
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);

        bookAppointmentResponse =
            BookAppointmentResponse.fromJson(jsonResponse);
        showSnackBar(context, bookAppointmentResponse.msg.toString());
        Future.delayed(const Duration(seconds: 1), () {
          isLoading = false;
          setState(() {});
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ClientAppointments()));
        });
        return bookAppointmentResponse;
      } else {
        print('Login succssfull---    ');

        final jsonResponse = json.decode(responsed.body);
        showSnackBar(context, data["msg"]);
        bookAppointmentResponse =
            BookAppointmentResponse.fromJson(jsonResponse);
        Future.delayed(const Duration(seconds: 1), () {
          isLoading = false;
          setState(() {});
        });
        return bookAppointmentResponse;
      }
    }
    return null;
  }

  showSnackBar(
    BuildContext context,
    String msg,
  ) {
    final snackBar = SnackBar(
      content: Text(msg),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
