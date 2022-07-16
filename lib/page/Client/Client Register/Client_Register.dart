import 'package:doctor/page/Client/Client_menu/pages/Client_Home_Menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import '../../../global/global.dart';
import '../Client_Home.dart';
import 'Client_Login.dart';

class Client_Register extends StatefulWidget {
  const Client_Register({Key? key}) : super(key: key);

  @override
  State<Client_Register> createState() => _Client_RegisterState();
}

class _Client_RegisterState extends State<Client_Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  static const emailRegex = r'\S+@\S+\.\S+';
  var isPasswordHidden = true.obs;
  bool isChecked = false;

  Widget _genderWidget(bool _showOther, bool _alignment) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: _showOther,
        verticalAlignedText: _alignment,
        onChanged: (Gender? _gender) {
          print(_gender);
          final messege = 'your selected Gender :- $_gender';
          Fluttertoast.showToast(msg: messege);
        },
        selectedGender: Gender.Male, //By Default
        selectedGenderTextStyle: const TextStyle(
            color: Color(0xFFC41A3B), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: const TextStyle(
            color: Color(0xFF1B1F32), fontWeight: FontWeight.bold),
        equallyAligned: true,
        size: 64.0, // default size 40.0
        animationDuration: const Duration(seconds: 1),
        isCircular: true, // by default true
        opacityOfGradient: 0.5,
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }

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
              title: const Text("Register"),
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
                            hintText: 'Full Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field cannot be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Mobile No',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field cannot be empty';
                            } else if (value.length < 10) {
                              return "must be at least 10 chars";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Age ',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.co_present),
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field cannot be empty';
                            } else if (value.length < 2) {
                              return "must be at least 2 chars";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _genderWidget(false,false),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Address ',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.pin_drop),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field cannot be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Pin Code ',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person_pin),
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 6,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field cannot be empty';
                            } else if (value.length < 6) {
                              return "must be at least 6 chars";
                            } else {
                              return null;
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: Colors.lightBlue,
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() => isChecked = value!);
                              },
                            ),
                            const Text('I agree to the Trendy Chikitsa')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: RichText(
                                  text:  TextSpan(
                                      text: 'Login',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.colorlal,
                                          decoration:
                                          TextDecoration.underline)
                                  )
                              ),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Client_Login()));
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
            ))
    );
  }
}
