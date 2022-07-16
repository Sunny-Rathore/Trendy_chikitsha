
import 'package:doctor/global/global.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SelectTherapy extends StatefulWidget {
  const SelectTherapy({Key? key}) : super(key: key);

  @override
  State<SelectTherapy> createState() => _SelectTherapyState();
}

class _SelectTherapyState extends State<SelectTherapy> {

   var Url  = "https://trendychikitsa.com/api/all_therapies" ;

late String SelectedName;

  List data = [];

  Future getAllName()async {
    var response = await http.get(Uri.parse(Url),headers: {"Accept":"application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
    });

    print(jsonData);
    return "Success";

  }


@override
  void initState() {
    super.initState();
    getAllName();
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration:   BoxDecoration(
                  color: AppColors.colorJambli,
                  borderRadius: const BorderRadius.all( Radius.circular(10))),
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                    alignedDropdown:true,
                  child: DropdownButton(
                    value: SelectedName,
                    hint: const Text('Select Name'),
                    items: data.map((list) {
                      return DropdownMenuItem(child: Text(list['name']),
                      value: list['id'].toString(),
                      );
                    },).toList(),
                    onChanged: (value){
                      setState(() {
                        SelectedName = value.toString();
                      });
                    },
                  ),
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}
