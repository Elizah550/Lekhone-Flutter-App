import 'package:Lekhone/screens/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:Lekhone/screens/Profile.dart';
import 'package:Lekhone/screens/global.dart';
import 'package:Lekhone/screens/settings/account_screen.dart';
import 'package:Lekhone/ui/views/my_parcel/my_parcel_screen_ver_2.0.dart';
import 'package:Lekhone/ui/views/my_parcel/my_parcel_screen_ver_3.0.dart';
import 'package:Lekhone/ui/views/my_parcel/my_parcel_screen_working.dart';
import 'package:Lekhone/utils/parcel_app_theme.dart';
import 'package:Lekhone/ui/views/views.dart';
import 'package:Lekhone/ui/widgets/widgets.dart';

class TrackerApp extends StatelessWidget {
  static String routeName = 'TrackerApp';
  const TrackerApp({Key? key});

  @override
  Widget build(BuildContext context) {
    ParcelAppTheme.init(context: context);
    return MaterialApp(
      title: 'Parcel App',
      debugShowCheckedModeBanner: false,
      theme: ParcelAppTheme.getLightTheme,
      home: const TrackerHomeScreen(),
    );
  }
}

class TrackerHomeScreen extends StatefulWidget {
  static String routeName = 'TrackerHomeScreen';
  const TrackerHomeScreen({Key? key}) : super(key: key);

  @override
  State<TrackerHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TrackerHomeScreen> {
  int _currentIndex = 0;

  Future<bool> _onWillPop() async {
    bool shouldLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              // Perform logout or any other action
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }

    return false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> screens = [
    MyParcelScreen(),
    SendParcelScreen(),
    ParcelCenterScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
