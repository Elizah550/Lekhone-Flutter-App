// import 'package:Lekhone/screens/Homescreen/home_screen.dart';
// import 'package:Lekhone/screens/Onboarding/onboarding_screen.dart';
// import 'package:Lekhone/ui/views/home/home_screen_p.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:Lekhone/screens/Login/Login.dart';
// import 'package:Lekhone/screens/Login/onboard.dart';
// import 'package:Lekhone/screens/Signup/signup_screen.dart';

// class SplashScreen extends StatefulWidget {
//   static String routeName = 'SplashScreen';

//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     navigateUser();
//   }

//   Future<void> navigateUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//     String? phoneNumber = prefs.getString('phoneNumber');

//     Future.delayed(const Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) {
//             // if (isLoggedIn) {
//             //   return TrackerApp(); // Navigate to the dashboard screen
//             // }
//             // if (phoneNumber != null) {
//             //   print(phoneNumber);
//             //   return TrackerApp();
//             // }
//             // else {
//             //   return OnboardingScreen(); // Navigate to the onboarding screen
//             // }
//             // else {
//             //   return OnboardingScreen(); // Navigate to the onboarding screen
//             // }
//           },
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Lekhone',
//               // Add your text style here
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
