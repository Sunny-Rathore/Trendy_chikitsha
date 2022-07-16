import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/global/global.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/Appointments.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/Schedule_Timings.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/change_password.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/healer_profile.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/invoice.dart';

import 'package:doctor/page/Healer/Healer_menu/pages/reviews.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/social_media.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/transactions.dart';
import 'package:doctor/page/LoginPage.dart';
import 'package:doctor/utils/color_utils.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Menu extends StatefulWidget {
  const Home_Menu({Key? key}) : super(key: key);

  @override
  State<Home_Menu> createState() => _Home_MenuState();
}

class _Home_MenuState extends State<Home_Menu> {
  SharedPreferences? prefs;
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

  }


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(animated: true),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
      extendBody: true,
      drawer: Drawer(
        backgroundColor: ColorUtils.trendyThemeColor,
        child: ListView(
          children: [
            const SizedBox(height: 70,),
           ListTile(
             leading: const Icon(Icons.home,size: 30, color: Colors.white,),
             title: const Text("Home",style: TextStyle(fontSize: 16,color: Colors.white),),
             trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => const Home_Menu()));
             },
           ),
            ListTile(
              leading: const Icon(Icons.date_range,size: 30,color: Colors.white),
              title: const Text("Appointments",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Appointments()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_clock,size: 30,color: Colors.white),
              title: const Text("ChangePassword",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  HealerChangePassword()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt,size: 30,color: Colors.white),
              title: const Text("Invoice",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  invoice()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings,size: 30,color: Colors.white),
              title: const Text("Profile",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileSetting()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.reviews,size: 30,color: Colors.white),
              title: const Text("Review",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  reviews()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule,size: 30,color: Colors.white),
              title: const Text("Schedule",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Schedule_Timings()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.interests,size: 30,color: Colors.white),
              title: const Text("Social Media",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  SocialMedia()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history,size: 30,color: Colors.white),
              title: const Text("Transaction",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  transactions()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history,size: 30,color: Colors.white),
              title:  Text("Log Out",style: TextStyle(fontSize: 16,color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
              onTap: (){
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

              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: ColorUtils.trendyThemeColor,
        title: const Text("Home",style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 50,
          buttonBackgroundColor: Colors.blue,
          color: Colors.lightGreen,
          items:   const [
            Icon(Icons.home, size: 30,),
            Icon(Icons.list, size: 30,),
            Icon(Icons.compare_arrows,),
          ],
          onTap: (index) {
            //Handle button tap
            // if(index == 0){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) =>  PaymentPage()));
            // } else if (index == 1){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) =>  Appointments()));
            // } else if(index == 2){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) =>  social_media()));
            // }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CarouselSlider(
                  items: [

                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://media.istockphoto.com/photos/meeting-with-counsellor-at-home-picture-id1156717929?k=20&m=1156717929&s=612x612&w=0&h=T1pkjQGDkx86dMUqC1cX3l948PFG2bLa3PXgBC74y-k="),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          image: NetworkImage("https://media.istockphoto.com/photos/the-power-of-the-mind-picture-id1354246900?s=612x612"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //3rd Image of Slider
                    Container(
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://media.istockphoto.com/photos/shot-of-an-older-woman-doing-light-exercises-during-a-session-with-a-picture-id1338886069?b=1&k=20&m=1338886069&s=170667a&w=0&h=ine67Au5FZro-2hLCEW_Cx81kOIOIC4E-XqjP3ispoc="),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //4th Image of Slider
                    Container(
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://media.istockphoto.com/photos/making-profile-picture-id1279101502?k=20&m=1279101502&s=612x612&w=0&h=5OSs6uePmnkVTCPz0OGCTtpH_S5oQ8fZDLMJqX8I6tQ="),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //5th Image of Slider
                    Container(
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://media.istockphoto.com/photos/there-are-many-fun-ways-to-learn-picture-id1166330501?k=20&m=1166330501&s=612x612&w=0&h=VcvEDu0or-cSjxyEQIM1FWpCReXQ9vq1ZXQN4nRa39c="),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),



               /* Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft,
                      colors: [
                        AppColors.colorlal,
                        AppColors.colorJambli,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Quick Access',
                              style: TextStyle(
                                fontSize: 24,
                                color: AppColors.colorWhite,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 90,
                            width: 90,
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.schedule,color: Colors.white,size: 35,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: const Text(
                                        'Schedule',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 90,
                            width: 90,
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.date_range,color: Colors.white,size: 35,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: const Text(
                                        'Appointment',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 90,
                            width: 90,
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.account_circle_rounded,color: Colors.white,size: 35,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: const Text(
                                        'Profile',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),*/

                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child:  Text("WHO WE ARE",style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorbargandi,
                        decoration: TextDecoration.underline,
                      ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text('Hola healers!!!!! Trendy Chikitsa facilitates healers to focus on their aim to heal as many souls as '
                          'possible. We at Trendy Chikitsa, are committed to bring seekers to your doorstep. We will leave no stone '
                          'unturned in order to fulfil this objective. We need to ensure that alternative healing therapies are'
                          'propagated positively to the farthest habitat. So Healers, join us and make this world more beautiful.',
                        style: TextStyle(fontSize: 14,color: AppColors.colorBlack),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient:  LinearGradient(
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft,
                      colors: [
                        Colors.red.shade300,
                        Colors.yellow.shade500,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text("WHY CHOOSE TRENDY CHIKITSA",style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorJambli),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          Column(
                            children:  [
                              SizedBox(
                                width: MediaQuery.of(context).size.width /4,
                                child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset('assets/images/handshake.png')
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:   [
                              SizedBox(
                                width: MediaQuery.of(context).size.width /2,
                                child: const Center(
                                  child: Text("Connect with Seekers",style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.black
                                  ),),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width /1.7,
                                child: const Center(
                                  child: Text("Find and help believers with your healing abilities via Trendy Chikitsa.",style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black
                                  ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          Column(
                            children:  [
                              const SizedBox(height: 10,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width /4,
                                child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset('assets/images/home.png')
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:   [
                              SizedBox(
                                width: MediaQuery.of(context).size.width /2,
                                child: const Center(
                                  child: Text("Sharpen your Healing Skills",style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.black
                                  ),),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width /1.7,
                                child: const Center(
                                  child: Text("Trendy Chikitsa brings you in contact with a wide "
                                      "variety of seekers who motivate you to stay updated in your field and enhance your expertise.",style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black
                                  ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          Column(
                            children:  [
                              Container(
                                width: MediaQuery.of(context).size.width /4,
                                child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset('assets/images/hong.png')
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:   [
                              SizedBox(
                                width: MediaQuery.of(context).size.width /2,
                                child: const Center(
                                  child: Text("Showcase your Therapy",style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.black
                                  ),),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width /1.7,
                                child: const Center(
                                  child: Text("Find success through Trendy Chikitsa. Heal our esteemed clients and become a master of your trade.",style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black
                                  ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          Column(
                            children:  [
                              Container(
                                width: MediaQuery.of(context).size.width /4,
                                child: SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset('assets/images/box.png')
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:   [
                              SizedBox(
                                width: MediaQuery.of(context).size.width /2,
                                child: const Center(
                                  child: Text("Choose your own Working Hours",style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.black
                                  ),),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width /1.7,
                                child: const Center(
                                  child: Text("Be your own boss and heal seekers in your own time. No pressure!",style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black
                                  ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
