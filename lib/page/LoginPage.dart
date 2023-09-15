import 'package:trendy_chikitsa/DropDown/BoxPage.dart';
import 'package:trendy_chikitsa/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return /*WillPopScope(
      onWillPop: _onWillPop,
      child:*/
        SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 200,
              //   width: 200,
              //   child: Image(image: AssetImage(" Doctor/assets/images")),
              // ),
              Text(
                "Meet Your Holistic healing\n experts under one roof !",
                style: TextStyle(
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
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "With the help of our intelligent algorithms now find experienced specialist  healer with expert ratings and reviews and book yourself appointment  hassle-free with the Healers.",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Roboto-Light',

                    /* fontWeight: FontWeight.w200,*/
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Please Select Your Role',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto-Bold',
                    color: AppColors.colorlal,
                    // fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const BoxPage()
              //  const CustomeDropdown()
            ],
          ),
        ),
      ),
    );
  }
}
