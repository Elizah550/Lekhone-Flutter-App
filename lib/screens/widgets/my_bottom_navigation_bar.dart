import 'package:Lekhone/screens/TrackOrder/Track_Order.dart';
import 'package:Lekhone/screens/parcel_center_screen.dart';
import 'package:Lekhone/screens/send_parcel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   print("Selected Index: $_selectedIndex");
  // }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: Theme.of(context).textTheme.headlineSmall,
        unselectedLabelStyle: Theme.of(context).textTheme.headlineSmall,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/icon_my_parcels.svg',
              color: _selectedIndex == 0
                  ? Colors.black // Set your desired color for the selected item
                  : Theme.of(context).unselectedWidgetColor,
            ),
            label: 'My parcels',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/icon_send_parcel.svg',
              color: _selectedIndex == 1
                  ? Colors.black // Set your desired color for the selected item
                  : Theme.of(context).unselectedWidgetColor,
            ),
            label: 'Send parcel',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/icon_parcel_center.svg',
              color: _selectedIndex == 2
                  ? Colors.black // Set your desired color for the selected item
                  : Theme.of(context).unselectedWidgetColor,
            ),
            label: 'Parcel center',
          ),
        ],
        currentIndex: _selectedIndex,
        // unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        // selectedItemColor: Colors.black,
        // onTap: _onItemTapped,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            print(index);
            if (index == 0) {
              print("Entered 0 : $index");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const App(),
                ),
              );
            } else if (index == 1) {
              print("Entered 1 : $index");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SendParcelScreen(),
                ),
              );
            } else if (index == 2) {
              print("Entered 2 : $index");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParcelApp(),
                ),
              );
            }
          });
        }

        // Add logic to navigate to the corresponding screen
        // switch (index) {
        //   case 0:
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const App(),
        //       ),
        //     );
        //     break;
        //   case 1:
        //     Navigator.pushReplacementNamed(context, '/send_parcel');
        //     break;
        //   case 2:
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const ParcelApp(),
        //       ),
        //     );
        //     break;
        //   default:
        //     break;
        // }
        // },
        );
  }
}

//=====================================>>>>>>>>>>>>>>
// import 'package:Lekhone/screens/TrackOrder/Track_Order.dart';
// import 'package:Lekhone/screens/parcel_center_screen.dart';
// import 'package:Lekhone/screens/send_parcel_detail_screen.dart';
// import 'package:Lekhone/screens/send_parcel_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class MyBottomNavigationBar extends StatefulWidget {
//   const MyBottomNavigationBar({Key? key}) : super(key: key);

//   @override
//   _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
// }

// class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     // Add navigation logic here
//     switch (index) {
//       case 0:
//         // Navigator.pushReplacementNamed(context, '/myParcels');
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const App(),
//           ),
//         );
//         break;
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const SendParcelScreen(),
//           ),
//         );
//         // Navigator.pushReplacementNamed(context, '/sendParcel');
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const ParcelApp(),
//           ),
//         );
//         // Navigator.pushReplacementNamed(context, '/parcelCenter');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       selectedFontSize: 12,
//       unselectedFontSize: 12,
//       selectedLabelStyle: Theme.of(context).textTheme.headline5,
//       unselectedLabelStyle: Theme.of(context).textTheme.headline5,
//       items: <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: _selectedIndex == 0
//               ? SvgPicture.asset('assets/images/icon_my_parcels.svg')
//               : SvgPicture.asset('assets/images/icon_my_parcels_grey.svg'),
//           label: 'My parcels',
//         ),
//         BottomNavigationBarItem(
//           icon: _selectedIndex == 1
//               ? SvgPicture.asset('assets/images/icon_send_parcel.svg')
//               : SvgPicture.asset('assets/images/icon_send_parcel_grey.svg'),
//           label: 'Send parcel',
//         ),
//         BottomNavigationBarItem(
//           icon: _selectedIndex == 2
//               ? SvgPicture.asset('assets/images/icon_parcel_center.svg')
//               : SvgPicture.asset('assets/images/icon_parcel_center_grey.svg'),
//           label: 'Parcel center',
//         ),
//       ],
//       currentIndex: _selectedIndex,
//       unselectedItemColor: Theme.of(context).unselectedWidgetColor,
//       selectedItemColor: Colors.black,
//       onTap: _onItemTapped,
//     );
//   }
// }
