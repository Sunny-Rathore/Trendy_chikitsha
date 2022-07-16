import 'dart:ui';
import 'package:doctor/global/global.dart';
import 'package:doctor/page/Client/Client_menu/pages/Client_Home_Menu.dart';
import 'package:doctor/page/Healer/Healer_menu/Menu%20Pages/Home_Menu.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/contsants.dart';
import 'LoginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();

    saveValue();
  }

  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const LoginPage()));

    if (prefs!.getString(StringUtils.unique_id).toString().length != 0 &&
        prefs!.getString(StringUtils.type).toString() == "2") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Client_Home_Menu()));
    } else if (prefs!.getString(StringUtils.unique_id).toString().length != 0 &&
        prefs!.getString(StringUtils.type).toString() == "1" &&
        prefs!.getString(StringUtils.completeProfile).toString() == "YES") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home_Menu()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // ignore: avoid_unnecessary_containers
        body: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFed212a),
              Color(0xFF673996),
            ],
          )),
          child: Center(
              child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: AppColors.colorWhite,
                        height: 2,
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(
                          Constants.TRACEPHARM,
                          style: const TextStyle(
                              fontSize: 30,
                              fontFamily: 'Roboto-Bold',
                              // fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        color: AppColors.colorWhite,
                        height: 2,
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          "it's trendy to be healthy",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto-Bold',
                              // fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
