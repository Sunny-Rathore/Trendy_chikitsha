import 'dart:convert';

import 'package:doctor/baseurl/baseURL.dart';
import 'package:doctor/global/global.dart';
import 'package:doctor/models/all_therapy_response.dart';
import 'package:doctor/page/Healer/Healer%20Register/Healer_Login.dart';
import 'package:doctor/page/Healer/Healer_menu/Menu%20Pages/Home_Menu.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:doctor/utils/utils_methods.dart';
import 'package:doctor/widget/text_widget.dart';
import 'package:doctor/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class HealerChooseExperties extends StatefulWidget {
  const HealerChooseExperties({Key? key}) : super(key: key);

  @override
  State<HealerChooseExperties> createState() => HealerChooseExpertiesState();
}

class HealerChooseExpertiesState extends State<HealerChooseExperties> {
  int _value = 1;

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController expInYearController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? dropdownvalue;
  var items = [
    '0',
    '1',
    '2','3','4','5','6','7','8','9','10','11','12'
  ];
  List<TherapyList> therapyList = [];
  SharedPreferences? prefs;
  PickedFile? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
  late Gender _gender;
  List<String?> _animals = [
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
    'Planning, Curiosity, Problem solving ability',
    'Public and peer relationships',
    'Recruitment Analysis',
    'Sexual wellbeing',
    'Sleep issues',
    'Stress'
  ];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = true.obs;
  bool isLoading=false;
  String? selectedSpinnerItem,
      selectedSpinnerItem1,
      selectedTherapyName,
      selectedTherapyIssues,selectedTherapyIssues1,
      selectedStateItem,
      expInYear,
      expInMonths,
      cityId = "",
      image_url = 'https://source.unsplash.com/user/c_v_r',
      selectedIssues;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    //  saveValue();

