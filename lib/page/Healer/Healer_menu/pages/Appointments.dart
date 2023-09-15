import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/today_appointment.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Appointments extends StatefulWidget {
  final pageidex;
  const Appointments({Key? key, required this.pageidex}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return DefaultTabController(
          initialIndex: widget.pageidex,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorUtils.trendyThemeColor,
              title: Text('Appointments',
                  style: TextStyle(color: ColorUtils.whiteColor)),
              bottom: TabBar(
                labelColor: ColorUtils.whiteColor,
                indicatorColor: ColorUtils.whiteColor,
                labelStyle: const TextStyle(fontSize: 18.0),
                tabs: const [
                  Tab(
                    text: 'Today',
                  ),
                  Tab(
                    text: 'Upcoming',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                TodayAppointment(
                  tab_value: 'today',
                ),
                TodayAppointment(
                  tab_value: 'upcoming',
                ),
              ],
            ),
          ));
    });
  }
}
