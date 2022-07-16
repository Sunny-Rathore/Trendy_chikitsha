import 'package:doctor/global/global.dart';
import 'package:flutter/material.dart';

class SelectedIssue extends StatefulWidget {
  const SelectedIssue({Key? key}) : super(key: key);

  @override
  State<SelectedIssue> createState() => _SelectedIssueState();
}

class _SelectedIssueState extends State<SelectedIssue> {

  String dropdownvalue = 'Selected';
  var items = ['Selected','All of the above','Anxiety','Carrier related issues','Child counselling',
    'Confidence issue','Corporate programs','Depression','Differently abled people','Excellence in academics',
    'Excellence in sports','Indecision','Memory and concentration issue','Parenting issues','Physical health and injury',
    'Planning, Curiosity, Problem solving ability','Public and peer relationships','Recruitment Analysis',
    'Sexual wellbeing','Sleep issues','Stress'];

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
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  dropdownvalue = newValue!;
                  setState(() {
                    // if (dropdownvalue == "Client") {
                    //   Fluttertoast.showToast(msg: 'Client');
                    // } else if (dropdownvalue == "Healer") {
                    //   Fluttertoast.showToast(msg: 'Healer');
                    // }
                  });
                },
                dropdownColor: AppColors.colorlal,
                isExpanded: true,
                elevation: 8,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
