import 'package:doctor/global/global.dart';
import 'package:doctor/page/Client/Client%20Register/Client_Register.dart';
import 'package:flutter/material.dart';

class SelectedPage extends StatefulWidget {
  const SelectedPage({Key? key}) : super(key: key);

  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  late TextEditingController _client;

  @override
  void initState() {
    super.initState();
    _client = TextEditingController(text: "Client");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.colorJambli,
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HI There, We are glad that\n you choose us!",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Roboto-Bold',
                            color: AppColors.colorWhite),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "We will be happy to address all your healthcare related problems,our expert doctors are always available to provide world class medical services. you can meet doctor's over a video call as well.",
                          style: TextStyle(
                              fontFamily: 'Roboto-Light',
                              fontSize: 14,
                              color: AppColors.colorWhite,
                              fontWeight: FontWeight.w200),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    readOnly: true,
                    autofocus: false,
                    style: TextStyle(fontSize: 20, color: AppColors.colorWhite),
                    controller: _client,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                        labelText: " Login Type ",
                        labelStyle:
                            const TextStyle(fontSize: 22, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.white)),
                        border: const OutlineInputBorder(),
                        fillColor: AppColors.colorWhite,
                        focusColor: AppColors.colorWhite,
                        hoverColor: AppColors.colorWhite),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColors.colorWhite,
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto-Light',
                              color: AppColors.colorlal),
                        ),
                      ),
                    ),
                      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => const Client_Register()));
                      }
                  ),
                ],
              ),
            ))
    );
  }
}
