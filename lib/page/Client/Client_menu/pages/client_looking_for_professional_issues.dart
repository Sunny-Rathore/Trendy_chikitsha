import 'dart:convert';

import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/healer_responses/submit_profession_type_response.dart';
import 'package:trendy_chikitsa/models/looking_for_issues_models/lookin_for_issues_model_a.dart';
import 'package:trendy_chikitsa/page/Healer/Healer%20Register/Healer_Register.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/utils/utils_methods.dart';
import 'package:trendy_chikitsa/widget/text_widget.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:gender_picker/source/enums.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ClientLookingForProfessionalIssues extends StatefulWidget {
  const ClientLookingForProfessionalIssues({Key? key}) : super(key: key);

  @override
  State<ClientLookingForProfessionalIssues> createState() =>
      ClientLookingForProfessionalIssuesState();
}

class ClientLookingForProfessionalIssuesState
    extends State<ClientLookingForProfessionalIssues> {
  final int _value = 1;

  String? dropdownvalue;
  var items = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  /*List<TherapyList> therapyList = [];*/
  SharedPreferences? prefs;
  late PickedFile? _imageFile;

  List<PickedFile> certificateImageList = [];
  final ImagePicker _picker = ImagePicker();
  late Gender _gender;
  final List<String> _animals = [];
  List<String> selectedIssuesList = [];
  List<IssuesLookingFor> selectedContacts = [];
  List<IssuesLookingFor> contacts = [];
  List<String> therapyList = [
    'I am a Student',
    'I am a Teacher',
    'I am a professional',
    'I am a business owner',
    'I am in the entertainment industry',
    'I am in Sports',
    'I am between job',
    'I am a Homemaker',
    'I am in recruitment services',
    'None of the above'
  ];

  final List<String> _studentIssues = [
    'I want to move ahead in my field',
    'I feel I have chosen a wrong career',
    'I was passed over for a promotion',
    'I don’t get due credit',
    'I have difficulty concentrating',
    'I cannot relax',
    'I am under stress',
    'I am depressed',
    'I am having difficulty sleeping',
    'Low productivity',
    'Others',
    'I am simply checking out the website'
  ];

  final List<String> _teacherIssues = [
    'I am having a hard time connecting with my students',
    'I teach special need classes and I am looking for therapies that might help us',
    'I am under stress',
    'I am depressed',
    'I am having difficulty sleeping',
    'I was passed over for a promotion',
    'Low productivity',
    'Others',
    'I am simply checking out the website'
  ];
  final List<String> _professionalIssues = [
    'I want to move ahead in my field',
    'I feel I have chosen a wrong career',
    'I was passed over for a promotion',
    'I don’t get due credit',
    'I have difficulty concentrating',
    'I cannot relax',
    'I am under stress',
    'I am depressed',
    'I am having difficulty sleeping',
    'Low productivity',
    'Others',
    'I am simply checking out the website'
  ];
  final List<String> _businessIssues = [
    'I want to expand my business',
    'My business is not doing so well',
    'I have difficulty concentrating',
    'I cannot relax',
    'I am under stress',
    'I am depressed',
    'I am having difficulty sleeping',
    'Low productivity',
    'Others',
    'I am simply checking out the website'
  ];

  final List<String> _entertainmentIssues = [
    'I want to make a name for myself',
    'My career is not going the way I had hoped',
    'I don’t get due credit',
    'I cannot relax',
    'I am under stress',
    'I am depressed',
    'I am having difficulty sleeping',
    'Low productivity',
    'Others',
    'I am simply checking out the website'
  ];

  final List<String> _sportsIssues = [
    'I want to excel',
    'My career is not going the way I had hoped',
    'I don’t get due credit',
    'I cannot relax',
    'I am under stress',
    'I am depressed',
    'I am having difficulty sleeping',
    'Others',
    'I am simply checking out the website'
  ];

  final List<String> _jobIssues = [
    'I quit my job voluntarily but I am having second thoughts',
    'I need to change my field',
    'I was fired and need to know if this career is at all right for me',
    'I want to know what kind of jobs are best suited for me',
    'My career is not going the way I had hoped',
    'I cannot relax',
    'I am under stress',
    'I am depressed',
    'I am having difficulty sleeping',
    'Others',
    'I am simply checking out the website'
  ];
  final List<String> _homeMakerIssues = [
    'I am having family issues',
    'I have relationship issues',
    'Child counseling',
    'I have strange dreams/nightmares and would like to understand why',
    'Marriage counseling',
    'Alliance match',
    'Starting a new career',
    'Others',
    'I am simply checking out the website'
  ];

  final List<String> _recruitmentIssues = [
    'I want to ensure optimum hiring',
    'I want to ensure optimum placement of existing staff',
    'I want to conduct a healing session for my staff',
    'Corporate issues',
    'I am simply checking out the website'
  ];

  final List<String> _noneIssues = [
    'Academic issues',
    'Professional issues',
    'Career issues',
    'Depression/Stress/Anxiety/Difficulty in sleeping',
    'Other health issues',
    'Injury',
    'Sneak peek at the future',
    'Relationship issues',
    'Family issues',
    'Marriage issues',
    'Alliance match',
    'Child issues',
    'Dreams/nightmares',
    'Business related issues',
    'Loss of a loved one',
    'Optimum hiring of staff',
    'Others',
    'I am simply checking out the website'
  ];

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = true.obs;
  bool isLoading = false;
  List<List<String>> multiSelectIssueList = [];
  String? selectedSpinnerItem,
      selectedSpinnerItem1,
      selectedTherapyName,
      selectedTherapyIssues,
      selectedTherapyIssues1,
      selectedStateItem,
      expInYear,
      expInMonths,
      cityId = "",
      image_url = 'https://source.unsplash.com/user/c_v_r',
      selectedIssues;
  var stringList;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    //  saveValue();

    super.initState();
    saveValue();
  }

  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    // getTherapies();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
      // Do something
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: ColorUtils.trendyThemeColor,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          title: Text('SELECT PROFESSION',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: StringUtils.roboto_font_family,
                color: ColorUtils.whiteColor,
                fontSize: 18,
              )),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
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
        body: Stack(children: [
          Padding(
              padding:
                  EdgeInsets.only(left: 0, right: 0, top: 10.h, bottom: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/app_logo.png',
                      width: 70.w,
                      height: 20.h,
                    ),
                    SizedBox(
                        height: 2.h,
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 10.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Select issue type',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                          StringUtils.roboto_font_family,
                                      color: ColorUtils.blackColor,
                                      fontSize: 16,
                                    ))))),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 15),
                      margin:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: ColorUtils.greyColor.withOpacity(.4),
                        ),
                        color: ColorUtils.whiteColor,
                      ),
                      height: 6.h,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        // Initial Value
                        isExpanded: true,
                        value: selectedTherapyName,
                        hint: Container(
                          child: const Text('Select issue type'),
                        ),
                        // Down Arrow Icon
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorUtils.greyColor,
                          size: 30,
                        ),

                        items: therapyList.map((item) {
                          return DropdownMenuItem(
                            child: SizedBox(
                                width: 50.w,
                                child: Text(item.toString(),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 15))),
                            value: item.toString(),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            /*     for (var i = 0;
                                    i < therapyList!.length;
                                    i++) {
                                      if (newValue ==
                                          therapyList![i].therapy_name) {
                                        selectedTherapyName = therapyList![i].therapy_name;

                                      }
                                    }*/
                            selectedTherapyName = newValue.toString();
                            multiSelectIssueList.clear();
                            selectedContacts.clear();
                            setState(() {});
                            print(
                                'check vles--   ${selectedTherapyName!.toString().trim()}');
                            //selectedTherapyName = newValue.toString();
                            if (selectedTherapyName!.toString().trim() ==
                                'I am a Student') {
                              contacts.clear();
                              for (int i = 0; i < _studentIssues.length; i++) {
                                contacts.add(
                                    IssuesLookingFor(_studentIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'I am a Teacher') {
                              contacts.clear();
                              for (int i = 0; i < _teacherIssues.length; i++) {
                                contacts.add(
                                    IssuesLookingFor(_teacherIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'I am a professional') {
                              contacts.clear();
                              for (int i = 0;
                                  i < _professionalIssues.length;
                                  i++) {
                                contacts.add(IssuesLookingFor(
                                    _professionalIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'I am a business owner') {
                              contacts.clear();
                              for (int i = 0; i < _businessIssues.length; i++) {
                                contacts.add(IssuesLookingFor(
                                    _businessIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'I am in the entertainment industry') {
                              contacts.clear();
                              for (int i = 0;
                                  i < _entertainmentIssues.length;
                                  i++) {
                                contacts.add(IssuesLookingFor(
                                    _entertainmentIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'I am in Sports') {
                              contacts.clear();
                              for (int i = 0; i < _sportsIssues.length; i++) {
                                contacts.add(
                                    IssuesLookingFor(_sportsIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'I am between job') {
                              contacts.clear();
                              for (int i = 0; i < _jobIssues.length; i++) {
                                contacts.add(
                                    IssuesLookingFor(_jobIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'I am a Homemaker') {
                              contacts.clear();
                              for (int i = 0;
                                  i < _homeMakerIssues.length;
                                  i++) {
                                contacts.add(IssuesLookingFor(
                                    _homeMakerIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'I am in recruitment services') {
                              contacts.clear();
                              for (int i = 0;
                                  i < _recruitmentIssues.length;
                                  i++) {
                                contacts.add(IssuesLookingFor(
                                    _recruitmentIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'None of the above') {
                              contacts.clear();
                              for (int i = 0; i < _noneIssues.length; i++) {
                                contacts.add(
                                    IssuesLookingFor(_noneIssues[i], false));
                              }
                            }
                            /*         if(selectedTherapyName!.toString().trim()=='Professional Issues'){

                                  _animals.clear();

                                  _animals=_professionalIssues;

                                }else if(selectedTherapyName!.toString().trim()=='Health Issues'){

                                  _animals.clear();
                                  _animals=[];
                                  _animals=_healthIssues;

                                }else if(selectedTherapyName!.toString().trim()=='Family Issues'){

                                  _animals.clear();
                                  _animals=[];
                                  _animals=_familyIssues;

                                }*/
                          });
                        },
                      )),
                    ),

                    /*       Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              // DropDownMultiSelect comes from multiselect
                                              child: DropDownMultiSelect(

                                                onChanged: (List<String> x) {
                                                  setState(() {
                                                    selected =x;
                                                  });
                                                },
                                                options: ['Depression' , 'Carrer related issue' , 'Confidence issue' , 'Corporate programms','Depression1' , 'Carrer related issue1' , 'Confidence issue1' , 'Corporate programms1','Depression2' , 'Carrer related issue2' , 'Confidence issue2' , 'Corporate programms2'],
                                                selectedValues: selected,

                                                whenEmpty: 'Select Something',
                                              ),
                                            ),*/

                    /*     Visibility(
                        visible: selectedTherapyName == null ||
                            selectedTherapyName!.toString().trim() ==
                                'Professional Issues',
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 0.h, left: 3.5.w, right: 3.5.w),
                            child: DropDownMultiSelect(
                              onChanged: (List<String> x) {
                                setState(() {
                                  */ /*selected1.clear();*/ /*
                                  List<String> selected1 = [];
                                  selected1 = x;

                                  stringList = selected1.join(", ");
                                  print(stringList);
                                  */ /*multiSelectIssueList
                                      .removeAt(0);*/ /*
                                  multiSelectIssueList.insert(0, selected1);
                                });
                              },
                              options: _professionalIssues,
                              selectedValues: multiSelectIssueList != null &&
                                      multiSelectIssueList.length > 0
                                  ? multiSelectIssueList[0]
                                  : [],
                              whenEmpty: 'Select Issues',
                            ))),
                    Visibility(
                        visible: selectedTherapyName != null &&
                            selectedTherapyName!.toString().trim() ==
                                'Health Issues',
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 0.h, left: 3.5.w, right: 3.5.w),
                            child: DropDownMultiSelect(
                              onChanged: (List<String> x) {
                                setState(() {
                                  */ /*selected1.clear();*/ /*
                                  List<String> selected1 = [];
                                  selected1 = x;

                                  stringList = selected1.join(", ");
                                  print(stringList);
                                  */ /*multiSelectIssueList
                                      .removeAt(0);*/ /*
                                  multiSelectIssueList.insert(0, selected1);
                                });
                              },
                              options: _healthIssues,
                              selectedValues: multiSelectIssueList != null &&
                                      multiSelectIssueList.length > 0
                                  ? multiSelectIssueList[0]
                                  : [],
                              whenEmpty: 'Select Issues',
                            ))),
                    Visibility(
                        visible: selectedTherapyName != null &&
                            selectedTherapyName!.toString().trim() ==
                                'Family Issues',
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 0.h, left: 3.5.w, right: 3.5.w),
                            child: DropDownMultiSelect(
                              onChanged: (List<String> x) {
                                setState(() {
                                  */ /*selected1.clear();*/ /*
                                  List<String> selected1 = [];
                                  selected1 = x;

                                  stringList = selected1.join(", ");
                                  print(stringList);
                                  */ /*multiSelectIssueList
                                      .removeAt(0);*/ /*
                                  multiSelectIssueList.insert(0, selected1);
                                });
                              },
                              options: _familyIssues,
                              selectedValues: multiSelectIssueList != null &&
                                      multiSelectIssueList.length > 0
                                  ? multiSelectIssueList[0]
                                  : [],
                              whenEmpty: 'Select Issues',
                            ))),*/
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            // return item
                            return ContactItem(contacts[index].name.toString(),
                                contacts[index].isSelected!, index);
                          }),
                    ),
                    /*  selectedContacts.length > 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 10,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: Colors.green[700],
                                child: Text(
                                  "Delete (${selectedContacts.length})",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  print(
                                      "Delete List Lenght: ${selectedContacts.length}");
                                },
                              ),
                            ),
                          )
                        : Container(),*/
                  ],
                ), /*Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Image.asset('assets/images/app_logo.png',width: 70.w,height: 20.h,),

                        Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 15.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Select Your Profession',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                          StringUtils.roboto_font_family,
                                      color: ColorUtils.blackColor,
                                      fontSize: 16,
                                    )))),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ColorUtils.greyColor.withOpacity(.4),
                            ),
                            color: ColorUtils.whiteColor,
                          ),
                          height: 6.h,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            // Initial Value
                            isExpanded: true,
                            value: selectedTherapyName,
                            hint: Container(
                              child: Text('Select Your Profession'),
                            ),
                            // Down Arrow Icon
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorUtils.greyColor,
                              size: 30,
                            ),

                            items: therapyList!.map((item) {
                              return DropdownMenuItem(
                                child: SizedBox(
                                  width: 50.w,

                                  child:Text(item.toString(),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 15))),
                                value: item.toString(),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                */ /*     for (var i = 0;
                                    i < therapyList!.length;
                                    i++) {
                                      if (newValue ==
                                          therapyList![i].therapy_name) {
                                        selectedTherapyName = therapyList![i].therapy_name;

                                      }
                                    }*/ /*


*/ /*                                if(selectedTherapyName!.toString().trim()=='I am a Student'){

                                  _animals.clear();
                                  _animals=_studentIssues;

                                }else if(selectedTherapyName!.toString().trim()=='I am a Teacher'){

                                  _animals.clear();
                                  _animals=_teacherIssues;

                                }else if(selectedTherapyName!.toString().trim()=='I am a professional'){

                                  _animals.clear();
                                  _animals=_professionalIssues;

                                }else if(selectedTherapyName!.toString().trim()=='I am a business owner'){

                                  _animals.clear();
                                  _animals=_businessIssues;

                                }else if(selectedTherapyName!.toString().trim()=='I am in the entertainment industry'){

                                  _animals.clear();
                                  _animals=_entertainmentIssues;

                                }else if(selectedTherapyName!.toString().trim()=='I am in Sports'){

                                  _animals.clear();
                                  _animals=_sportsIssues;

                                }
                                else if(selectedTherapyName!.toString().trim()=='I am between job'){

                                  _animals.clear();
                                  _animals=_jobIssues;

                                }

                                else if(selectedTherapyName!.toString().trim()=='I am a Homemaker'){

                                  _animals.clear();
                                  _animals=_homeMakerIssues;

                                }

                                else if(selectedTherapyName!.toString().trim()=='I am in recruitment services'){

                                  _animals.clear();
                                  _animals=_recruitmentIssues;

                                }
                                else if(selectedTherapyName!.toString().trim()=='None of the above'){

                                  _animals.clear();
                                  _animals=_noneIssues;

                                }*/ /*

                              });
                            },
                          )),
                        ),

                        */ /*       Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              // DropDownMultiSelect comes from multiselect
                                              child: DropDownMultiSelect(

                                                onChanged: (List<String> x) {
                                                  setState(() {
                                                    selected =x;
                                                  });
                                                },
                                                options: ['Depression' , 'Carrer related issue' , 'Confidence issue' , 'Corporate programms','Depression1' , 'Carrer related issue1' , 'Confidence issue1' , 'Corporate programms1','Depression2' , 'Carrer related issue2' , 'Confidence issue2' , 'Corporate programms2'],
                                                selectedValues: selected,

                                                whenEmpty: 'Select Something',
                                              ),
                                            ),*/ /*

                        Padding(
                            padding: EdgeInsets.only(
                                top: 0.h,
                                left: 3.5.w,
                                right: 3.5.w),
                            child: DropDownMultiSelect(
                              onChanged: (List<String> x) {
                                setState(() {
                                  */ /*selected1.clear();*/ /*
                                  List<String> selected1 = [];
                                  selected1 = x;

                                 stringList =
                                  selected1.join(", ");
                                  print(stringList);
                                  */ /*multiSelectIssueList
                                      .removeAt(0);*/ /*
                                  multiSelectIssueList.insert(
                                      0, selected1);
                                });
                              },
                              options: _animals,
                              selectedValues:
                              multiSelectIssueList != null && multiSelectIssueList.length>0
                                  ? multiSelectIssueList[
                              0]
                                  : [],
                              whenEmpty: 'Select Your Profession',
                            )),
                      ],
                    ),*/
              ) //row

              ),
          SpinKitFadingCircleWidget(false),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
                  child: SizedBox(
                      width: 280,
                      height: 46,
                      child: ElevatedButton(
                          child: TextWidget(
                              'Submit',
                              FontWeight.normal,
                              ColorUtils.whiteColor,
                              19,
                              StringUtils.roboto_font_family),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(10),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  ColorUtils.trendyButtonColor),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorUtils.trendyButtonColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color:
                                              ColorUtils.trendyButtonColor)))),
                          onPressed: () {
                            print('ccc   ${multiSelectIssueList.length}');

                            if (selectedTherapyName == null ||
                                selectedTherapyName!
                                    .toString()
                                    .trim()
                                    .isEmpty) {
                              showAlertDialog(
                                  context, "Please select issue type");
                            } else if (selectedContacts.isEmpty) {
                              showAlertDialog(
                                  context, "Please select any issue.");
                            } else {
                              String stringList;
                              selectedIssuesList.clear();
                              print('ccc   ${selectedContacts.length}');

                              for (int i = 0;
                                  i < selectedContacts.length;
                                  i++) {
                                selectedIssuesList
                                    .add(selectedContacts[i].name.toString());
                              }
                              stringList = selectedIssuesList.join(", ");

                              print(
                                  'issues[]    $stringList,   ${selectedTherapyName.toString()}');
                              submitType(
                                  stringList, selectedTherapyName.toString());
                            }
                            /* Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Home_Menu()));*/
                          })))),
          SpinKitFadingCircleWidget(isLoading)
        ]),
      ));
    });
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

  Widget ContactItem(String name, bool isSelected, int index) {
    return ListTile(
      /*     leading: CircleAvatar(
        backgroundColor: Colors.green[700],
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
      ),*/
      title: SizedBox(
          width: 70.w,
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )),
      /*   subtitle: Text(name),*/
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          contacts[index].isSelected = !contacts[index].isSelected!;
          if (contacts[index].isSelected == true) {
            selectedContacts.add(IssuesLookingFor(name, true));
          } else if (contacts[index].isSelected == false) {
            selectedContacts
                .removeWhere((element) => element.name == contacts[index].name);
          }
        });
      },
    );
  }

  Future<String?> submitType(String issues, String issueType) async {
    var data;
    print('submitLookingFor-   ${issues.toString()},  ${issueType.toString()}');

    var request = http.MultipartRequest('POST', BaseuURL.submit_type);

    request.fields['c_links'] =
        prefs!.getString(StringUtils.unique_id).toString();
    /* ['I am a Student', '','','', '','', '', '','','' ];
*/

    if (issueType.toString().trim() == 'I am a Student') {
      request.fields['profession_type'] = 'student';
    } else if (issueType.toString().trim() == 'I am a Teacher') {
      request.fields['profession_type'] = 'teacher';
    } else if (issueType.toString().trim() == 'I am a professional') {
      request.fields['profession_type'] = 'professional';
    } else if (issueType.toString().trim() == 'I am a business owner') {
      request.fields['profession_type'] = 'business';
    } else if (issueType.toString().trim() ==
        'I am in the entertainment industry') {
      request.fields['profession_type'] = 'entertainment';
    } else if (issueType.toString().trim() == 'I am in Sports') {
      request.fields['profession_type'] = 'sports';
    } else if (issueType.toString().trim() == 'I am between job') {
      request.fields['profession_type'] = 'job';
    } else if (issueType.toString().trim() == 'I am in recruitment services') {
      request.fields['profession_type'] = 'recruitment';
    } else if (issueType.toString().trim() == 'None of the above') {
      request.fields['profession_type'] = 'none';
    } else if (issueType.toString().trim() == 'I am a Homemaker') {
      request.fields['profession_type'] = 'homemaker';
    }

    request.fields['profession_issues[]'] = issues.toString();
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

              if (data["status"] == "true" &&
                  data["msg"] == "Success! Submitted Successfully.") {
                print('Success! Updated Successfully.---    ');
                showAlertDialog(context, "Success! Submitted Successfully.");
                SubmitProfessionTypeResponse submitProfessionTypeResponse =
                    SubmitProfessionTypeResponse.fromJson(
                        jsonDecode(response.body));
                prefs!.setString(StringUtils.unique_id,
                    submitProfessionTypeResponse.response!.cLinks.toString());

                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Healer_Register(isLookingFor: true)));

                  setState(() {});
                });
              } else {
                showAlertDialog(context, data["msg"]);
                Future.delayed(const Duration(seconds: 1), () {
                  isLoading = false;
                  setState(() {});
                });
                UtilMethods.showSnackBar(context, data["msg"]);
              }
            }

            return response.body;
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
    return null;
  }
}