    super.initState();
    saveValue();
  }

  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    getTherapies();
    Future.delayed(Duration(seconds: 1), () {
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
          brightness: Brightness.dark,
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
          Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 0, right: 0, top: 2.h, bottom: 10.h),
                  child: SingleChildScrollView(
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
                                /*     for (var i = 0;
                                    i < therapyList!.length;
                                    i++) {
                                      if (newValue ==
                                          therapyList![i].therapy_name) {
                                        selectedTherapyName = therapyList![i].therapy_name;

                                      }
                                    }*/
                                selectedTherapyName = newValue.toString();
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
                                top: 2.h, left: 2.w, right: 2.w),
                            child: GFMultiSelect(
                              items: _animals,
                              onSelect: (value1) {
                                print('selected $value1');
                                print('selected ${value1.length}');
                                for (int j = 0; j < value1.length; j++) {
                                  for (int i = 0; i < _animals.length; i++) {
                                    print('selected-- ${value1[j]}   ${_animals[i]}');

                                    if(value1[j] == i){
                                      if(selectedTherapyIssues==null){
                                        selectedTherapyIssues='${_animals[i]}, ';
                                      }else{
                                        selectedTherapyIssues1='';
                                        selectedTherapyIssues1='${selectedTherapyIssues}${_animals[i]}, ';

                                      }

                                    }

                                  }
                                }
                              },
                              dropdownTitleTileMargin: EdgeInsets.only(
                                  top: 1.h, left: 2.w, right: 2.w, bottom: 1.h),
                              dropdownTitleTilePadding: EdgeInsets.all(10),
                              dropdownUnderlineBorder: const BorderSide(
                                  color: Colors.transparent, width: 2),
                              dropdownTitleTileBorder: Border.all(
                                  color: ColorUtils.greyColor.withOpacity(.4),
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
                              dropdownTitleTileTextStyle: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                              type: GFCheckboxType.basic,
                              activeBgColor: GFColors.SUCCESS,
                              activeBorderColor: GFColors.SUCCESS,
                              inactiveBorderColor: ColorUtils.greyColor,
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

                        /* keyboardType: TextInputType.multiline,
                                  maxLines: null,*/
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
                            /*color: ColorUtils
                                                      .lightGreyBorderColor
                                                      .withOpacity(0.3),*/
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
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                /*  new Text('+91 ',
                                textAlign:
                                TextAlign.left,
                                style: TextStyle(

                                  color:Constant
                                      .blackColor,
                                  fontSize: 19,
                                )),*/
                                SizedBox(
                                  width: 0,
                                ),
                                new Container(
                                  child: new Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          /*fileName*/
                                          'File Name',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                                StringUtils.roboto_font_family,
                                            color: ColorUtils.blackColor,
                                            fontSize: 17,
                                          ))),

                                  //flexible
                                ),
                                InkWell(
                                    onTap: () async {
                                      /*     FilePickerResult? result =
                                                          await FilePicker.platform
                                                              .pickFiles(
                                                              type: FileType.any);
                                                          */ /*  allowedExtensions: ['.csv', 'doc','pdf']);*/ /*
                                                          */ /* allowedExtensions: [
                                                    'doc',
                                                    'pdf','csv',
                                                  ]);*/ /*
                                                          if (result == null) return;
                                                          file = result!.files.first;
                                                          print('File Name: ${file?.name}');
                                                          print('File Size: ${file?.size}');
                                                          print(
                                                              'File Extension: ${file?.extension}');
                                                          print('File Path: ${file?.path}');

                                                          fileName = file!.name.toString();
                                                          await uploadFile(
                                                              file
                                                                  ?.path);
                                                          setState(() {});*/
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
                  ) //row

                  )),
          SpinKitFadingCircleWidget(false),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
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
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color:
                                              ColorUtils.trendyButtonColor)))),
                          onPressed: () {
                            print('ccc   ${selectedTherapyIssues}');

                            if(selectedTherapyName==null){
                              showAlertDialog(context, "Please select therapy");
                            }else if(selectedTherapyIssues1==null){
                              showAlertDialog(context, "Please select therapy issues");

                            }else if(expInYearController.text.toString().length==0){
                              showAlertDialog(context, "Please enter experience in year");

                            }else if(expInMonths.toString().length==0){
                              showAlertDialog(context, "Please enter experience in month");

                            }else if(_imageFile==null){
                              showAlertDialog(context, "Please choose certificate.");

                            }else{
                              isLoading=true;
                              setState(() {

                              });
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
    /*   Map<String, String> headers = {'Authorization': prefs.getString(StringConstant.token)};
*/
    var request = http.MultipartRequest('POST', BaseuURL.submitExperties);
    //   request.headers.addAll(headers);
    request.fields['unique_id'] =
        prefs!.getString(StringUtils.unique_id).toString();
    request.fields['therapy_name'] = selectedTherapyName.toString();
    request.fields['issues[]'] = selectedTherapyIssues.toString();
    request.fields['experience_month'] = expInMonths.toString();
    request.fields['experience_year'] =expInYearController.text.toString();

    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'therapy_certificate', _imageFile!.path.toString()));
    }
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
              print('--->>?   ${data}');

              if (data["status"] == "true" &&
                  data["msg"] == "Expertise submitted successfully") {
                print('Expertise submitted successfully---    ');
                prefs!.setString(StringUtils.completeProfile, "YES");
                UtilMethods.showSnackBar(context, "Expertise submitted successfully!");
                Future.delayed(Duration(seconds: 2), () {
                  isLoading=false;
                  setState(() {

                  });
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Healer_Login()));
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
              print('--->>?   ${data}');

              if (data["status"] == "true" && data["msg"] == "success") {
                print('Login succssfull---    ');

                final jsonResponse = json.decode(response.body);

                AllTherapyResponse studentAllChapterResponse =
                    new AllTherapyResponse.fromJson(jsonResponse);
                /*  setState(() {*/
                therapyList = studentAllChapterResponse!.response!;

                //   leadList.add(person.campaignData.indexOf(0));
                /*   });*/
                //  showAlertDialog(context, "Uploaded KYC successfully" );
              } else {
                therapyList!.clear();
                setState(() {});
              }
            }

            return response.body;
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
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
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: 60.w,
                    child: Text(msg,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            fontSize: 18)))),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new GestureDetector(
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
}
