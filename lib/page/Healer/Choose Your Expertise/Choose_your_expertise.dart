import 'dart:io';
import 'package:doctor/global/global.dart';
import 'package:doctor/page/Healer/Choose%20Your%20Expertise/selected%20issue/Selected_issue.dart';
import 'package:doctor/page/Healer/Healer_menu/Menu%20Pages/Home_Menu.dart';
import 'package:doctor/page/Healer/Healer_menu/pages/paymentpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'Select Therapy/Select_therapy.dart';

class ChooseYourExpertise extends StatefulWidget {
  const ChooseYourExpertise({Key? key}) : super(key: key);

  @override
  State<ChooseYourExpertise> createState() => _ChooseYourExpertiseState();
}

class _ChooseYourExpertiseState extends State<ChooseYourExpertise> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  File? image;

  Future pickImage() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    }on PlatformException catch (e){
      print('Failed $e');
    }

  }


  @override
  Widget build(BuildContext context) {





    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorBlack)
                  ),
                  child: Column(
                  children:  [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                    ),
                    Text('Choose Your Expertise',
                      style: TextStyle(
                          color: AppColors.colorJambli,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Select Issues',
                      style: TextStyle(
                        color: AppColors.colortameti,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SelectedIssue(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration:  InputDecoration(
                          labelText: 'Experience (In Year)',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            )
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration:  InputDecoration(
                            labelText: 'Experience (In Month)',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            )
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    // SelectTherapy(),

                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration:   BoxDecoration(
                              color: AppColors.colorJambli,
                              borderRadius: const BorderRadius.all( Radius.circular(10))),
                          child:  Center(child: Text('Upload Therapy Certificate',style: TextStyle(
                            color: AppColors.colorWhite
                          ),)),
                          ),
                      ),
                      onTap: (){
                        pickImage();
                      },
                    ),
                    // Text('Select Therapy',
                    //   style: TextStyle(
                    //       color: AppColors.colortameti,
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold
                    //   ),
                    // ),
                    // const SelectTherapy()
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration:   BoxDecoration(
                              color: AppColors.colortameti,
                              borderRadius: const BorderRadius.all( Radius.circular(10))),
                          child: Center(
                            child: Text("Continue",style: TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: 20
                            ),
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const Home_Menu()),
                        );
                      },
                    )
                  ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
