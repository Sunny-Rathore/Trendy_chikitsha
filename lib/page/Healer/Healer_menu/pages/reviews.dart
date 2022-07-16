import 'package:flutter/material.dart';

class reviews extends StatefulWidget {
   reviews({Key? key}) : super(key: key);

  @override
  State<reviews> createState() => _reviewsState();
}

class _reviewsState extends State<reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5a146d),
        title: const Text('Reviews', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
