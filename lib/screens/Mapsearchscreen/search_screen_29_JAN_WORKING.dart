// import 'dart:async';
// import 'dart:convert';
// import 'package:Lekhone/core/app_export.dart';
// import 'package:Lekhone/screens/Maps/map_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_place/google_place.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Location {
//   final double? latitude;
//   final double? longitude;

//   Location({this.latitude, this.longitude});
// }

// class SearchScreen extends StatefulWidget {
//   final String orderId;
//   final String dropLocation;

//   const SearchScreen(
//       {Key? key, required this.orderId, required this.dropLocation})
//       : super(key: key);

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final _endSearchFieldController = TextEditingController();
//   Location? startPosition;
//   Location? endPosition;
//   late GooglePlace googlePlace;
//   List<AutocompletePrediction> predictions = [];
//   Timer? _debounce;
//   late StreamSubscription<Position> _locationSubscription;

//   @override
//   void initState() {
//     super.initState();
//     String apiKey =
//         'AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg'; // Replace with your Google Places API key
//     googlePlace = GooglePlace(apiKey);
//     _initLocation();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _endSearchFieldController.dispose();
//     _locationSubscription.cancel();
//   }

//   void _initLocation() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       _fetchUserLocation();
//     } else {
//       print('Location permission denied by user.');
//     }
//   }

//   void _fetchUserLocation() async {
//     final status = await Permission.location.status;
//     if (status.isGranted) {
//       try {
//         final position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );

//         setState(() {
//           startPosition = Location(
//             latitude: position.latitude,
//             longitude: position.longitude,
//           );
//         });

//         _locationSubscription = Geolocator.getPositionStream().listen(
//           (Position position) {
//             print(
//                 'Current Location: Latitude ${position.latitude}, Longitude ${position.longitude}');
//             // Send location updates to DynamoDB
//             _sendLocationUpdateToDynamoDB(
//                 position.latitude, position.longitude);
//           },
//         );
//       } catch (e) {
//         print(e.toString());
//       }
//     } else {
//       print('Location permission denied by user.');
//     }
//   }

//   Future<void> _sendLocationUpdateToDynamoDB(
//       double latitude, double longitude) async {
//     try {
//       final apiUrl =
//           'https://3go7iko8c1.execute-api.ap-south-1.amazonaws.com/Wh_Map_API';
//       final headers = {'Content-Type': 'application/json'};
//       final payload = {
//         'Map_id': 'YOUR_MAP_ID', // Replace with your actual Map_id
//         'Latitude': latitude,
//         'Longitude': longitude,
//       };

//       final response = await http.post(Uri.parse(apiUrl),
//           headers: headers, body: jsonEncode(payload));

//       if (response.statusCode == 200) {
//         print('Location update sent to DynamoDB successfully.');
//       } else {
//         print(
//             'Failed to send location update to DynamoDB. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error sending location update to DynamoDB: $e');
//     }
//   }

//   void autoCompleteSearch(String value) async {
//     var result = await googlePlace.autocomplete.get(value);
//     if (result != null && result.predictions != null && mounted) {
//       setState(() {
//         predictions = result.predictions!;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String orderId = widget.orderId;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: const BackButton(color: Colors.black),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: TextEditingController(text: widget.dropLocation),
//               // controller: _endSearchFieldController,
//               autofocus: false,
//               style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
//               decoration: InputDecoration(
//                 hintText: 'Enter destination',
//                 hintStyle: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13,
//                   fontFamily: 'Poppins',
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 border: InputBorder.none,
//                 suffixIcon: _endSearchFieldController.text.isNotEmpty
//                     ? IconButton(
//                         onPressed: () {
//                           setState(() {
//                             predictions = [];
//                             _endSearchFieldController.clear();
//                           });
//                         },
//                         icon: Icon(Icons.clear_outlined),
//                       )
//                     : null,
//               ),
//               onChanged: (value) {
//                 if (_debounce?.isActive ?? false) _debounce!.cancel();
//                 _debounce = Timer(const Duration(milliseconds: 1000), () {
//                   if (value.isNotEmpty) {
//                     autoCompleteSearch(value);
//                   } else {
//                     setState(() {
//                       predictions = [];
//                       endPosition = null;
//                     });
//                   }
//                 });
//               },
//             ),
//             //working--code
//             // TextField(
//             //   controller: _endSearchFieldController,
//             //   // controller: _endSearchFieldController,
//             //   autofocus: false,
//             //   style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
//             //   decoration: InputDecoration(
//             //     hintText: 'Enter destination',
//             //     hintStyle: TextStyle(
//             //       fontWeight: FontWeight.w500,
//             //       fontSize: 13,
//             //       fontFamily: 'Poppins',
//             //     ),
//             //     filled: true,
//             //     fillColor: Colors.grey[200],
//             //     border: InputBorder.none,
//             //     suffixIcon: _endSearchFieldController.text.isNotEmpty
//             //         ? IconButton(
//             //             onPressed: () {
//             //               setState(() {
//             //                 predictions = [];
//             //                 _endSearchFieldController.clear();
//             //               });
//             //             },
//             //             icon: Icon(Icons.clear_outlined),
//             //           )
//             //         : null,
//             //   ),
//             //   onChanged: (value) {
//             //     if (_debounce?.isActive ?? false) _debounce!.cancel();
//             //     _debounce = Timer(const Duration(milliseconds: 1000), () {
//             //       if (value.isNotEmpty) {
//             //         autoCompleteSearch(value);
//             //       } else {
//             //         setState(() {
//             //           predictions = [];
//             //           endPosition = null;
//             //         });
//             //       }
//             //     });
//             //   },
//             // ),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: predictions.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: CircleAvatar(
//                       child: Icon(
//                         Icons.pin_drop,
//                         color: Colors.red,
//                       ),
//                     ),
//                     title: Text(
//                       predictions[index].description.toString(),
//                       style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
//                     ),
//                     onTap: () async {
//                       final placeId = predictions[index].placeId!;
//                       final details = await googlePlace.details.get(placeId);
//                       if (details != null &&
//                           details.result != null &&
//                           details.result!.geometry != null &&
//                           details.result!.geometry!.location != null &&
//                           mounted) {
//                         setState(() {
//                           endPosition = Location(
//                             latitude:
//                                 details.result!.geometry!.location!.lat ?? 0.0,
//                             longitude:
//                                 details.result!.geometry!.location!.lng ?? 0.0,
//                           );
//                           _endSearchFieldController.text =
//                               details.result!.name!;
//                           predictions = [];
//                         });
//                       }

//                       if (startPosition != null && endPosition != null) {
//                         print('navigate');
//                         print('Order ID: $orderId');
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MapScreen(
//                               OrderId: orderId,
//                               startPosition: LatLng(
//                                 startPosition!.latitude ?? 0.0,
//                                 startPosition!.longitude ?? 0.0,
//                               ),
//                               endPosition: LatLng(
//                                 endPosition!.latitude ?? 0.0,
//                                 endPosition!.longitude ?? 0.0,
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
