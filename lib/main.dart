import 'dart:io';

import 'package:trendy_chikitsa/page/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
/*  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }*/
}

void main() async {
/*  HttpOverrides.global = new MyHttpOverrides();*/
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      /*   home: VideoSDKQuickStart(),*/

      home: const SplashScreen(),
    );
  }
}/*
class VideoSDKQuickStart extends StatefulWidget {
  const VideoSDKQuickStart({Key? key}) : super(key: key);

  @override
  State<VideoSDKQuickStart> createState() => _VideoSDKQuickStartState();
}

class _VideoSDKQuickStartState extends State<VideoSDKQuickStart> {
  String meetingId = "";
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VideoSDK QuickStart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMeetingActive
            ? MeetingScreen(
          meetingId: meetingId,
          token: token,
          leaveMeeting: () {
            setState(() => isMeetingActive = false);
          },
        )
            : JoinScreen(
          onMeetingIdChanged: (value) => meetingId = value,
          onCreateMeetingButtonPressed: () async {
            meetingId = await createMeeting();
            setState(() => isMeetingActive = true);
          },
          onJoinMeetingButtonPressed: () {
            setState(() => isMeetingActive = true);
          },
        ),
      ),
    );
  }


}*/
