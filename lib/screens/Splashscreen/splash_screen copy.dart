// // import 'package:Warehouse/screens/screens.dart';
// import 'package:Warehouse/screens/Signup/signup_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SplashScreen extends StatefulWidget {
//   //route name for our screen
//   static String routeName = 'SplashScreen';

//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //we use future to go from one screen to other via duration time
//     Future.delayed(const Duration(seconds: 5), () {
//       //no return when user is on login screen and press back, it will not return the
//       //user to the splash screen
//       Navigator.pushNamedAndRemoveUntil(
//           context, SignupScreen.routeName, (route) => false);
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => const ParcelApp(),
//       //   ),
//       // );
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => const TrackerApp(),
//       //   ),
//       // );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //scaffold color set to primary color in main in our text theme
//     return Scaffold(
//       //its a row with a column
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Lekhone',
//                   style: GoogleFonts.poppins(
//                     textStyle: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                 ),
//                 // Text('Lekhone',
//                 //     style: Theme.of(context).textTheme.headlineSmall),
//                 //Text('House', style: Theme.of(context).textTheme.headlineSmall),
//               ],
//             ),
//             // Image.asset(
//             //   'assets/images/Rhenix_1_Logo.png',
//             //   //25% of height & 50% of width
//             //   height: 25.h,
//             //   width: 50.w,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
