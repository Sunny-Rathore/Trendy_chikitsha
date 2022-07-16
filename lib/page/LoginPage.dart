
import 'package:doctor/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../DropDown/Custome_Dropdown.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //DateTime timeBackPress = DateTime.now();

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
    return /*WillPopScope(
      onWillPop: _onWillPop,
      child:*/ SafeArea(
        child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text("Meet Your healthcare\n experts under one roof !",style: TextStyle(
                fontSize: 25,
                fontFamily: 'Roboto-Bold',
                color: AppColors.colorlal,
                // fontWeight: FontWeight.bold
              ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 10,
              ),
               Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("with the help of our intelligent algorithms now find experienced specialist doctor with expert ratings and reviews and book yourself appointment and medicines hassle-free even if you cant go to the hospital book a hospital book a video with the doctor."
                  ,style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto-Light',
                    fontWeight: FontWeight.w200,
                    color: AppColors.colorlal,
                ),textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 20,
              ),
              const CustomeDropdown()
            ],
          ),
        ),
        ),

    );
  }
}
