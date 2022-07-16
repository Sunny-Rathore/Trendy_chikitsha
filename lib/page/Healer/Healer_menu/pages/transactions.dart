import 'package:flutter/material.dart';

class transactions extends StatefulWidget {
   transactions({Key? key}) : super(key: key);

  @override
  State<transactions> createState() => _transactionsState();
}

class _transactionsState extends State<transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd2be40),
        title: const Text('Transactions', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
