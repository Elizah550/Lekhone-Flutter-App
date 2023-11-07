import 'package:flutter/cupertino.dart';
import 'package:Warehouse/screens/Appointments.dart';
import 'package:Warehouse/screens/Login.dart';
import 'package:Warehouse/screens/OTP_screen.dart';
import 'package:Warehouse/screens/home_screen.dart';
import 'package:Warehouse/screens/signup_screen.dart';
import 'package:Warehouse/screens/splash_screen.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  AppointmentsScreen.routeName: (context) => const AppointmentsScreen(),
  OTPScreen.routeName: (context) => const OTPScreen(
        otp: '',
      ),
};
