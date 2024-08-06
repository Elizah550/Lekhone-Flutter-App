import 'package:Lekhone/Rider/Login.dart';
import 'package:Lekhone/screens/Signup/Rider_signup_screen.dart';
import 'package:Lekhone/screens/Splashscreen/splash_screen.dart';
import 'package:Lekhone/ui/views/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:Lekhone/screens/Appointments/Appointments.dart';
import 'package:Lekhone/screens/Login/Login.dart';
import 'package:Lekhone/screens/OTP/otp.dart';
import 'package:Lekhone/screens/TrackOrder/Track_Order.dart';
import 'package:Lekhone/screens/Homescreen/home_screen.dart';
import 'package:Lekhone/screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RiderLoginScreen.routeName: (context) => RiderLoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  App.routeName: (context) => const App(),

  // HomeScreen_1.routeName: (context) => const HomeScreen_1(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  RiderSignupScreen.routeName: (context) => const RiderSignupScreen(),
  AppointmentsScreen.routeName: (context) => const AppointmentsScreen(),
  // OTPScreen.routeName: (context) => const OTPScreen(
  //       otp: '',
  //     ),
  Otp.routeName: (context) => const Otp(
        otp: '',
      ),
  TrackerApp.routeName: (context) => const TrackerApp(),
  //liveTrackingOneScreen.routeName: (context) => const liveTrackingOneScreen(),
};
