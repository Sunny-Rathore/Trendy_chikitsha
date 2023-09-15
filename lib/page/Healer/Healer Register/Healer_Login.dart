import 'dart:convert';

import 'package:trendy_chikitsa/models/client_responses/client_login_response.dart';
import 'package:trendy_chikitsa/models/healer_responses/healer_login_response.dart';
import 'package:trendy_chikitsa/page/Client/Client_menu/pages/Client_Home_Menu.dart';
import 'package:trendy_chikitsa/page/Client/Client_menu/pages/client_looking_for.dart';

import 'package:trendy_chikitsa/page/Healer/Choose%20Your%20Expertise/HealerChooseExperties.dart';

import 'package:trendy_chikitsa/page/Healer/Healer_menu/Menu%20Pages/Home_Menu.dart';

import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/healer_pricing_plan.dart';
import 'package:trendy_chikitsa/page/LoginPage.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:trendy_chikitsa/utils/string_utils.dart';
import 'package:trendy_chikitsa/widget/text_widget.dart';
import 'package:trendy_chikitsa/widgets/spinKitFadingCircleWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../global/global.dart';
import 'Healer_Forgotpass.dart';
import 'Healer_Register.dart';
import 'package:http/http.dart' as http;

class Healer_Login extends StatefulWidget {
  const Healer_Login({Key? key}) : super(key: key);

  @override
  State<Healer_Login> createState() => _Healer_LoginState();
}

