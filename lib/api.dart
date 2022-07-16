import 'dart:convert';
import 'package:http/http.dart' as http;

String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJiMWZhOTM2Ni0zYWNiLTQyYWItOGJlNC0wZWZmMWFhMzcyMDAiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY1Nzg2NTg3MCwiZXhwIjoxNjU4NDcwNjcwfQ.wq590LD7HQLXlmJnbNMBfjLkIHx0x_P0MZa1Retk6xc";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v1/meetings"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['meetingId'];
}