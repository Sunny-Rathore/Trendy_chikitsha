import 'package:doctor/global/global.dart';
import 'package:doctor/page/Client/Client_menu/client_homepage.dart';
import 'package:doctor/page/Client/Client_menu/pages/client_change_password.dart';

import 'package:doctor/page/Client/Client_menu/pages/therapy_category.dart';
import 'package:doctor/page/Client/client_navigation.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Client_Home_Menu extends StatefulWidget {
  const Client_Home_Menu({Key? key}) : super(key: key);

  @override
  State<Client_Home_Menu> createState() => _Client_Home_MenuState();
}

class _Client_Home_MenuState extends State<Client_Home_Menu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      drawer:NavDrawer() ,


      appBar: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: 60,
        backgroundColor: ColorUtils.trendyThemeColor,
        elevation: 0.0,
        /*  automaticallyImplyLeading: false,*/
        title: Text('Home',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: StringUtils.roboto_font_family,
              color: ColorUtils.whiteColor,
              fontSize: 18,
            )),
        centerTitle: true,
        leading: GestureDetector(
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
                    }))),
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

      body: SafeArea(
        child:ClientHomePage()
      ),
    );
  }

  buildCard() => Container(
    width: 200,
    height: 200,
    color: Colors.red,
    child: Image.asset(""),
  );
}
