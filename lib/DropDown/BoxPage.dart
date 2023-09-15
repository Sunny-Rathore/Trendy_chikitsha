import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';

import '../page/Client/ClientLogin.dart';
import '../page/Healer/Healer Register/Healer_Login.dart';
import '../utils/string_utils.dart';

class BoxPage extends StatefulWidget {
  const BoxPage({Key? key}) : super(key: key);

  @override
  State<BoxPage> createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    //  saveValue();

    super.initState();
    saveValue();
  }

  SharedPreferences? prefs;
  saveValue() async {
    //  storage = new FlutterSecureStorage();

    prefs = await SharedPreferences.getInstance();
    setState(() {});
    // _register();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    prefs!.setString(StringUtils.type, "2");
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClientLoginPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    //width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorUtils.trendyButtonColor),
                    child: Text(
                      "Client",
                      style: TextStyle(
                          color: ColorUtils.whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    prefs!.setString(StringUtils.type, "1");
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Healer_Login()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorUtils.trendyButtonColor),
                    child: Text(
                      "Healer",
                      style: TextStyle(
                          color: ColorUtils.whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
