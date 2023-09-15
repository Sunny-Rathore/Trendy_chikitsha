import 'package:flutter/material.dart';

import '../../../../utils/color_utils.dart';

class CurrentPlanPage extends StatefulWidget {
  const CurrentPlanPage({Key? key}) : super(key: key);

  @override
  State<CurrentPlanPage> createState() => _CurrentPlanPageState();
}

class _CurrentPlanPageState extends State<CurrentPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.trendyThemeColor,
        title:
            const Text("Current Plan", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
    );
  }
}
