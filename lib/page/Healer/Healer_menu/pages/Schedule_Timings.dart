import 'dart:convert';

 
import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/healer_responses/add_timeslots_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/delete_time_slots_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/schedule_timing_listing_response.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/widget/text_widget_align_center.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
// For changing the language

class Schedule_Timings extends StatefulWidget {
  const Schedule_Timings({Key? key}) : super(key: key);

  @override
  State<Schedule_Timings> createState() => _Schedule_TimingsState();
}

// enum FilterStatus { Upcoming, Complete, Cancel }

class _Schedule_TimingsState extends State<Schedule_Timings> {
  List<String> weekDaysItem = [
    "SUNDAY",
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
    "SATURDAY"
  ];
  List<String> posts = [
    "09:00 am - 01:41 pm",
    "09:00 am - 01:41 pm",
    "09:00 am - 01:41 pm",
    "09:00 am - 01:41 pm",
    "09:00 am - 01:41 pm",
    "09:00 am - 01:41 pm",
    "09:00 am - 01:41 pm"
  ];
  bool isLoading = false, isStartTime = false;
  SharedPreferences? prefs;
  final List<TextEditingController> _controllers = [];
  final List<TextEditingController> _endTimeControllers = [];
  List<ScheduleResponse>? scheduleResponseList = [];
  final DateFormat dates = DateFormat('yyyy-MM-dd HH:mm');
  int _selectedIndex = 0;
  TimeOfDay currentTime = TimeOfDay.now();
  DateTime currentdate = DateTime.now();
  bool _isDateSelected = false;
  bool _isTimeSelected = false;
  List<Widget> widgetList = [];
  String shDay = '1', shID = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {});
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
      // Do something
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorUtils.trendyThemeColor,
            title: const Text('Schedule Timings',
                style: TextStyle(color: Colors.white)),
          ),
          floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add, size: 30, color: ColorUtils.whiteColor),
            backgroundColor: ColorUtils.violetButtonColor,
            onPressed: () {
              /*showAlertDialog(context, '');*/
              showD();
            },
          ),
          body: SingleChildScrollView(
              child: Center(
            child: Column(
              children: [
                SizedBox(
                    height: 8.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weekDaysItem.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                              onTap: () {
                                _selectedIndex = index;
                                shDay = (index + 1).toString();
                                setState(() {});
                              },
                              child: Container(
                                width: 30.w,
                                height: 8.h,
                                margin: EdgeInsets.only(
                                    top: 2.h, left: 1.w, right: 1.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorUtils.lightGreyBorderColor),
                                  color: _selectedIndex == index
                                      ? ColorUtils.loginIconColor
                                      : ColorUtils.whiteColor,
                                ),
                                child: Center(
                                    child: Text(
                                  weekDaysItem[index],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: _selectedIndex == index
                                          ? ColorUtils.whiteColor
                                          : Colors.black),
                                )),
                              ));
                        })),
                Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(
                      'Time Slots',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: StringUtils.roboto_font_family_bold,
                          color: ColorUtils.violetButtonColor),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(3.5.w, 10, 3.5.w, 0),
                  child: FutureBuilder<ScheduleTimeListingResponse?>(
                    future: getScheduleTimeListing(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          print('snapshot--  ${snapshot.error}');
                          scheduleResponseList = snapshot.data!.response;
                          if (scheduleResponseList!.isNotEmpty) {
                            print('snapshot--  ${snapshot.error}');
                            //   print('value is..  ${new Map<String, dynamic>.from(snapshot.data).}');

                            return GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 1,
                              crossAxisSpacing: 5.0,
                              childAspectRatio: (16 / 2),
                              mainAxisSpacing: 10.0,
                              shrinkWrap: true,
                              children: List.generate(
                                (scheduleResponseList!.length),
                                (index) {
                                  return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                          height: 10.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    ColorUtils.appDarkBlueColor,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          child: Center(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 0, 5),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextWidgetAlignCenter(
                                                            '${scheduleResponseList![index].shStart}-${scheduleResponseList![index].shEnd}',
                                                            FontWeight.normal,
                                                            ColorUtils
                                                                .naviBlueTextColor,
                                                            18,
                                                            StringUtils
                                                                .roboto_font_family),
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons
                                                                .delete_rounded,
                                                            color: Colors.red,
                                                            size: 22,
                                                          ),
                                                          onPressed: () {
                                                            shID =
                                                                scheduleResponseList![
                                                                        index]
                                                                    .shId
                                                                    .toString();
                                                            deleteTimeSlotsConfirmationDialog(
                                                                context,
                                                                true,
                                                                0);
                                                          },
                                                        ),
                                                      ])))));
                                },
                              ),
                            );
                          } else {
                            scheduleResponseList!.clear();
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
                          scheduleResponseList!.clear();
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
                    },
                  ),
                )
              ],
              /* ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 14.h,
              margin: EdgeInsets.only(
                  top: 2.h,
                  left: 8.w,
                  right: 8.w),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
                border: Border.all(
                    color: ColorUtils
                        .lightGreyBorderColor),
                color: ColorUtils.whiteColor,
              ),
              child: const Center(child: Text('Item 1', style: TextStyle(fontSize: 18, color: Colors.white),)),
            ),
            Container(
              width: 200,
              color: Colors.purple[500],
              child: const Center(child: Text('Item 2', style: TextStyle(fontSize: 18, color: Colors.white),)),
            ),
            Container(
              width: 200,
              color: Colors.purple[400],
              child: const Center(child: Text('Item 3', style: TextStyle(fontSize: 18, color: Colors.white),)),
            ),
            Container(
              width: 200,
              color: Colors.purple[300],
              child: const Center(child: Text('Item 4', style: TextStyle(fontSize: 18, color: Colors.white),)),
            ),
          ],
        ),*/
            ),
          )));
    });
  }

  Future<void> _selectTime(BuildContext context, int index) async {
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
        if (isStartTime) {
          /*${pickedTime.hour}:${pickedTime.minute}*/
          _controllers[index].text = pickedTime.format(context);
        } else {
          /*${pickedTime.hour}:${pickedTime.minute}*/
          _endTimeControllers[index].text = pickedTime.format(context);
        }
        _isTimeSelected = true;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentdate,
        //initialEntryMode: TimePickerEntryMode.dial,
        helpText: 'Choose Your Date',
        confirmText: 'Choose Now',
        cancelText: 'Later',
        lastDate: DateTime(2040, 12, 31),
        firstDate: currentdate);
    if (pickedDate != null && pickedDate != currentdate) {
      setState(() {
        currentdate = pickedDate;
        _isDateSelected = true;
      });
    }
  }

  String? _selectedTime;

  Future<void> _show() async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      setState(() {
        // _timeController!.text = result.format(context);
        _selectedTime = result.format(context);
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
                child: Text(msg,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                        fontSize: 18))),
          ],
        ),
        content: StatefulBuilder(// You need this, notice the parameters below:
            builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
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
                                    width: 20.w,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 0),
                                    margin: EdgeInsets.only(
                                        top: 2.h, left: 1.w, right: 1.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              ColorUtils.lightGreyBorderColor),
                                      color: ColorUtils.whiteColor,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Flexible(
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: ColorUtils.b3Color,
                                                      fontFamily: StringUtils
                                                          .roboto_font_family_regular,
                                                      fontSize: 17),
                                                  labelStyle: TextStyle(
                                                      color: ColorUtils
                                                          .textFormFieldLabelColor,
                                                      fontFamily: StringUtils
                                                          .roboto_font_family,
                                                      fontSize: 17),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'Enter Password'),
                                              onChanged: (text) {
                                                setState(() {
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ), //flexible
                                        ), //container
                                      ], //widget
                                    )),
                                Container(
                                    height: 7.h,
                                    width: 20.w,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 0),
                                    margin: EdgeInsets.only(
                                        top: 2.h, left: 1.w, right: 1.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              ColorUtils.lightGreyBorderColor),
                                      color: ColorUtils.whiteColor,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Flexible(
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: ColorUtils.b3Color,
                                                      fontFamily: StringUtils
                                                          .roboto_font_family_regular,
                                                      fontSize: 17),
                                                  labelStyle: TextStyle(
                                                      color: ColorUtils
                                                          .textFormFieldLabelColor,
                                                      fontFamily: StringUtils
                                                          .roboto_font_family,
                                                      fontSize: 17),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'Enter Password'),
                                              onChanged: (text) {
                                                setState(() {
                                                  //you can access nameController in its scope to get
                                                  // the value of text entered as shown below
                                                  //UserName = nameController.text;
                                                });
                                              },
                                            ),
                                          ), //flexible
                                        ), //container
                                      ], //widget
                                    )),
                              ],
                            ));
                      })),
              Expanded(
                  child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 3.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('ADD More',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: StringUtils.roboto_font_family,
                                    color: ColorUtils.appDarkBlueColor,
                                    fontSize: 17,
                                  )))))),
            ],
          );
        }));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  int value = 0;
  showD() {
    return showDialog(
      context: context,
      builder: (context) {
        _controllers.clear();
        _endTimeControllers.clear();
        value = 0;
        for (int i = 0; i < scheduleResponseList!.length; i++) {
          _controllers.add(TextEditingController());
          _controllers[i].text = scheduleResponseList![i].shStart.toString();
          _endTimeControllers.add(TextEditingController());
          _endTimeControllers[i].text =
              scheduleResponseList![i].shEnd.toString();

          value = value + 1;
          if (i == scheduleResponseList!.length - 1) {
            _controllers.add(TextEditingController());
            _endTimeControllers.add(TextEditingController());
          }
        }
        if (scheduleResponseList!.isEmpty) {
          value = 1;
          print('is it coming in case of 0');
          _controllers.add(TextEditingController());
          _endTimeControllers.add(TextEditingController());
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Time Slots"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 30.h,
                      child: ListView.builder(
                          // shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: value,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return InkWell(
                                onTap: () {
                                  _selectedIndex = index;
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 7.h,
                                        width: 25.w,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        margin: EdgeInsets.only(
                                            top: 2.h, left: 0.w, right: 0.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: ColorUtils
                                                  .lightGreyBorderColor),
                                          color: ColorUtils.whiteColor,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Flexible(
                                                child: TextField(
                                                  controller:
                                                      _controllers[index],
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
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
                                                    isStartTime = true;
                                                    _selectTime(context, index);
                                                  },
                                                ),
                                              ), //flexible
                                            ), //container
                                          ], //widget
                                        )),
                                    Container(
                                        height: 7.h,
                                        width: 25.w,
                                        padding: const EdgeInsets.symmetric(
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
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Flexible(
                                                child: TextField(
                                                  controller:
                                                      _endTimeControllers[
                                                          index],
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
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
                                                    isStartTime = false;
                                                    _selectTime(context, index);
                                                  },
                                                ),
                                              ), //flexible
                                            ), //container
                                            /*     IconButton(
                                              icon: Icon(
                                                Icons
                                                    .delete_rounded,
                                                color: Colors.red,
                                                size: 22,
                                              ),
                                              onPressed: () {
                                                shID =
                                                    scheduleResponseList![
                                                    index]
                                                        .shId
                                                        .toString();
                                                deleteTimeSlotsConfirmationDialog(
                                                    context);
                                              },
                                            ),*/
                                          ], //widget
                                        )),
                                    Visibility(
                                      visible: index > 0 ||
                                          scheduleResponseList!.isNotEmpty,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete_rounded,
                                          color: Colors.red,
                                          size: 23,
                                        ),
                                        onPressed: () {
                                          if (scheduleResponseList!.length <=
                                                  index ||
                                              scheduleResponseList == null) {
                                            _controllers.removeAt(index);
                                            _endTimeControllers.removeAt(index);
                                            value = value - 1;
                                            setState(() {});
                                            //  Navigator.pop(context, true);
                                          } else {
                                            shID = scheduleResponseList![index]
                                                .shId
                                                .toString();
                                            deleteTimeSlotsFromPopup(index);
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              setState(() {});
                                              // Do something
                                            });
                                          }
                                          /*  deleteTimeSlotsConfirmationDialog(
                                            context, false, index);*/
                                        },
                                      ),
                                    )
                                  ],
                                ));
                          })),
                  Expanded(
                      child: SizedBox(
                          height: 7.h,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  value = value + 1;
                                  _controllers.add(TextEditingController());
                                  _endTimeControllers
                                      .add(TextEditingController());
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
                                            fontFamily: StringUtils
                                                .roboto_font_family_bold,
                                            color: ColorUtils.appDarkBlueColor,
                                            fontSize: 18,
                                          ))))))),
                  Flexible(
                      child: SizedBox(
                          height: 8.h,
                          child: InkWell(
                              child: SizedBox(
                                height: 8.h,
                                child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(8.w, 2.h, 8.w, 0),
                                    child: SizedBox(
                                        width: 100.h,
                                        height: 7.h,
                                        child: ElevatedButton(
                                            child: Text(
                                                'Save Changes'.toUpperCase(),
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
                                                    MaterialStateProperty.all<Color>(ColorUtils
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
                                              if (shDay == '0') {
                                                showSnackBar(context,
                                                    'Please select a week day');
                                                Navigator.pop(context, true);
                                              } else if (_controllers.length !=
                                                  _endTimeControllers.length) {
                                                showSnackBar(context,
                                                    'Please select start time and end time correctly.');
                                                Navigator.pop(context, true);
                                              } else {
                                                updateScheduleTime();
                                              }
                                            }))),
                              ),
                              onTap: () async {
                                updateScheduleTime();
                              }))),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // void showDatePicker1(int index) {
  //   DatePicker.showDatePicker(context,
  //       showTitleActions: true, minTime: DateTime(1901, 3, 5),

  //       /*  maxTime: DateTime.now(),*/
  //       onChanged: (date) {
  //     print('change $date');
  //   }, onConfirm: (date) {
  //     setState(() {
  //       if (date.month > 0 && date.month < 10) {
  //         _controllers[index].text = '${date.year}-0${date.month}-${date.day}';
  //       } else {
  //         _controllers[index].text = '${date.year}-${date.month}-${date.day}';
  //       }
  //     });
  //     print('confirm $date');
  //   }, currentTime: DateTime.now(), locale: LocaleType.en);
  // }//!-----by me----

  Future<String?> updateScheduleTime() async {
    isLoading = true;
    setState(() {});
    var data;
    print(
        'updateScheduleTime   ${prefs!.getString(StringUtils.id).toString()}');
    var request = http.MultipartRequest('POST', BaseuURL.addTimeSlot);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['sh_day'] = shDay;

    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.toString().trim().isNotEmpty &&
          _endTimeControllers[i].text.toString().trim().isNotEmpty) {
        request.fields['start_time[$i]'] =
            _controllers[i].text.toString().trim();
        print('start_time[$i]---   ${_controllers[i].text.toString().trim()}');
      }
    }
    for (int j = 0; j < _endTimeControllers.length; j++) {
      if (_controllers[j].text.toString().trim().isNotEmpty &&
          _endTimeControllers[j].text.toString().trim().isNotEmpty) {
        request.fields['end_time[$j]'] =
            _endTimeControllers[j].text.toString().trim();
        print(
            'end_time[$j]---   ${_endTimeControllers[j].text.toString().trim()}');
      }
    }

