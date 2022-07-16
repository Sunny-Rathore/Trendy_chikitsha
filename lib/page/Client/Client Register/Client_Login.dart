import 'package:doctor/page/Client/Client_menu/pages/Client_Home_Menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/global.dart';
import 'Client_Forgotpass.dart';
import '../Client_Home.dart';
import 'Client_Register.dart';

class Client_Login extends StatefulWidget {
  const Client_Login({Key? key}) : super(key: key);

  @override
  State<Client_Login> createState() => _Client_LoginState();
}

class _Client_LoginState extends State<Client_Login> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = true.obs;
  bool isChecked = false;

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
              title: const Text("Login"),
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
                        Obx(
                              () => TextFormField(
                            obscureText: isPasswordHidden.value,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.lock),
                                suffix: InkWell(
                                  child: Icon(
                                    isPasswordHidden.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    isPasswordHidden.value =
                                    !isPasswordHidden.value;
                                  },
                                )),
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field cannot be empty';
                              } else if (value.length < 5) {
                                return "must be at least 6 chars";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, right: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                      fontSize: 16, color: AppColors.colorlal),
                                ),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                          const Client_Forgotpass()));
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Register',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.colorlal,
                                          decoration:
                                          TextDecoration.underline))),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                        const Client_Register()));
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Client_Home_Menu()));
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
            )));
  }
}
