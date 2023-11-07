// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_place/google_place.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../map_utils.dart'; // Import url_launcher

// class MapScreen extends StatefulWidget {
//   final DetailsResult? startPosition;
//   final DetailsResult? endPosition;

//   const MapScreen({Key? key, this.startPosition, this.endPosition})
//       : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   // ... (existing code)
//   late CameraPosition _initialPosition;
//   final Completer<GoogleMapController> _controller = Completer();
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _initialPosition = CameraPosition(
//       target: LatLng(widget.startPosition!.geometry!.location!.lat!,
//           widget.startPosition!.geometry!.location!.lng!),
//       zoom: 14.4746,
//     );
//   }

//   _addPolyLine() {
//     PolylineId id = const PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id,
//         color: Colors.black,
//         points: polylineCoordinates,
//         width: 1);
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   _getPolyline() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         'AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg',
//         PointLatLng(widget.startPosition!.geometry!.location!.lat!,
//             widget.startPosition!.geometry!.location!.lng!),
//         PointLatLng(widget.endPosition!.geometry!.location!.lat!,
//             widget.endPosition!.geometry!.location!.lng!),
//         travelMode: TravelMode.driving);
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     }
//     _addPolyLine();
//   }

//   // Function to open Google Maps with the destination
//   _openGoogleMaps() async {
//     final startLat = widget.startPosition!.geometry!.location!.lat;
//     final startLng = widget.startPosition!.geometry!.location!.lng;
//     final endLat = widget.endPosition!.geometry!.location!.lat;
//     final endLng = widget.endPosition!.geometry!.location!.lng;

//     final googleMapsUrl =
//         'https://www.google.com/maps/dir/?api=1&origin=$startLat,$startLng&destination=$endLat,$endLng&travelmode=driving';

//     if (await canLaunch(googleMapsUrl)) {
//       await launch(googleMapsUrl);
//     } else {
//       throw 'Could not launch $googleMapsUrl';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ... (existing code)
//     Set<Marker> markers = {
//       Marker(
//           markerId: const MarkerId('start'),
//           position: LatLng(widget.startPosition!.geometry!.location!.lat!,
//               widget.startPosition!.geometry!.location!.lng!)),
//       Marker(
//           markerId: const MarkerId('end'),
//           position: LatLng(widget.endPosition!.geometry!.location!.lat!,
//               widget.endPosition!.geometry!.location!.lng!))
//     };
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const CircleAvatar(
//             backgroundColor: Colors.white,
//             child: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             polylines: Set<Polyline>.of(polylines.values),
//             initialCameraPosition: _initialPosition,
//             markers: Set.from(markers),
//             onMapCreated: (GoogleMapController controller) {
//               Future.delayed(const Duration(milliseconds: 2000), () {
//                 controller.animateCamera(CameraUpdate.newLatLngBounds(
//                     MapUtils.boundsFromLatLngList(
//                         markers.map((loc) => loc.position).toList()),
//                     1));
//                 _getPolyline();
//               });
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: _openGoogleMaps,
//                 child: const Text("Let's Go"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg
