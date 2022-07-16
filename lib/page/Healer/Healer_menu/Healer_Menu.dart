// import 'package:doctor/page/Healer/Healer_menu/data/menuitems.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/Appointments.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/Schedule_Timings.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/change_password.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/invoice.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/paymentpage.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/profile_settings.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/reviews.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/social_media.dart';
// import 'package:doctor/page/Healer/Healer_menu/pages/transactions.dart';
// import 'package:doctor/page/Healer/Healer_menu/screens/menuscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
//
//
// class Healer_Menu extends StatefulWidget {
//   const Healer_Menu({Key? key}) : super(key: key);
//
//   @override
//   State<Healer_Menu> createState() => _Healer_MenuState();
// }
//
// class _Healer_MenuState extends State<Healer_Menu> {
//   MenuItem currentItem = MenuItems.Home;
//   @override
//   Widget build(BuildContext context) {
//
//     return Expanded(
//       child: ZoomDrawer(
//         borderRadius: 50,
//         angle: -10,
//         showShadow: true,
//         backgroundColor: Colors.red,
//         style: DrawerStyle.Style1,
//         mainScreen: getScreen(),
//         menuScreen: Builder(
//           builder: (context) => MenuScreen(
//               currentItem: currentItem,
//               onSelectedItem: (item) {
//                 setState(() => currentItem = item);
//                 ZoomDrawer.of(context)!.close();
//               }),
//         ),
//       ),
//
//     );
//   }
//
//   Widget getScreen() {
//     switch (currentItem) {
//       case MenuItems.Home:
//         return PaymentPage();
//       case MenuItems.appointments:
//         return  Appointments();
//       case MenuItems.schedule_timings:
//         return  Schedule_Timings();
//       case MenuItems.invoice:
//         return  invoice();
//       case MenuItems.transactions:
//         return  transactions();
//       case MenuItems.reviews:
//         return  reviews();
//       case MenuItems.profile_settings:
//         return  profile_settings();
//       case MenuItems.social_media:
//         return  social_media();
//       case MenuItems.change_password:
//         return  change_password();
//
//       default:
//         return PaymentPage();
//     }
//   }
//
//
// }
