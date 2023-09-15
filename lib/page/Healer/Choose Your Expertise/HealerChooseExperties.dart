import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/all_therapy_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_profile_fetch_data.dart';
import 'package:trendy_chikitsa/page/Healer/Healer%20Register/Healer_Login.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/utils/utils_methods.dart';
import 'package:trendy_chikitsa/widget/text_widget.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';

class HealerChooseExperties extends StatefulWidget {
  const HealerChooseExperties({Key? key}) : super(key: key);

  @override
  State<HealerChooseExperties> createState() => HealerChooseExpertiesState();
}

class HealerChooseExpertiesState extends State<HealerChooseExperties> {
  final int _value = 1;

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController expInYearController = TextEditingController();

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

  var monthItem = [
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
  List<TherapyList> therapyList = [];
  SharedPreferences? prefs;
  PickedFile? _imageFile;

  List<PickedFile> certificateImageList = [];
  final ImagePicker _picker = ImagePicker();
  late Gender _gender;
  final List<String> _animals = [
    'Anxiety',
    'Carrier related issues',
    'Child counselling',
    'Confidence issue',
    'Corporate programs',
    'Depression',
    'Differently abled people',
    'Excellence in academics',
    'Excellence in sports',
    'Indecision',
    'Memory and concentration issue',
    'Parenting issues',
    'Physical health and injury',
    'Planning, Curiosity, Problem solving \nability',
    'Public and peer relationships',
    'Recruitment Analysis',
    'Sexual wellbeing',
    'Sleep issues',
    'Stress'
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
      selectedCityItem,
      expInYear,
      expInMonths,
      cityId = "",
      image_url = 'https://source.unsplash.com/user/c_v_r',
      selectedIssues;
  int value = 1, maxValue = 9;
  List<Expertise?> expertiseList = [];
  List<String?> selectTherapyItemList = [];
  List<String?> selectPricingTherapyItemList = [];
  List<String?> expInMonthsList = [];
  List<PickedFile?> therapy_certificate = [];
  List<TextEditingController?>? experienceInYearControllerList = [];

  List<String> fileNameList = [];
  var stringList;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    //  saveValue();

    super.initState();
    selectTherapyItemList.add('');
    expInMonthsList.add('0');
    experienceInYearControllerList!.add(TextEditingController());
    multiSelectIssueList.add([]);
    fileNameList.add('File Name');
    therapy_certificate.insert(0, null);

    saveValue();
  }

  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    getTherapies();
    if (prefs!
            .getString(StringUtils.subscriptionPlan)
            .toString()
            .trim()
            .toLowerCase() ==
        'free') {
      maxValue = 1;
    } else if (prefs!
            .getString(StringUtils.subscriptionPlan)
            .toString()
            .trim()
            .toLowerCase() ==
        '3 months') {
      maxValue = 5;
    } else if (prefs!
            .getString(StringUtils.subscriptionPlan)
            .toString()
            .trim()
            .toLowerCase() ==
        '6 months') {
      maxValue = 7;
    } else if (prefs!
            .getString(StringUtils.subscriptionPlan)
            .toString()
            .trim()
            .toLowerCase() ==
        '1 year') {
      maxValue = 9;
    }
    print(
        'choosed plan--    ${prefs!.getString(StringUtils.subscriptionPlan)}');
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
          automaticallyImplyLeading: false,
          title: Text('Choose Your Expertise',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: StringUtils.roboto_font_family,
                color: ColorUtils.whiteColor,
                fontSize: 18,
              )),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Stack(children: [
          Center(
              child: Padding(
            padding: EdgeInsets.only(left: 0, right: 0, top: 2.h, bottom: 10.h),
            child: ColoredBox(
                color: ColorUtils.whiteColor,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    /*  physics: NeverScrollableScrollPhysics(),*/
                    itemCount: /*expertiseList.length*/ value,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          Visibility(
                              visible: index == 0,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 2.h),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Your Expertise',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: StringUtils
                                                .roboto_font_family_bold,
                                            color: ColorUtils.blackColor,
                                            fontSize: 19,
                                          ))))),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 2.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Expertise ${index + 1}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                            StringUtils.roboto_font_family,
                                        color: ColorUtils.blackColor,
                                        fontSize: 18,
                                      )),
                                  Visibility(
                                      visible: index > 0,
                                      child: IconButton(
                                          onPressed: () {
                                            if (expertiseList.length > index) {
                                              /*   deleteExpertise(
                                                        expertiseList[
                                                        index]!
                                                            .expertise_id
                                                            .toString(),
                                                        (index + 1)
                                                            .toString());*/
                                            } else {
                                              value = value - 1;
                                              selectTherapyItemList
                                                  .removeAt(index);
                                              expInMonthsList.removeAt(index);
                                              experienceInYearControllerList!
                                                  .removeAt(index);
                                              multiSelectIssueList
                                                  .removeAt(index);
                                              fileNameList.removeAt(index);
                                              therapy_certificate
                                                  .removeAt(index);
                                            }
                                            setState(() {});
                                            /* selectTherapyItemList
                                                .add('');
                                            expInMonths.add('0');
                                            experienceInYearControllerList!
                                                .add(
                                                TextEditingController());
                                            multiSelectIssueList.add([]);
                                            fileNameList.add('File Name');
                                            therapy_certificate.insert(index, null);*/
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: ColorUtils.darkPinkColor,
                                            size: 30,
                                          ))),
                                ],
                              ) /*Align(
                                              alignment: Alignment.centerLeft,
                                              child:
                                              Text('Expertise ${index + 1}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color: ColorUtils
                                                        .blackColor,
                                                    fontSize: 18,
                                                  )))*/
                              ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 2.h),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Select Therapy',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                            StringUtils.roboto_font_family,
                                        color: ColorUtils.blackColor,
                                        fontSize: 16,
                                      )))),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 15),
                            margin: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
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
                              value: selectTherapyItemList.length >= index &&
                                      selectTherapyItemList[index] == ''
                                  ? selectedCityItem
                                  : selectTherapyItemList[index],
                              hint: Container(
                                child: const Text('Select Therapy'),
                              ),
                              // Down Arrow Icon
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: ColorUtils.greyColor,
                                size: 30,
                              ),

                              items: therapyList.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item.therapy_name.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 15)),
                                  value: item.therapy_name.toString(),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectTherapyItemList[index] = newValue!;
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

                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.h, left: 3.5.w, right: 3.5.w),
                            child: DropDownMultiSelect<String>(
                              // Specify the generic type 'String'
                              onChanged: (List<String> x) {
                                // Specify the type 'String'
                                setState(() {
                                  List<String> selected1 = [];
                                  selected1 = x;

                                  var stringList = selected1.join(" ");
                                  print(stringList);
                                  multiSelectIssueList.removeAt(index);
                                  multiSelectIssueList.insert(index, selected1);
                                });
                              },
                              options: _animals,
                              selectedValues: multiSelectIssueList != null
                                  ? multiSelectIssueList[index]
                                  : [],
                              whenEmpty: 'Select Something',
                            ),
                          ),

                          /*     Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h, left: 2.w, right: 2.w),
                                          child: GFMultiSelect(
                                            items: _animals,
                                            initialSelectedItemsIndex: issueIndexList[index] !=
                                                null
                                                ? issueIndexList![index]
                                                : [],
                                            onSelect: (value1) {
                                              print('selected $value1');

                                              print('selected $value1');
                                              print(
                                                  'selected ${value1.length}');
                                              for (int j = 0; j <
                                                  value1.length; j++) {
                                                for (int i = 0; i <
                                                    _animals.length; i++) {
                                                  print(
                                                      'selected-- ${value1[j]}   ${_animals[i]}');
                                                }
                                              }
                                            },
                                            dropdownTitleTileMargin:
                                            EdgeInsets.only(
                                                top: 1.h,
                                                left: 2.w,
                                                right: 2.w,
                                                bottom: 1.h),
                                            dropdownTitleTilePadding:
                                            EdgeInsets.all(10),
                                            dropdownUnderlineBorder:
                                            const BorderSide(
                                                color: Colors.transparent,
                                                width: 2),
                                            dropdownTitleTileBorder: Border.all(
                                                color: ColorUtils.greyColor
                                                    .withOpacity(.4),
                                                width: 1),
                                            dropdownTitleTileBorderRadius:
                                            BorderRadius.circular(5),
                                            expandedIcon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black54,
                                            ),
                                            collapsedIcon: const Icon(
                                              Icons.keyboard_arrow_up,
                                              color: Colors.black54,
                                            ),
                                            submitButton: Text('OK'),
                                            cancelButton: Text('Cancel'),
                                            dropdownTitleTileTextStyle:
                                            const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54),
                                            padding: const EdgeInsets.all(0),
                                            margin: const EdgeInsets.all(0),
                                            type: GFCheckboxType.basic,
                                            activeBgColor: GFColors.SUCCESS,
                                            activeBorderColor: GFColors.SUCCESS,
                                            inactiveBorderColor:
                                            ColorUtils.greyColor,
                                          )),*/
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 2.h),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Experience(in Year)',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                            StringUtils.roboto_font_family,
                                        color: ColorUtils.blackColor,
                                        fontSize: 16,
                                      )))),
                          Container(
                            height: 6.h,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 2.w),
                            margin: EdgeInsets.only(
                                top: 1.h, left: 4.w, right: 4.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: ColorUtils.greyColor.withOpacity(.4),
                              ),
                            ),
                            child: TextField(
                              controller: experienceInYearControllerList !=
                                          null &&
                                      experienceInYearControllerList!.isNotEmpty
                                  ? experienceInYearControllerList![index]
                                  : null,
                              keyboardType: TextInputType.number,
                              enabled: true,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: ColorUtils.greyColor,
                                      fontSize: 16),
                                  labelStyle: TextStyle(
                                      color: ColorUtils.blackColor,
                                      fontSize: 16),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: 'eg. 2'),
                              onChanged: (text) {
                                setState(() {
                                  experienceInYearControllerList![index]!.text =
                                      text.toString();

                                  experienceInYearControllerList![index]!
                                          .selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              experienceInYearControllerList![
                                                      index]!
                                                  .text
                                                  .length));
                                  /* customer_mobile =
                                          text.toString();*/
                                  //you can access nameController in its scope to get
                                  // the value of text entered as shown below
                                  //UserName = nameController.text;
                                });
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 2.h),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Experience(in Months)',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                            StringUtils.roboto_font_family,
                                        color: ColorUtils.blackColor,
                                        fontSize: 16,
                                      )))),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 15),
                            margin: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
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
                              value: expInMonthsList.length >= index &&
                                      expInMonthsList[index] == ''
                                  ? selectedCityItem
                                  : expInMonthsList[index],
                              /*expInMonths[index]*/
                              hint: Container(
                                child: const Text('0'),
                              ),
                              // Down Arrow Icon
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: ColorUtils.greyColor,
                                size: 30,
                              ),

                              items: monthItem.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(
                                        color:
                                            ColorUtils.textFormFieldLabelColor,
                                        /*  fontFamily: StringUtils
                                      .roboto_font_family,*/
                                        fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  expInMonthsList[index] = newValue!;
                                });
                              },
                            )),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Choose File To Upload',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily:
                                            StringUtils.roboto_font_family,
                                        color: ColorUtils.blackColor,
                                        fontSize: 17,
                                      )))),
                          Visibility(
                              visible: true,
                              /*expertiseList.length>index?expertiseList[index]!
                                              .therapyCertificate1.toString() ==
                                              "" ? false : true:true,*/
                              child: Container(
                                  height: 8.h,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 1),
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: ColorUtils.greyColor,
                                    ),
                                    color: ColorUtils.whiteColor,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      /*  new Text('+91 ',
                                textAlign:
                                TextAlign.left,
                                style: TextStyle(

                                  color:Constant
                                      .blackColor,
                                  fontSize: 19,
                                )),*/
                                      const SizedBox(
                                        width: 0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                            width: 67.w,
                                            child: Text(
                                                fileNameList.length >= index
                                                    ? fileNameList[index]
                                                        .toString()
                                                        .split('/')
                                                        .last
                                                    : 'File Name' /* 'File Name'*/,
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontFamily: StringUtils
                                                      .roboto_font_family,
                                                  color: ColorUtils.blackColor,
                                                  fontSize: 17,
                                                ))),

                                        //flexible
                                      ),
                                      Visibility(
                                          visible:
                                              fileNameList[index] == 'File Name'
                                                  ? false
                                                  : true,
                                          child: InkWell(
                                              onTap: () async {
                                                /*    _pickCertificates(
                                                                index);*/
                                              },
                                              child: SizedBox(
                                                  height: 8.h,
                                                  width: 83,
                                                  child: ColoredBox(
                                                    color: ColorUtils
                                                        .lightGreyBorderColor,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text('View',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              color: ColorUtils
                                                                  .blackColor,
                                                              fontSize: 17,
                                                            ))),
                                                  )))),
                                      Visibility(
                                          visible:
                                              fileNameList[index] == 'File Name'
                                                  ? true
                                                  : false,
                                          child: InkWell(
                                              onTap: () async {
                                                _pickCertificates(index);
                                              },
                                              child: SizedBox(
                                                  height: 8.h,
                                                  width: 83,
                                                  child: ColoredBox(
                                                    color: ColorUtils
                                                        .lightGreyBorderColor,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text('Browse',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  StringUtils
                                                                      .roboto_font_family,
                                                              color: ColorUtils
                                                                  .blackColor,
                                                              fontSize: 17,
                                                            ))),
                                                  )))),
                                    ], //widget
                                  ))),
                          Visibility(
                              visible: prefs != null &&
                                  prefs!
                                          .getString(
                                              StringUtils.subscriptionPlan)
                                          .toString()
                                          .toLowerCase()
                                          .trim() !=
                                      'free' &&
                                  index + 1 == value,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (value < maxValue) {
                                        value = value + 1;
                                        selectTherapyItemList.add('');
                                        expInMonthsList.add('0');
                                        experienceInYearControllerList!
                                            .add(TextEditingController());
                                        multiSelectIssueList.add([]);
                                        fileNameList.add('File Name');
                                        therapy_certificate.insert(index, null);
                                      }
                                    });
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 2.h,
                                          bottom: 3.h),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text('Add More Expertise',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily: StringUtils
                                                    .roboto_font_family_bold,
                                                color: Colors.lightBlue,
                                                fontSize: 19,
                                              )))))),
                        ],
                      );
                    })),

            /* SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 2.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Select Therapy',
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
                              child: Text('Select Therapy'),
                            ),
                            // Down Arrow Icon
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorUtils.greyColor,
                              size: 30,
                            ),

                            items: therapyList!.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.therapy_name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 15)),
                                value: item.therapy_name.toString(),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {

                                selectedTherapyName = newValue.toString();
                              });
                            },
                          )),
                        ),


                        Padding(
                            padding: EdgeInsets.only(
                                top: 0.h,
                                left: 3.5.w,
                                right: 3.5.w),
                            child: DropDownMultiSelect(
                              onChanged: (List<String> x) {
                                setState(() {

                                  List<String> selected1 = [];
                                  selected1 = x;

                                 stringList =
                                  selected1.join(", ");
                                  print(stringList);

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
                              whenEmpty: 'Select Something',
                            )),

                        Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 2.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Experience(in Year)',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                          StringUtils.roboto_font_family,
                                      color: ColorUtils.blackColor,
                                      fontSize: 16,
                                    )))),


                        Container(
                          height: 6.h,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 2.w),
                          margin:
                              EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ColorUtils.greyColor.withOpacity(.4),
                            ),

                          ),
                          child: new TextField(
                            controller: expInYearController,
                            keyboardType: TextInputType.number,
                            enabled: true,
                            textAlign: TextAlign.left,
                            decoration: new InputDecoration(
                                hintStyle: TextStyle(
                                    color: ColorUtils.greyColor, fontSize: 16),
                                labelStyle: TextStyle(
                                    color: ColorUtils.blackColor, fontSize: 16),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'eg. 2'),
                            onChanged: (text) {
                              setState(() {


                              });
                            },
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 2.h),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Experience(in Months)',
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
                            value: expInMonths,
                            hint: Container(
                              child: Text('0'),
                            ),
                            // Down Arrow Icon
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorUtils.greyColor,
                              size: 30,
                            ),

                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                      color: ColorUtils.textFormFieldLabelColor,
                                      */ /*  fontFamily: StringUtils
                                      .roboto_font_family,*/ /*
                                      fontSize: 16),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                expInMonths = newValue!;
                              });
                            },
                          )),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Choose File To Upload',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                          StringUtils.roboto_font_family,
                                      color: ColorUtils.blackColor,
                                      fontSize: 17,
                                    )))),
                        Container(
                            height: 6.h,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 1),
                            margin:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: ColorUtils.greyColor,
                              ),
                              color: ColorUtils.whiteColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                SizedBox(
                                  width: 0,
                                ),
                                new Container(
                                  child: new Align(
                                      alignment: Alignment.centerLeft,
                                      child:Padding(padding: EdgeInsets.only(left: 2.w),child:SizedBox(width: 55.w,child: Text(

                                          _imageFile!=null?
                                      _imageFile!.path.split('/').last:'File Name',
                                          textAlign: TextAlign.left,
                                          maxLines: 2,

                                          style: TextStyle(
                                            fontFamily:
                                                StringUtils.roboto_font_family,
                                            color: ColorUtils.blackColor,
                                            fontSize: 17,
                                          ))))),

                                  //flexible
                                ),
                                InkWell(
                                    onTap: () async {

                                      _pickImage();
                                    },
                                    child: SizedBox(
                                        height: 50,
                                        width: 80,
                                        child: ColoredBox(
                                          color:
                                              ColorUtils.lightGreyBorderColor,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text('Browse',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: StringUtils
                                                        .roboto_font_family,
                                                    color:
                                                        ColorUtils.blackColor,
                                                    fontSize: 15,
                                                  ))),
                                        ))),
                              ], //widget
                            )),
                      ],
                    ),
                  )*/ //row
          )),
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
                              'Continue',
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

                            if (selectTherapyItemList.length < value) {
                              showAlertDialog(context, "Please select therapy");
                            } else if (multiSelectIssueList[0].isEmpty) {
                              showAlertDialog(
                                  context, "Please select therapy issues");
                            } else if (experienceInYearControllerList!.length <
                                value) {
                              showAlertDialog(
                                  context, "Please enter experience in year");
                            } else if (expInMonthsList.length < value) {
                              showAlertDialog(
                                  context, "Please enter experience in month");
                            } else if (therapy_certificate.length < value) {
                              showAlertDialog(
                                  context, "Please choose certificate.");
                            } else {
                              isLoading = true;
                              setState(() {});
                              updateChooseExperties();
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

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      print(
          'Image picker error  ${pickedFile!.path.toString().split('/').last}');

      setState(() {
        _imageFile = pickedFile;
      });

      //  var res = await uploadImage(_imageFile!.path.toString());
      // print(res);
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  Future<String?> updateChooseExperties() async {
    var data;

    var request = http.MultipartRequest('POST', BaseuURL.submitExperties);

    request.fields['unique_id'] =
        prefs!.getString(StringUtils.unique_id).toString();
    /*   request.fields['therapy_name'] = selectedTherapyName.toString();*/

    for (int i = 0; i < value; i++) {
      print(
          'therapy_name${i + 1} --    ${selectTherapyItemList[i].toString()}');
      request.fields['therapy_name${i + 1}'] =
          selectTherapyItemList[i].toString();
    }
    print('issues[] sasd   ${multiSelectIssueList.length}');
    /* for (int i = 0; i < multiSelectIssueList.length; i++) {
      var stringList = multiSelectIssueList[i].join(" ");
      request.fields['issues[]'] = stringList;
      print('issues[]    ${stringList}');
    }*/

    for (int i = 0; i < multiSelectIssueList.length; i++) {
      var stringList = multiSelectIssueList[i].join(", ");
      request.fields['issues${i + 1}[]'] = stringList;
      print('issues${i + 1}[]    $stringList');
    }

/*
    request.fields['experience_month'] = expInMonths.toString();
    request.fields['experience_year'] = expInYearController.text.toString();
*/

    for (int i = 0; i < value; i++) {
      print(
          'experience_year${i + 1} --    ${experienceInYearControllerList![i]!.text.toString()}');

      request.fields['experience_year${i + 1}'] =
          experienceInYearControllerList![i]!.text.toString();
    }

    for (int i = 0; i < value; i++) {
      print('experience_month${i + 1} --    ${expInMonthsList[i]!.toString()}');

      request.fields['experience_month${i + 1}'] =
          expInMonthsList[i]!.toString();
    }

    for (int i = 0; i < value; i++) {
      print('therapy_certificate${i + 1} -- ');
      if (therapy_certificate[i] != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'therapy_certificate${i + 1}',
            therapy_certificate[i]!.path.toString()));
      }
    }
    /* if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'therapy_certificate', _imageFile!.path.toString()));
    }*/

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
                  data["msg"] == "Expertise submitted successfully") {
                print('Expertise submitted successfully---    ');
                prefs!.setString(StringUtils.completeProfile, "YES");
                UtilMethods.showSnackBar(
                    context, "Expertise submitted successfully!");
                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  setState(() {});
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Healer_Login()));
                });
                //  showAlertDialog(context, "Uploaded KYC successfully" );
              } else {
                UtilMethods.showSnackBar(context, data["msg"]);
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

  void _pickCertificates(int index) async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        therapy_certificate.insert(index, pickedFile);
        fileNameList.insert(index, pickedFile!.path.split('/').last);
      });
      //  var res = await uploadImage(_imageFile!.path.toString());
      // print(res);
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }
}
