import 'package:flutter/material.dart';

class invoice extends StatefulWidget {
   const invoice({Key? key}) : super(key: key);

  @override
  State<invoice> createState() => _invoiceState();
}

class _invoiceState extends State<invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd08b57),
        title: const Text('Invoice', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
