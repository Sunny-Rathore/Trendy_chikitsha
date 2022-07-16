import 'package:doctor/page/Client/Client_menu/pages/Client_Home_Menu.dart';
import 'package:flutter/material.dart';

class Client_Home extends StatefulWidget {
  const Client_Home({Key? key}) : super(key: key);

  @override
  State<Client_Home> createState() => _Client_HomeState();
}

class _Client_HomeState extends State<Client_Home> {
  @override
  Widget build(BuildContext context) {
    return const Client_Home_Menu();
  }
}
