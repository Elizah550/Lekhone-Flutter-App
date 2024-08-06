// import 'package:Lekhone/Rider/Login.dart';
// import 'package:Lekhone/screens/Profile.dart';
// import 'package:Lekhone/screens/global.dart';
// import 'package:Lekhone/screens/settings/account_screen.dart';
// import 'package:Lekhone/ui/views/my_parcel/my_parcel_screen_ver_2.0.dart';
// import 'package:Lekhone/ui/views/my_parcel/my_parcel_screen_ver_3.0.dart';
// import 'package:Lekhone/ui/views/my_parcel/my_parcel_screen_working.dart';
// import 'package:Lekhone/utils/parcel_app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:Lekhone/ui/views/views.dart';
// import 'package:Lekhone/ui/widgets/widgets.dart';

// class TrackerApp extends StatelessWidget {
//   static String routeName = 'TrackerApp';
//   const TrackerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ParcelAppTheme.init(context: context);
//     return MaterialApp(
//       title: 'Parcel App',
//       debugShowCheckedModeBanner: false,
//       theme: ParcelAppTheme.getLightTheme,
//       home: const TrackerHomeScreen(),
//     );
//   }
// }

// class TrackerHomeScreen extends StatefulWidget {
//   static String routeName = 'TrackerHomeScreen';
//   const TrackerHomeScreen({Key? key}) : super(key: key);

//   @override
//   State<TrackerHomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<TrackerHomeScreen> {
//   int _currentIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   List<Widget> screens = [
//     MyParcelScreen(),
//     SendParcelScreen(),
//     ParcelCenterScreen(),
//     AccountScreen(),
//     // ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[_currentIndex],
//       bottomNavigationBar: CustomNavigationBar(
//         currentIndex: _currentIndex,
//         onItemTapped: _onItemTapped,
//       ),
//       // floatingActionButton: SizedBox(
//       //   height: 48,
//       //   child: FloatingActionButton(
//       //     backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       //     onPressed: () {
//       //       NativeCommunication.openActivity();
//       //     },
//       //     child: const Icon(
//       //       Icons.chat_bubble,
//       //       size: 20,
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