/*    request.fields['h_facebook_link'] = _fbController.text.toString().trim();
    request.fields['h_twitter_link'] =
        _twitterController.text.toString().trim();
    request.fields['h_instagram_link'] =
        _instagramController.text.toString().trim();
    request.fields['h_pinterest_link'] =
        _pinterestController.text.toString().trim();
    request.fields['h_linkedin_link'] =
        _linkedinController.text.toString().trim();
    request.fields['h_youtube_link'] =
        _youtubeController.text.toString().trim();*/

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

              if (data["status"] == "true" &&
                  (data["msg"] == "Success!  Added successfully.")) {
                AddTimeSlotsResponse submitSocialMediaResponse =
                    AddTimeSlotsResponse.fromJson(jsonDecode(response.body));
                Navigator.pop(context, true);
                showSnackBar(context, data["msg"]);

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

/*  Future<List<ScheduleResponse>?> getScheduleTimeListing() async {
    isLoading = true;
    setState(() {});
    var data;
    print(
        'getScheduleTimeListing   ${prefs!.getString(StringUtils.id)
            .toString()}');
    var request = http.MultipartRequest('POST', BaseuURL.addTimeSlot);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['sh_day'] = shDay;

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
              (data["msg"] == "success")) {
            ScheduleTimeListingResponse scheduleTimeListingResponse =
            ScheduleTimeListingResponse.fromJson(jsonDecode(response.body));

            showSnackBar(context, data["msg"]);
          }
        }

        return response.body;
      });
    })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    //print('reason phrase- ${res.stream.bytesToString()}');
    // return res.stream.bytesToString();
  }*/

  Future<ScheduleTimeListingResponse?> getScheduleTimeListing() async {
    var data;

    print('pppp---  $shDay');
    ScheduleTimeListingResponse? scheduleTimeListingResponse;
    var request = http.MultipartRequest('POST', BaseuURL.scheduleTimeListing);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['day'] = shDay;

    // var res = await request.send();
    var response = await request.send();
    final responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      print("Uploaded! ");
      print('response.body ' + responsed.body);

      var jsonData = responsed.body;
      print(jsonData);
      data = json.decode(responsed.body);

      data = json.decode(responsed.body);
      print('--->>?   $data');

      if (data["status"] == "true" && (data["msg"] == "success")) {
        scheduleTimeListingResponse =
            ScheduleTimeListingResponse.fromJson(jsonDecode(responsed.body));

        //   showSnackBar(context, data["msg"]);
      } else if (data["status"] == "false") {
        // showSnackBar(context, data["msg"]);
      }
    }
    return scheduleTimeListingResponse;
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

  deleteTimeSlotsConfirmationDialog(
      BuildContext context, bool isDirect, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Not Now",
          style: TextStyle(
            fontFamily: StringUtils.roboto_font_family_bold,
            color: Colors.red,
            fontSize: 17,
          )),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes",
          style: TextStyle(
            fontFamily: StringUtils.roboto_font_family_bold,
            color: Colors.green,
            fontSize: 17,
          )),
      onPressed: () {
        print(
            'is direct--    $isDirect ,   ${scheduleResponseList!.length},    $index');
        if (isDirect == true) {
          deleteTimeSlots();
        } else {
          if (scheduleResponseList!.length <= index ||
              scheduleResponseList == null) {
            _controllers.removeAt(index);
            _endTimeControllers.removeAt(index);
            value = value - 1;
            setState(() {});
            Navigator.pop(context, true);
          } else {
            shID = scheduleResponseList![index].shId.toString();
            deleteTimeSlotsFromPopup(index);
          }
        }

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {});
          // Do something
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure, you want to delete this slot?",
          style: TextStyle(
            /* fontFamily: StringUtils
            .roboto_font_family,*/
            color: ColorUtils.appDarkBlueColor,
            fontSize: 17,
          )),
      content: const Text(""),
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

  Future<DeletedTimeSlotsResponse?> deleteTimeSlotsFromPopup(int index) async {
    var data;
    DeletedTimeSlotsResponse? deletedTimeSlotsResponse;
    var request = http.MultipartRequest('POST', BaseuURL.delete_time_slot);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['sh_id'] = shID;

    // var res = await request.send();
    var response = await request.send();
    final responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      print("Uploaded! ");
      print('response.body ' + responsed.body);

      var jsonData = responsed.body;
      print(jsonData);
      data = json.decode(responsed.body);

      data = json.decode(responsed.body);
      print('--->>?   $data');

      if (data["status"] == "true" && (data["msg"] == "success")) {
        deletedTimeSlotsResponse =
            DeletedTimeSlotsResponse.fromJson(jsonDecode(responsed.body));

        _controllers.removeAt(index);
        _endTimeControllers.removeAt(index);
        value = value - 1;
        showSnackBar(context, data["response"]);
      } else if (data["status"] == "false") {
        Navigator.pop(context, true);
        showSnackBar(context, data["response"]);
      }
    }
    return deletedTimeSlotsResponse;
  }

  Future<DeletedTimeSlotsResponse?> deleteTimeSlots() async {
    var data;
    DeletedTimeSlotsResponse? deletedTimeSlotsResponse;
    var request = http.MultipartRequest('POST', BaseuURL.delete_time_slot);

    request.fields['healer_id'] = prefs!.getString(StringUtils.id).toString();
    request.fields['sh_id'] = shID;

    // var res = await request.send();
    var response = await request.send();
    final responsed = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      print("Uploaded! ");
      print('response.body ' + responsed.body);

      var jsonData = responsed.body;
      print(jsonData);
      data = json.decode(responsed.body);

      data = json.decode(responsed.body);
      print('--->>?   $data');

      if (data["status"] == "true" && (data["msg"] == "success")) {
        deletedTimeSlotsResponse =
            DeletedTimeSlotsResponse.fromJson(jsonDecode(responsed.body));
        Navigator.pop(context, true);
        showSnackBar(context, data["response"]);
      } else if (data["status"] == "false") {
        Navigator.pop(context, true);
        showSnackBar(context, data["response"]);
      }
    }
    return deletedTimeSlotsResponse;
  }
}
