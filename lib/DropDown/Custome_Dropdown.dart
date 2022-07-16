import 'package:doctor/global/global.dart';
import 'package:doctor/page/Client/Client%20Register/Client_Login.dart';
import 'package:doctor/page/Healer/Choose%20Your%20Expertise/Choose_your_expertise.dart';
import 'package:doctor/page/Healer/Healer%20Register/Healer_Login.dart';
import 'package:doctor/page/Healer/Healer_menu/Payment/payment_mode.dart';
import 'package:doctor/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomeDropdown extends StatefulWidget {
  const CustomeDropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomeDropdown> createState() => _CustomeDropdownState();
}

class _CustomeDropdownState extends State<CustomeDropdown> {
  String dropdownvalue = 'Please Select Your Role';
  var items = ['Please Select Your Role', 'Client', 'Healer'];
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
    // _register();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration:   BoxDecoration(
            color: AppColors.colorJambli,
            borderRadius: const BorderRadius.all( Radius.circular(10))),
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width,
        child: DropdownButton(
          underline: const SizedBox(
            width: 0.1,
          ),
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  items,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() async {
              dropdownvalue = newValue!;

              if (dropdownvalue == "Client") {

                prefs!.setString(StringUtils.type,"2" );
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Healer_Login()),
                );
              } else if (dropdownvalue == "Healer") {
                prefs!.setString(StringUtils.type,"1" );
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Healer_Login()),
                );
              }
            });
          },
          dropdownColor: AppColors.colorlal,
          isExpanded: true,
          elevation: 8,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
