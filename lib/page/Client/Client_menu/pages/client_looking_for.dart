import 'dart:convert';

import 'package:trendy_chikitsa/baseurl/baseURL.dart';
import 'package:trendy_chikitsa/models/client_responses/submit_looking_for_response.dart';
import 'package:trendy_chikitsa/models/looking_for_issues_models/lookin_for_issues_model_a.dart';
import 'package:trendy_chikitsa/page/Client/Client%20Register/Client_Register.dart';
import 'package:trendy_chikitsa/page/Client/Client_menu/pages/client_looking_for_professional_issues.dart';
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

class ClientLookingFor extends StatefulWidget {
  const ClientLookingFor({Key? key}) : super(key: key);

  @override
  State<ClientLookingFor> createState() => ClientLookingForState();
}

class ClientLookingForState extends State<ClientLookingFor> {
  final int _value = 1;

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController expInYearController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? dropdownvalue;
  List<String> selectedIssuesList = [];
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
  List<IssuesLookingFor> selectedContacts = [];
  List<String> therapyList = [
    'Professional Issues',
    'Health Issues',
    'Family Issues'
  ];
  final List<String> _professionalIssues = [
    'Career dissatisfaction',
    'Moving ahead in my career',
    'Career counseling (I feel I am in the wrong career/My career is not going the way I had hoped)',
    'Starting a new career',
    'Want to achieve academic excellence',
    'Want to achieve excellence in sports',
    'Difficulty in concentration',
    'Stress',
    'Depression',
    'Difficulty sleeping',
    'Low productivity',
    'Others',
    'I am simply checking out the website'
  ];

  final List<String> _healthIssues = [
    'I am recovering from an injury/ailment and conventional treatment is not sufficient',
    'I cannot relax',
    'I am under stress',
    'I am depressed',
    'I am having difficulty sleeping',
    'Sexual health',
    'I am having strange dreams/nightmares  and would like to understand why',
    'I am interested in my past life',
    'I am having mental block',
    'Others',
    'I am simply checking out the website'
  ];

  final List<String> _familyIssues = [
    ' Relationship issues',
    'I am grieving from the loss of a loved one',
    'Marriage counselling',
    'Alliance match',
    'I have strange dreams/nightmares  and would like to understand why',
    'Child counseling',
    'Good parenting',
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
  List<IssuesLookingFor> contacts = [];

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
          title: Text('I am Looking For',
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
                  EdgeInsets.only(left: 0, right: 0, top: 15.h, bottom: 15.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/app_logo.png',
                      width: 50.w,
                      height: 15.h,
                    ),
                    SizedBox(
                        height: 2.h,
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 15.h),
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
                            selectedTherapyName = newValue.toString();
                            multiSelectIssueList.clear();
                            selectedContacts.clear();
                            setState(() {});
                            print(
                                'check vles--   ${selectedTherapyName!.toString().trim()}');
                            if (selectedTherapyName!.toString().trim() ==
                                'Professional Issues') {
                              contacts.clear();
                              for (int i = 0;
                                  i < _professionalIssues.length;
                                  i++) {
                                contacts.add(IssuesLookingFor(
                                    _professionalIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'Health Issues') {
                              contacts.clear();
                              for (int i = 0; i < _healthIssues.length; i++) {
                                contacts.add(
                                    IssuesLookingFor(_healthIssues[i], false));
                              }
                            } else if (selectedTherapyName!.toString().trim() ==
                                'Family Issues') {
                              contacts.clear();
                              for (int i = 0; i < _familyIssues.length; i++) {
                                contacts.add(
                                    IssuesLookingFor(_familyIssues[i], false));
                              }
                            }
                          });
                        },
                      )),
                    ),
                    SizedBox(
                      height: 0.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: contacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            // return item
                            return ContactItem(contacts[index].name.toString(),
                                contacts[index].isSelected!, index);
                          }),
                    ),
                  ],
                ),
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
                              submitLookingFor(
                                  stringList, selectedTherapyName.toString());
                            }
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

  Future<String?> submitLookingFor(String issues, String issueType) async {
    var data;
    print('submitLookingFor-   ${issues.toString()},  ${issueType.toString()}');

    var request = http.MultipartRequest('POST', BaseuURL.submit_looking_for);
    request.fields['issues[]'] = issues.toString();
    if (issueType.toString().trim() == 'Health Issues') {
      request.fields['issue_type'] = 'health';
    } else if (issueType.toString().trim() == 'Professional Issues') {
      request.fields['issue_type'] = 'professional';
    } else if (issueType.toString().trim() == 'Family Issues') {
      request.fields['issue_type'] = 'family';
    }

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
                  data["msg"] ==
                      "Success! Your issue has been submitted successfully. Please login to access your account.") {
                showAlertDialog(context,
                    "Success! Your issue has been submitted successfully. Please login to access your account.");
                SubmitLookingForResponse submitLookingForResponse =
                    SubmitLookingForResponse.fromJson(
                        jsonDecode(response.body));

                prefs!.setString(StringUtils.unique_id,
                    submitLookingForResponse.response!.cLinks.toString());
                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const Client_Register())); //isLookingFor: true

                  setState(() {});
                });
              } else if (data["status"] == "true" &&
                  data["msg"] ==
                      "Success! Your issue has been submitted successfully. Please select profession to proceed further.") {
                print('Success! Updated Successfully.---    ');
                showAlertDialog(context,
                    "Success! Your issue has been submitted successfully. Please select profession to proceed further.");
                SubmitLookingForResponse submitLookingForResponse =
                    SubmitLookingForResponse.fromJson(
                        jsonDecode(response.body));

                prefs!.setString(StringUtils.unique_id,
                    submitLookingForResponse.response!.cLinks.toString());

                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          const ClientLookingForProfessionalIssues()));

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
