// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MapScreen(),
//     );
//   }
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Map Screen'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (controller) {
//               mapController = controller;
//             },
//             initialCameraPosition: CameraPosition(
//               // target: LatLng(YourInitialLatitude, YourInitialLongitude),
//               zoom: 15.0,
//             ),
//             markers: {
//               Marker(
//                 markerId: MarkerId('bikeMarker'),
//                 // position: LatLng(YourBikeLatitude, YourBikeLongitude),
//                 icon: BitmapDescriptor.defaultMarkerWithHue(
//                     BitmapDescriptor.hueYellow),
//               ),
//             },
//           ),
//           DraggableScrollableSheet(
//             initialChildSize: 0.2,
//             minChildSize: 0.1,
//             maxChildSize: 0.8,
//             builder: (context, scrollController) {
//               return Container(
//                 padding: EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.0),
//                     topRight: Radius.circular(20.0),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Order Details',
//                         style: TextStyle(
//                           color: Colors.yellow,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       // Add your order details widgets here
//                       // Example: Text('Order: Your order details'),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
