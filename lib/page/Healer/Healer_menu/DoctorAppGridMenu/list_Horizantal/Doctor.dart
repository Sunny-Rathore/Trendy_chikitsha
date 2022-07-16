import 'package:flutter/material.dart';

class List_Horizantal extends StatefulWidget {
  const List_Horizantal({Key? key}) : super(key: key);

  @override
  State<List_Horizantal> createState() => _List_HorizantalState();
}

class _List_HorizantalState extends State<List_Horizantal> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // buildCard(),
        const SizedBox(width: 12,)
      ],
    );
  }

  buildCard() => Container(
    width: 200,
    height: 200,
    color: Colors.red,
  );
}
