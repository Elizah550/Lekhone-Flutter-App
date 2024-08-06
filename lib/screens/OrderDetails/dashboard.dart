// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:Lekhone/utils/constants.dart';
// import 'package:Lekhone/screens/widgets/latest_orders.dart';
// import 'package:Lekhone/screens/widgets/location_slider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Initialize ScreenUtil
//     ScreenUtil.init(
//       designSize: Size(360, 690),
//       allowFontScaling: false,
//     );

//     return MaterialApp(
//       title: 'Your App',
//       home: Dashboard(),
//     );
//   }
// }

// class Dashboard extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   // Track active index
//   int activeIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Constants.scaffoldBackgroundColor,
//         buttonBackgroundColor: Constants.primaryColor,
//         items: [
//           Icon(
//             EvaIcons.home,
//             size: 30.0,
//             color: activeIndex == 0 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//           Icon(
//             EvaIcons.pinOutline,
//             size: 30.0,
//             color: activeIndex == 1 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//           Icon(
//             EvaIcons.plus,
//             size: 30.0,
//             color: activeIndex == 2 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//           Icon(
//             EvaIcons.heartOutline,
//             size: 30.0,
//             color: activeIndex == 3 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//           Icon(
//             EvaIcons.settingsOutline,
//             size: 30.0,
//             color: activeIndex == 4 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             activeIndex = index;
//           });
//         },
//       ),
//       backgroundColor: Constants.primaryColor,
//       body: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             right: 0.0,
//             top: -20.0,
//             child: Opacity(
//               opacity: 0.3,
//               child: Image.asset(
//                 "assets/images/washing_machine_illustration.png",
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: kToolbarHeight,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 16.0,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Icon(
//                             EvaIcons.arrowBackOutline,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "Welcome Back,\n",
//                                     style: Theme.of(context)
//                                         ?.textTheme
//                                         ?.headline6
//                                         ?.copyWith(
//                                           color: Colors.white,
//                                         ),
//                                   ),
//                                   TextSpan(
//                                     text: "FlutterPanda!",
//                                     style: Theme.of(context)
//                                         ?.textTheme
//                                         ?.headline6
//                                         ?.copyWith(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Image.asset(
//                               "assets/images/dp.png",
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50.0,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     constraints: BoxConstraints(
//                       minHeight: MediaQuery.of(context).size.height - 200.0,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30.0),
//                         topRight: Radius.circular(30.0),
//                       ),
//                       color: Constants.scaffoldBackgroundColor,
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       vertical: 24.0,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 24.0,
//                           ),
//                           child: Text(
//                             "New Locations",
//                             style: TextStyle(
//                               color: Color.fromRGBO(19, 22, 33, 1),
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 7.0),
//                         Container(
//                           height: ScreenUtil().setHeight(100.0),
//                           child: Center(
//                             // lets make a widget for the cards
//                             child: LocationSlider(),
//                           ),
//                         ),
//                         LatestOrders(),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
