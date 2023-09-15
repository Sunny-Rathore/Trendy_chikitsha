import 'package:trendy_chikitsa/page/Healer/Healer_menu/pages/pricing_plans.dart';
import 'package:trendy_chikitsa/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HealerPricingPlan extends StatefulWidget {
  const HealerPricingPlan({Key? key}) : super(key: key);

  @override
  State<HealerPricingPlan> createState() => HealerPricingPlanState();
}

class HealerPricingPlanState extends State<HealerPricingPlan> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorUtils.trendyThemeColor,
              title: Text('Pricing Plans',
                  style: TextStyle(color: ColorUtils.whiteColor)),
              bottom: TabBar(
                isScrollable: true,
                labelColor: ColorUtils.whiteColor,
                indicatorColor: ColorUtils.whiteColor,
                labelStyle: const TextStyle(fontSize: 15.0),
                tabs: const [
                  Tab(
                    text: 'FREE TRIAL\n(1 MONTH)',
                  ),
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
                PricingData(
                  tabNumber: '1',
                ),
                PricingData(
                  tabNumber: '2',
                ),
                PricingData(
                  tabNumber: '3',
                ),
                PricingData(
                  tabNumber: '4',
                ),
              ],
            ),
          ));
    });
  }
}
