import 'package:Lekhone/Rider/main.dart';
import 'package:Lekhone/screens/Appointments/Appointments.dart';
import 'package:Lekhone/screens/Login/Login.dart';
import 'package:Lekhone/screens/Login/onboard.dart';
import 'package:Lekhone/screens/Maps/Delivery_map.dart';
import 'package:Lekhone/screens/Maps/Drag.dart';
import 'package:Lekhone/screens/Maps/home_page.dart';
import 'package:Lekhone/screens/Mapsearchscreen/search_screen.dart';
import 'package:Lekhone/screens/Onboarding/onboarding_screen.dart';
import 'package:Lekhone/screens/OrderDetails/dashboard.dart';
import 'package:Lekhone/screens/OrderDetails/single_order.dart';
// import 'package:Lekhone/screens/Rider/main.dart';
import 'package:Lekhone/screens/Signup/signup_screen.dart';
import 'package:Lekhone/screens/Task/task.dart';
import 'package:Lekhone/screens/Task/test.dart';
import 'package:Lekhone/screens/Track_Order/Track.dart';
import 'package:Lekhone/screens/order_details_in_transit_screen/models/recently_shipped_data_model.dart';
import 'package:Lekhone/screens/order_details_in_transit_screen/order_details_in_transit_screen.dart';
import 'package:Lekhone/screens/profile_page/profile_page.dart';
import 'package:Lekhone/screens/settings/account_screen.dart';
import 'package:Lekhone/screens/tracking_details_screen/tracking_details_screen.dart';
import 'package:Lekhone/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  //route name for our screen
  static String routeName = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //we use future to go from one screen to other via duration time
    Future.delayed(const Duration(seconds: 5), () async {
      //no return when user is on login screen and press back, it will not return the
      //user to the splash screen
      //signup screen
      // Navigator.pushNamedAndRemoveUntil(
      //     context, SignupScreen.routeName, (route) => false);
      //appointments screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => AppointmentsScreen(),
      //   ),
      // );
      //dashboard screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OrderTrackingScreen(),
      //   ),
      // );
      //track screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DeliveryDetailsPage(),
      //   ),
      // );
      //login screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => LoginScreen(),
      //   ),
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => LoginScreen(),
      //   ),
      // );
      //maps screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Deliveryapp(),
      //   ),
      // );
      //ticket screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Ticketapp(),
      //   ),
      // );
      //profile screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => AccountScreen(),
      //   ),
      // );
      //order details Dashboard---
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SingleOrder(),
      //   ),
      // );
      //Tracker app
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => MapPage(),
      //   ),
      // );
      //Tracker app
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TrackerApp()));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      //Tracker app
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => RiderApp(),
      //   ),
      // );
      //Tracking_details_screen:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => TrackingDetailsScreen(),
      //   ),
      // );
      //Profile page
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ProfilePage(),
      //   ),
      // );
      //Ridermapscreen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SearchScreen(),
      //   ),
      // );
      //Ridermapscreen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OnboardingScreen(),
      //   ),
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => FigmaToCodeApp(),
      //   ),
      // );
      //HomeContainerPage
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OnboardingScreen(),
      //   ),
      // );
      // Order details----screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OrderDetailsInTransitScreen(
      //       orderData: RecentlyShipped(
      //         'John Doe',
      //         '123456',
      //         '2024-01-26',
      //         'In Transit',
      //       ),
      //     ),
      //   ),
      // );
      //onboarding screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StartingOnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //scaffold color set to primary color in main in our text theme
    return Scaffold(
      //its a row with a column
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lekhone',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                // Text('Lekhone',
                //     style: Theme.of(context).textTheme.headlineSmall),
                //Text('House', style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            // Image.asset(
            //   'assets/images/Rhenix_1_Logo.png',
            //   //25% of height & 50% of width
            //   height: 25.h,
            //   width: 50.w,
            // ),
          ],
        ),
      ),
    );
  }
}

///////
///
///
///
///
/// 
///   void onTapMapPage() async{
  //                      try {
  //                       Map<String, dynamic>? data =
  //                           await Mapfetch(
  //                               Map_id: widget.tripId);

  //                       if (data != null) {
  //                         Map<String, dynamic>
  //                             responseData = data;
  //                         print("Received data: $data");

  //                         if (responseData['body'] !=
  //                                 null &&
  //                             responseData['body']
  //                                     ['Started'] !=
  //                                 null &&
  //                             responseData['body']
  //                                         ['Started']
  //                                     ['Longitude'] !=
  //                                 null) {
  //                           dynamic longitudeValue =
  //                               responseData['body']
  //                                       ['Started']
  //                                   ['Longitude'];

  //                           if (longitudeValue
  //                               is String) {
  //                             // Check if the value is a valid double
  //                             try {
  //                               double
  //                                   startedLongitudeNumeric =
  //                                   double.parse(
  //                                       longitudeValue);
  //                               print(
  //                                   'Started Longitude: $startedLongitudeNumeric');
  //                               print(
  //                                   "Here--for--testing");
  //                               print(
  //                                   responseData['body']
  //                                           ['Started']
  //                                       ['Latitude']);
  //                               var startlat =
  //                                   responseData['body']
  //                                           ['Started']
  //                                       ['Latitude'];
  //                               print(startlat);
  //                               var startlong =
  //                                   responseData['body']
  //                                           ['Started']
  //                                       ['Longitude'];
  //                               print(startlong);
  //                               var endlat =
  //                                   responseData['body']
  //                                           ['Ended']
  //                                       ['Latitude'];
  //                               var endlong =
  //                                   responseData['body']
  //                                           ['Ended']
  //                                       ['Longitude'];
  //                               var currentlat =
  //                                   responseData['body']
  //                                       ['Latitude'];
  //                               var currentlong =
  //                                   responseData['body']
  //                                       ['Longitude'];
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder:
  //                                       (context) =>
  //                                           MapPage(
  //                                     startLatitude:
  //                                         startlat,
  //                                     startLongitude:
  //                                         startlong,
  //                                     endLatitude:
  //                                         endlat,
  //                                     endLongitude:
  //                                         endlong,
  //                                     currentLatitude:
  //                                         currentlat,
  //                                     currentLongitude:
  //                                         currentlong,
  //                                   ),
  //                                 ),
  //                               );
  //                             } catch (e) {
  //                               print(
  //                                   'Error parsing longitude as double: $e');
  //                             }
  //                           } else {
  //                             print(
  //                                 'Error: Longitude is not a String');
  //                           }
  //                         } else {
  //                           print(
  //                               'Error: Longitude not found in the response');
  //                         }
  //                       } else {
  //                         print(
  //                             "Error: Mapfetch returned null");
  //                       }
  //                     } catch (e) {
  //                       print(
  //                           'Error fetching data: $e');
  //                     }
                                      
  // },