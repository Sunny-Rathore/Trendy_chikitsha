import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trendy_chikitsa/models/tokenModel.dart';

var mydata;
Future gettoken() async {
  var response =
      await http.get(Uri.parse("https://trendychikitsa.com/api/get_token"));
  if (response.statusCode == 200) {
    mydata = TokenModel.fromJson(jsonDecode(response.body));
  }
}

String token = mydata.response.toString();

// 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJlY2ZiZjA5Ny1jNGM0LTQyMzMtYTlhZS1hMDY0YjgyYzBjZWUiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY2NjM2MTczOCwiZXhwIjoxNjY2OTY2NTM4fQ.rPfbhxmmvd9LoZTzSnElcuEod6nCJYJBwqLYiWCIAQk';

//  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJiMWZhOTM2Ni0zYWNiLTQyYWItOGJlNC0wZWZmMWFhMzcyMDAiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY2MzA2Mjc3NiwiZXhwIjoxNjYzNjY3NTc2fQ.9ng1xtqvFEMGKHpt5X9LLwy1h-BdfJ0L3aRwxomQ858";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v1/meetings"),
    headers: {'Authorization': token},
  );
  print('json check   ${json.decode(httpResponse.body)['meetingId']}');
  return json.decode(httpResponse.body)['meetingId'];
}
