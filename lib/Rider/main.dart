import 'package:Lekhone/Rider/Rider_account_screen.dart';
import 'package:flutter/material.dart';
import 'DashboardScreen.dart'; // Import your Dashboard screen file
import 'MoneyScreen.dart';
import 'WalletScreen.dart';
import 'ProfileScreen.dart'; // Import your Profile screen file

void main() {
  runApp(RiderApp());
}

class RiderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    RiderDashboardScreen(),
    //LocationScreen(),
    //WalletScreen(),
    RiderAccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard,
                color: _selectedIndex == 0 ? Colors.black : Colors.grey),
            label: 'Dashboard',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.account_balance_wallet,
          //       color: _selectedIndex == 1 ? Colors.black : Colors.grey),
          //   label: 'My Wallet',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.attach_money,
          //       color: _selectedIndex == 2 ? Colors.black : Colors.grey),
          //   label: 'My Balance',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 3 ? Colors.black : Colors.grey),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
