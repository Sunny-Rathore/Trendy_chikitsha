import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trendy_chikitsa/models/healer_responses/hpmodel.dart';


class MyWidget extends StatefulWidget {
  final String hid;
  const MyWidget({Key? key, required this.hid}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  var mydata;
  Future getdata() async {
    var map = <String, dynamic>{};
    map['healer_id'] = widget.hid.toString();
    var response = await http.post(
        Uri.parse("https://trendychikitsa.com/api/healerprofile_detail"),
        body: map);
    if (response.statusCode == 200) {
      setState(() {
        mydata = UpdateHpmodel.fromJson(jsonDecode(response.body));
      });
      print(jsonEncode(mydata));
    }
  }

  // var mydata1;
  // Future gettoken() async {
  //   var response =
  //       await http.get(Uri.parse("https://trendychikitsa.com/api/get_token"));

  //   print("sunyy");
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       mydata = TokenModel.fromJson(jsonDecode(response.body));
  //     });
  //     print('Sunny');
  //     print(jsonEncode(mydata));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Material(
        child: SizedBox(
          height: 50,
          width: 50,
          child: mydata == null
              ? const Text("")
              : Image(
                  image: NetworkImage(
                  mydata.expertise[0].therapyCertificate1.toString(),
                )),
        ),
      ),
    );
  }
}
