
import 'package:doctor/page/Client/Client_menu/pages/client_change_password.dart';
import 'package:doctor/page/Client/Client_menu/pages/client_profile.dart';
import 'package:doctor/page/Client/Client_menu/pages/clients_appointments.dart';

import 'package:doctor/page/Client/Client_menu/pages/therapy_category.dart';
import 'package:doctor/page/LoginPage.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/size_util.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class NavDrawer extends StatefulWidget {
  String from_page = "", token = "";

  @override
  NavDrawerState createState() => NavDrawerState();

/*StudentDashboard({
    Key? key,
    required this.from_page, required this.token
  }) : super(key: key);*/
}

class NavDrawerState extends State<NavDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveValue();
  }

  saveValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Drawer(


        child: ListView(

          children: [
         /*   SizedBox(
                height: 32.h,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                         Color(0xff2b2b35),
                    Color(0xff2b2b35),
                      ],
                    ),
                  ),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        CircleAvatar(
                          backgroundColor: ColorUtils.gradientColor5,

                          radius: 50,
                          child: Text(
                            'Profile Pic',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ), //Text
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 1.h, left: 0, right: 0),
                            child: Text(
                                prefs != null
                                    ? prefs!
                                        .getString(StringUtils.s_name)
                                        .toString()
                                    : "---",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily:
                                        StringUtils.roboto_font_family_regular,
                                    color: Colors.white,
                                    fontSize: 18))),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 1.h, left: 0, right: 0),
                            child: Text(
                                prefs != null
                                    ? prefs!
                                        .getString(StringUtils.s_unique_id)
                                        .toString()
                                    : "---",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily:
                                        StringUtils.roboto_font_family_regular,
                                    color: Colors.white,
                                    fontSize: 18))),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 1.h, left: 0, right: 0),
                            child: Text(
                                prefs != null
                                    ? prefs!
                                        .getString(StringUtils.class_id)
                                        .toString()
                                    : "---",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily:
                                        StringUtils.roboto_font_family_regular,
                                    color: Colors.white,
                                    fontSize: 18))),
                      ])),
                )),*/
            DrawerListItem(
                text: "Home", icon_color: Colors.black, route: "Home"),
            DrawerListItem(
                text: "My Appointments",
                icon_color: Colors.black,
                route: "Appointments"),
            DrawerListItem(
                text: "Favourites",
                icon_color: Colors.black,
                route: "Favourites"),
            DrawerListItem(
                text: "Transactions",
                icon_color: Colors.black,
                route: "Transactions"),

            DrawerListItem(
                text: "Orders",
                icon_color: Colors.black,
                route: "Orders"),
            DrawerListItem(
                text: "Your Issues",
                icon_color: Colors.black,
                route: "Your Issues"),
            DrawerListItem(
                text: "ChangePassword",
                icon_color: Colors.black,
                route: "ChangePassword"),
            /* DrawerListItem(text: "Edit Profile", icon_color: Colors.black,
                route:"Edit Profile"),*/
            DrawerListItem(
                text: "Profile Setting", icon_color: Colors.black, route: "Profile Setting"),
            DrawerListItem(
                text: "Review",
                icon_color: Colors.black,
                route: "Review"),



            DrawerListItem(
                text: "Log Out", icon_color: Colors.black, route: "Log Out"),
          ],
        ),
      );
    });
  }
}

class DrawerListItem extends StatefulWidget {
  String from_page = "", token = "";
  late Color textcolor, color2, icon_color;
  late IconData icon;
  late String image, text, route, image_path;
  late FontWeight fontWeight;

  @override
  DrawerListItemState createState() => DrawerListItemState();

  DrawerListItem(
      {Key? key,
      required this.text,
      required this.icon_color,
      required this.route})
      : super(key: key);
}

class DrawerListItemState extends State<DrawerListItem> {
  late Color textcolor, color2, icon_color;
  late IconData icon;
  late String image, text, route, image_path;
  late FontWeight fontWeight;
  SharedPreferences? prefs;
  late BuildContext context1;


  bool close = false;

/*  DrawerListItem(String text, */ /* IconData icon*/ /* String image_path,
      Color icon_color, String route, BuildContext context) {
    this.context1 = context;
    this.route = route;
    this.text = text;

    this.icon_color = icon_color;
    this.image_path = image_path;
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    saveValue();
  }

  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    print(
        'patient id on method--    ${prefs!.getString(StringUtils.token).toString()}');
  }

  @override
  Widget build(BuildContext context1) {
    return ListTile(
      title: Text(
        widget.text,
        style: TextStyle(
            color: Colors.black,
            fontSize: DimenUtils.dimen_16,
            fontFamily: StringUtils.roboto_font_family),
      ),
      /*leading: SvgPicture.asset(image_path,
          color: ColorUtils.blackColor, semanticsLabel: 'A red up arrow'),*/
      /*IconButton(
        icon: Icon(
         */ /* Icons.assignment_turned_in_rounded*/ /*icon,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),*/
      onTap: () async {
        if (widget.route == "Home") {
         /* Navigator.pushAndRemoveUntil(
              context1,
              MaterialPageRoute(builder: (context) => StudentDashboard()),
              (route) => false);*/
        } else if (widget.route == "Appointments") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>ClientAppointments(),));
        } else if (widget.route == "ChangePassword") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClientChangePassword()));
        } else if (widget.route == "Profile Setting") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>ClientProfileSetting()));
        } else if (widget.route == "About Us") {
      /*    storage.write(key: StringUtils.current_page, value: "ABOUT");*/
        } else if (widget.route == "Privacy Policy") {
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentPrivacyPolicyPage()));*/
        } else if (widget.route == "Log Out") {
          prefs!.setString(StringUtils.completeProfile, "No");
          prefs!.setString(StringUtils.id, "");
          prefs!.setString(StringUtils.unique_id, "");
          prefs!.setString(StringUtils.type, "");
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => LoginPage(),
            ),
                (route) => false,//if you want to disable back feature set to false
          );
        }
      },
    );
  }

  showDeleteAlertDialog(BuildContext context2) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text('Not Now',
          textAlign: TextAlign.left,
          maxLines: 3,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: ColorUtils.appDarkBlueColor,
              fontSize: 18)),
      onPressed: () {
        close = false;

        Navigator.of(context2).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text('Yes',
          textAlign: TextAlign.left,
          maxLines: 3,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: ColorUtils.appDarkBlueColor,
              fontSize: 18)),
      onPressed: () {
        close = true;
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      /*    title: Text("AlertDialog"),
  */
      content: Text(
        "Are you sure you want to logout?",
        textAlign: TextAlign.center,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context2,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
