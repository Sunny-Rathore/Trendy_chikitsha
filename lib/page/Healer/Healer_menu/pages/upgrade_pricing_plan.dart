import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/pricing_plans_second.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UpgradePricingPlan extends StatefulWidget {
  const UpgradePricingPlan({Key? key}) : super(key: key);

  @override
  State<UpgradePricingPlan> createState() =>UpgradePricingPlanState();
}

class UpgradePricingPlanState extends State<UpgradePricingPlan> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorUtils.trendyThemeColor,
              title: Text('Upgrade Pricing Plans',
                  style: TextStyle(color: ColorUtils.whiteColor)),
              bottom: TabBar(
                isScrollable: true,
                labelColor: ColorUtils.whiteColor,
                indicatorColor: ColorUtils.whiteColor,
                labelStyle: const TextStyle(fontSize: 15.0),
                tabs: const [

                  Tab(
                    text: '3 MONTHS',
                  ),
                  Tab(
                    text: '6 MONTHS',
                  ),
                  Tab(
                    text: '1 YEAR',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [

                PricingDataSecond(tabNumber: '2',),
                PricingDataSecond(tabNumber: '3',),
                PricingDataSecond(tabNumber: '4',),
              ],
            ),
          ));
    });
  }


}
