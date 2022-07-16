import 'package:doctor/page/Client/Client%20Register/Client_Login.dart';
import 'package:flutter/material.dart';

import '../../../global/global.dart';
import '../Client_Home.dart';

class Client_Forgotpass extends StatefulWidget {
  const Client_Forgotpass({Key? key}) : super(key: key);

  @override
  State<Client_Forgotpass> createState() => _Client_ForgotpassState();
}

class _Client_ForgotpassState extends State<Client_Forgotpass> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              brightness: Brightness.dark,
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text("Forgot Password"),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: [AppColors.colorlal, AppColors.colorJambli],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (RegExp(emailRegex).hasMatch(value!)) {
                            } else if (value.isEmpty) {
                              return 'field cannot be empty';
                            } else {
                              return "Email is not correctly formatted";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Client_Login()));
                            } else {
                              return;
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.colorJambli,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: AppColors.colorWhite,
                                    fontFamily: 'Roboto',
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
    );
  }
}