class _Healer_LoginState extends State<Healer_Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = false.obs;
  bool isChecked = false, isLoading = false;
  final int? _value = 0;
  bool _isObscure = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  SharedPreferences? prefs;

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
    setState(() {});
    // _register();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                toolbarHeight: 60,
                backgroundColor: ColorUtils.trendyThemeColor,
                elevation: 0.0,
                /*  automaticallyImplyLeading: false,*/
                title: Text('Healer Login',
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
                SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: 0, right: 0, top: 15.h, bottom: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 3.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Email',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: StringUtils.roboto_font_family,
                                    color: ColorUtils.blackColor,
                                    fontSize: 17,
                                  )))),
                      Container(
                          height: 7.h,
                          width: 100.w,
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 15),
                          margin:
                              EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorUtils.lightGreyBorderColor),
                            color: ColorUtils.whiteColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*        new Text('+91 ',
                                                        textAlign:
                                                        TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily: StringUtils
                                                              .roboto_font_family,
                                                          color: ColorUtils
                                                              .blackColor,
                                                          fontSize: 19,
                                                        )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),*/
                              Container(
                                child: Flexible(
                                  child: TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.text,
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
                                            fontFamily:
                                                StringUtils.roboto_font_family,
                                            fontSize: 17),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Enter Email'),
                                    onChanged: (text) {
                                      setState(() {
                                        /*   customer_mobile =
                                                            text
                                                                .toString();*/
                                      });
                                    },
                                  ),
                                ), //flexible
                              ), //container
                            ], //widget
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 3.h),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Password',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: StringUtils.roboto_font_family,
                                    color: ColorUtils.blackColor,
                                    fontSize: 17,
                                  )))),
                      Container(
                          height: 7.h,
                          width: 100.w,
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 15),
                          margin:
                              EdgeInsets.only(top: 1.h, left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorUtils.lightGreyBorderColor),
                            color: ColorUtils.whiteColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*        new Text('+91 ',
                                                        textAlign:
                                                        TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily: StringUtils
                                                              .roboto_font_family,
                                                          color: ColorUtils
                                                              .blackColor,
                                                          fontSize: 19,
                                                        )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),*/
                              Container(
                                child: Flexible(
                                  child: TextField(
                                    controller: _passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    textAlign: TextAlign.left,
                                    obscureText: !_isObscure,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: ColorUtils.b3Color,
                                            fontFamily: StringUtils
                                                .roboto_font_family_regular,
                                            fontSize: 17),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              _isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            }),
                                        labelStyle: TextStyle(
                                            color: ColorUtils
                                                .textFormFieldLabelColor,
                                            fontFamily:
                                                StringUtils.roboto_font_family,
                                            fontSize: 17),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Enter Password'),
                                    onChanged: (text) {
                                      setState(() {
                                        /*   customer_mobile =
                                                            text
                                                                .toString();*/
                                      });
                                    },
                                  ),
                                ), //flexible
                              ), //container
                            ], //widget
                          )),
                      Container(
                        margin:
                            EdgeInsets.only(left: 8.w, right: 8.w, top: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.colorlal),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const Healer_Forgotpass()));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10.h),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (_emailController.text.isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(_emailController.text)) {
                                      showAlertDialog(
                                          context, "Please enter valid email");
                                    } else if (_passwordController
                                        .text.isEmpty) {
                                      showAlertDialog(
                                          context, "Please enter password");
                                    } else {
                                      loginHealer();
                                    }
                                  },
                                  child: SizedBox(
                                      width: 280,
                                      height: 46,
                                      child: ElevatedButton(
                                          child: TextWidget(
                                              'Login',
                                              FontWeight.normal,
                                              ColorUtils.whiteColor,
                                              19,
                                              StringUtils.roboto_font_family),
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(10),
                                              foregroundColor: MaterialStateProperty.all<Color>(
                                                  ColorUtils.trendyButtonColor),
                                              backgroundColor:
                                                  MaterialStateProperty.all<Color>(
                                                      ColorUtils
                                                          .trendyButtonColor),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0),
                                                      side: BorderSide(color: ColorUtils.trendyButtonColor)))),
                                          onPressed: () async {
                                            if (_emailController.text.isEmpty ||
                                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(_emailController
                                                        .text)) {
                                              showAlertDialog(context,
                                                  "Please enter valid email");
                                            } else if (_passwordController
                                                .text.isEmpty) {
                                              showAlertDialog(context,
                                                  "Please enter password");
                                            } else {
                                              loginHealer();
                                            }
                                          }))),
                              SizedBox(
                                height: 2.h,
                              ),
                              InkWell(
                                child: RichText(
                                    text: TextSpan(
                                        text: 'Create an account',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.colorlal,
                                            decoration:
                                                TextDecoration.underline))),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Healer_Register(
                                                isLookingFor: false,
                                              )));
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Visibility(
                                  visible: prefs != null &&
                                      prefs!
                                              .getString(StringUtils.type)
                                              .toString() ==
                                          "2",
                                  child: InkWell(
                                    child: RichText(
                                        text: TextSpan(
                                            text: 'I am looking for',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.colorlal,
                                                decoration:
                                                    TextDecoration.underline))),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const ClientLookingFor()));
                                    },
                                  ))
                            ]))),
                SpinKitFadingCircleWidget(isLoading)
              ])));
    });
  }

  HealerLoginResponse? loginUser;
  Future<String?> loginHealer() async {
    isLoading = true;
    setState(() {});
    try {
      var data;
      print('loginHealer   ${prefs!.getString(StringUtils.type).toString()}');
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://trendychikitsa.com/api/login_user/'));

      //   request.headers.addAll(headers);
      request.fields['type'] = prefs!.getString(StringUtils.type).toString();
      request.fields['email_id'] = _emailController.text.toString().trim();
      request.fields['password'] = _passwordController.text.toString().trim();

      // var res = await request.send();

      request.send().then((result) async {
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
            if (prefs!.getString(StringUtils.type).toString() == "1") {
              if (data["status"] == "false" &&
                  (data["msg"] ==
                          "Please complete your profile to access your account." ||
                      data["msg"] ==
                          "Your account is not approved by the administration of this website. Please wait for admin approval." ||
                      data["msg"] ==
                          "Your account has been rejected by the administration of this website. Please contact administration for further discussion.")) {
                loginUser =
                    HealerLoginResponse.fromJson(jsonDecode(response.body));
                if (loginUser!.response == "pricing plan") {
                  showSnackBar(context, data["msg"]);
                  print(
                      '--vc->>?   ${loginUser!.healerData!.hLinks.toString()}');
                  prefs!
                      .setString(StringUtils.unique_id,
                          loginUser!.healerData!.hLinks.toString())
                      .toString();

                  prefs!.setString(StringUtils.completeProfile, "NO");
                  Future.delayed(const Duration(seconds: 2), () {
                    isLoading = false;
                    setState(() {});
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HealerPricingPlan()));
                  });
                } else if (data["status"] == "false" &&
                    loginUser!.response == "choose expertise") {
                  showSnackBar(context, data["msg"]);
                  prefs!
                      .setString(StringUtils.unique_id,
                          loginUser!.healerData!.hLinks.toString())
                      .toString();
                  prefs!.setString(StringUtils.completeProfile, "NO");

                  prefs!.setString(StringUtils.subscriptionPlan,
                      loginUser!.healerData!.subscriptionPlan.toString());
                  Future.delayed(const Duration(seconds: 2), () {
                    isLoading = false;
                    setState(() {});
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HealerChooseExperties()));
                  });
                } else if (data["status"] == "false" &&
                    loginUser!.response == "not approved" &&
                    data["msg"] ==
                        "Your account is not approved by the administration of this website. Please wait for admin approval.") {
                  prefs!.setString(StringUtils.completeProfile, "NO");
                  Future.delayed(const Duration(seconds: 2), () {
                    isLoading = false;
                    setState(() {});
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  });
                  showAlertDialog(context, data["msg"]);
                } else if (data["status"] == "false" &&
                    loginUser!.response == "profile rejected" &&
                    data["msg"] ==
                        "Your account has been rejected by the administration of this website. Please contact administration for further discussion.") {
                  prefs!.setString(StringUtils.completeProfile, "NO");
                  showAlertDialog(context, data["msg"]);
                  Future.delayed(const Duration(seconds: 2), () {
                    isLoading = false;
                    setState(() {});
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  });
                } else if (data["status"] == "true" &&
                    loginUser!.response == "login success" &&
                    data["msg"] == "Success!! Login successful.") {
                  prefs!
                      .setString(StringUtils.name,
                          loginUser!.healerData!.hName.toString())
                      .toString();
                  prefs!
                      .setString(StringUtils.email,
                          loginUser!.healerData!.hEmail.toString())
                      .toString();
                  prefs!
                      .setString(StringUtils.phoneNo,
                          loginUser!.healerData!.hTelephone.toString())
                      .toString();
                  prefs!
                      .setString(StringUtils.unique_id,
                          loginUser!.healerData!.hLinks.toString())
                      .toString();

                  prefs!
                      .setString(StringUtils.profile_image,
                          loginUser!.healerData!.hProfile.toString())
                      .toString();

                  prefs!
                      .setString(
                          StringUtils.id, loginUser!.healerData!.hId.toString())
                      .toString();
                  prefs!.setString(StringUtils.completeProfile, "YES");
                  showSnackBar(context, data["msg"]);
                  prefs!.setBool(StringUtils.loginINAPP, true);
                  Future.delayed(const Duration(seconds: 2), () {
                    isLoading = false;
                    setState(() {});
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Home_Menu()));
                  });
                }

                /*    prefs!.setString(
                StringUtils.name, registerUser.response!.hName.toString());

            prefs!.setString(StringUtils.loginINAPP, "YES");*/

                /* Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HealerPricingPlan()));
                });*/
              } else if (data["status"] == "true") {
                HealerLoginResponse loginUser =
                    HealerLoginResponse.fromJson(jsonDecode(response.body));
                if (data["status"] == "true" &&
                    loginUser.response == "login success") {
                  showSnackBar(context, data["msg"]);
                  prefs!
                      .setString(StringUtils.unique_id,
                          loginUser.healerData!.hLinks.toString())
                      .toString();
                  prefs!
                      .setString(StringUtils.profile_image,
                          loginUser.healerData!.hProfile.toString())
                      .toString();
                  prefs!
                      .setString(StringUtils.subscriptionPlan,
                          loginUser.healerData!.subscriptionPlan.toString())
                      .toString();
                  prefs!
                      .setString(
                          StringUtils.id, loginUser.healerData!.hId.toString())
                      .toString();
                  prefs!.setString(StringUtils.completeProfile, "YES");
                  showSnackBar(context, data["msg"]);
                  prefs!.setBool(StringUtils.loginINAPP, true);
                  Future.delayed(const Duration(seconds: 2), () {
                    isLoading = false;
                    setState(() {});
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Home_Menu()));
                  });
                } else {
                  showAlertDialog(context, data["msg"]);
                }
              } else {
                print('coming iside else 1');
                Future.delayed(const Duration(seconds: 1), () {
                  isLoading = false;
                  setState(() {});
                });
                showAlertDialog(context, data["msg"]);
              }
            } else if (prefs!.getString(StringUtils.type).toString() == "2") {
              if (data["status"] == "true" &&
                  data["msg"] == "Success!! Login successful.") {
                LoginClientResponse loginUser =
                    LoginClientResponse.fromJson(jsonDecode(response.body));
                prefs!.setString(
                    StringUtils.id, loginUser.clientData!.clId.toString());
                prefs!.setString(
                    StringUtils.name, loginUser.clientData!.clName.toString());
                prefs!.setString(StringUtils.email,
                    loginUser.clientData!.clEmail.toString());
                prefs!.setString(
                    StringUtils.name, loginUser.clientData!.clName.toString());
                prefs!.setString(StringUtils.mobile,
                    loginUser.clientData!.clTelephone.toString());
                prefs!.setString(
                    StringUtils.age, loginUser.clientData!.clAge.toString());
                prefs!.setString(StringUtils.gender,
                    loginUser.clientData!.clGender.toString());
                prefs!.setString(StringUtils.address,
                    loginUser.clientData!.clAddress.toString());
                prefs!.setString(StringUtils.zipcode,
                    loginUser.clientData!.clPin.toString());

                prefs!
                    .setString(StringUtils.profile_image,
                        loginUser.clientData!.clProfile.toString())
                    .toString();

                prefs!.setString(StringUtils.unique_id,
                    loginUser.clientData!.clLinks.toString());
                prefs!.setBool(StringUtils.loginINAPP, true);
                prefs!.setString(StringUtils.type, "2");
                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  setState(() {});
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Client_Home_Menu()));
                });
              } else {
                Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                  setState(() {});
                });
                showAlertDialog(context, data["msg"]);
              }
            }
          }

          return response.body;
        });
      }).catchError((err) {
        print('error : ' + err.toString());
        showSnackBar(context, err.toString());
        showAlertDialog(context, err.toString());
      }).whenComplete(() {});
    } catch (e) {
      showSnackBar(context, e.toString());
      showAlertDialog(context, e.toString());
      print(e);
    }
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
