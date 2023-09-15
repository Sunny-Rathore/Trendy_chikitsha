import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:trendy_chikitsa/baseurl/baseURL.dart';

import 'package:trendy_chikitsa/models/client_responses/client_appointment_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_transaction_history_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/submit_review_response.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HealerTransactionList extends StatefulWidget {
  String from_page = "", token = "";

  HealerTransactionList({super.key});

  @override
  HealerTransactionListState createState() =>HealerTransactionListState();

/* TodayAppointment({
    Key? key,
    required this.from_page
  }) : super(key: key);*/
}

class HealerTransactionListState extends State<HealerTransactionList>
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
final TextEditingController _textEditingController= TextEditingController();
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
       /*   drawer: NavDrawer(),*/
          appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: ColorUtils.trendyThemeColor,
            elevation: 0.0,
              automaticallyImplyLeading: true,
            title: Text('Transactions',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: StringUtils.roboto_font_family,
                  color: ColorUtils.whiteColor,
                  fontSize: 18,
                )),
            centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.light,
          /*  leading: GestureDetector(
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
          body: FutureBuilder<HealerTransactionHistoryResponse?>(
            future:getHealerTransactions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print('snapshot--  ${snapshot.error}');
                if ( _healerTransactionHistoryResponse!=null  && _healerTransactionHistoryResponse!.response!.isNotEmpty ) {
                  print('snapshot--  ${snapshot.error}');
                  //   print('value is..  ${new Map<String, dynamic>.from(snapshot.data).}');

                  return ListView.builder(
                      itemCount:_healerTransactionHistoryResponse!.response!.length,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return  SizedBox(
                            height: 32.h,
                            child: Card(
                                child:Padding(
                                    padding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 2.h),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [

                                        Expanded(
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Text("Transaction ID",
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.normal,
                                                                        color:ColorUtils.grayColor,
                                                                        fontSize: 16)),
                                                                SizedBox(
                                                                  width: 40.w,
                                                                  child: Text(
                                                                      _healerTransactionHistoryResponse!.response![index].txnId.toString(),
                                                                      textAlign: TextAlign.left,
                                                                      maxLines: 2,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.normal,
                                                                          color: ColorUtils.blackColor,
                                                                          fontSize: 17)),
                                                                ),

                                                              ]),

                                                          Column(    mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.end,

                                                              children: [  Text("Amount",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.normal,
                                                                      color:ColorUtils.grayColor,
                                                                      fontSize: 16)),
                                                                SizedBox(
                                                                  width: 40.w,
                                                                  child: Text(
                                                                      '\u{20B9} ${_healerTransactionHistoryResponse!.response![index].amount.toString()}',
                                                                      textAlign: TextAlign.right,
                                                                      maxLines: 2,

                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.normal,
                                                                          color: ColorUtils.blackColor,
                                                                          fontSize: 17)),
                                                                ),

                                                              ]),

                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,

                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text("Product Info",
                                                                  textAlign: TextAlign.right,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.normal,
                                                                      color: ColorUtils.grayColor,
                                                                      fontSize: 16)),
                                                              SizedBox(
                                                                  width: 45.w,
                                                                  child: Text(
                                                                      _healerTransactionHistoryResponse!.response![index].productInfo.toString(),
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.normal,
                                                                          color: ColorUtils.blackColor,
                                                                          fontSize: 17))),

                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                            children: [ Text("Date",
                                                                textAlign: TextAlign.right,
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.normal,
                                                                    color: ColorUtils.grayColor,
                                                                    fontSize: 16)),
                                                              SizedBox(
                                                                  width: 40.w,
                                                                  child: Text(
                                                                      changeStringToDate(_healerTransactionHistoryResponse!.response![index].createDate.toString()),
                                                                      textAlign: TextAlign.right,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.normal,
                                                                          color: ColorUtils.blackColor,
                                                                          fontSize: 17))),

                                                            ],
                                                          )
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [  Text("Paid By",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.normal,
                                                                      color:ColorUtils.grayColor,
                                                                      fontSize: 16)),
                                                                SizedBox(
                                                                  width: 40.w,
                                                                  child: Text(_healerTransactionHistoryResponse!.response![index].paid_by.toString().trim().isEmpty || _healerTransactionHistoryResponse!.response![index].paid_by.toString().trim()=='null'?'':
                                                                  _healerTransactionHistoryResponse!.response![index].paid_by.toString(),
                                                                      textAlign: TextAlign.left,
                                                                      maxLines: 2,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.normal,
                                                                          color: ColorUtils.blackColor,
                                                                          fontSize: 17)),
                                                                ),

                                                              ]),

                                                        ],
                                                      ),


                                                    ])))
                                      ],
                                    ))));
                      });
                } else {
                  return SizedBox(
                      height: 500,
                      child: Center(
                        child: Lottie.asset(
                          'assets/images/no_data.json',
                          repeat: true,
                          height: 60.h,
                          width: 50.w,
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
                        height: 40.h,
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

  HealerTransactionHistoryResponse? _healerTransactionHistoryResponse;

  Future<HealerTransactionHistoryResponse?> getHealerTransactions() async {
    var data;
    var request =
        http.MultipartRequest('POST', BaseuURL.transaction_history);

    request.fields['user_id'] =
        prefs!.getString(StringUtils.id).toString()/*'104'*/ ;
    request.fields['type'] = '1' ;
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

        _healerTransactionHistoryResponse =
            HealerTransactionHistoryResponse.fromJson(jsonResponse);
      //  appointmentList = clientAppointmentResponse!.response!;
      } else {
       // appointmentList!.clear();
      }
    }

    return _healerTransactionHistoryResponse;

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
              content:SizedBox(height: 40.h,child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ SizedBox(width:70.w,child:    RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 5,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                    appointmentRating=rating.toString();
                  },
                )),
                  Container(

                      width: 80.w,
                      padding: const EdgeInsets.symmetric(
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
                      child:   TextField(
                    controller:
                   _textEditingController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: ColorUtils
                                .b3Color,
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
                        errorBorder:
                        InputBorder.none,
                        disabledBorder:
                        InputBorder.none,
                        hintText: '  Share your experience here'),
                    onChanged: (text) {
                      setState(() {
                        //you can access nameController in its scope to get
                        // the value of text entered as shown below
                        //UserName = nameController.text;
                      });
                    },
                    onTap: () {

                    },
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
                                        child: Text(
                                            'Submit'.toUpperCase(),
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
                                          submitReview(appointmentId, appointment,_textEditingController.text.toString());
                                        }))),
                          ),
                          onTap: () async {
submitReview(appointmentId, appointment,_textEditingController.text.toString());
                          }))
                ],
              ),)
            );
          },
        );
      },
    );
  }
SubmitReviewResponse? _submitReviewResponse;

  Future<String?> submitReview(String appointmentId, String rating, String comments) async {
    isLoading = true;
    setState(() {});
    var data;
    print(
        'updateScheduleTime   $appointmentId,   $rating,   $comments');
    var request = http.MultipartRequest('POST', BaseuURL.submit_review);

    request.fields['appointment_id'] = appointmentId;
    request.fields['rating'] = rating;

    request.fields['comment'] =comments;


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
              (data["msg"] == "Success! Your review has been submitted successfully.")) {

_submitReviewResponse=    SubmitReviewResponse.fromJson(jsonDecode(response.body));


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
String changeStringToDate(String date){
  DateTime dt = DateTime.parse(date);
  final DateFormat formatter = DateFormat('yMMMd');
  final String formatted = formatter.format(dt);
  print(dt); // 2020-01-02 03:04:05.000
  return formatted;
}