import 'package:flutter/material.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Image(
      image: AssetImage(
          'assets/images/WhatsApp Image 2022-10-01 at 5.52.09 PM.jpeg'),
    ));
  }
}
