// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart';

// class MapScreen extends StatefulWidget {
//   final LatLng startPosition;
//   final LatLng endPosition;

//   const MapScreen(
//       {Key? key, required this.startPosition, required this.endPosition})
//       : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController _controller;
//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polylines = {};
//   final PolylinePoints _polylinePoints = PolylinePoints();
//   final List<LatLng> _polylineCoordinates = [];
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();
//   BitmapDescriptor? _userIcon;
//   BitmapDescriptor? _boxIcon;
//   Position? _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     _loadCustomMarkers();
//     _getPolyline();
//     _startLocationUpdates();
//   }

//   void _loadCustomMarkers() async {
//     _userIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 2.5), 'assets/avatar.png');
//     _boxIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/box.png');
//   }

//   void _addMarker(String markerId, LatLng position, BitmapDescriptor icon) {
//     _markers.add(
//       Marker(
//         markerId: MarkerId(markerId),
//         position: position,
//         icon: icon,
//       ),
//     );
//   }

//   Future<void> _getPolyline() async {
//     PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg',
//       PointLatLng(
//           widget.startPosition.latitude, widget.startPosition.longitude),
//       PointLatLng(widget.endPosition.latitude, widget.endPosition.longitude),
//     );

//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     }

//     setState(() {
//       _polylines.add(
//         Polyline(
//           polylineId: const PolylineId("poly"),
//           color: Colors.black,
//           points: _polylineCoordinates,
//           width: 5,
//         ),
//       );
//     });
//   }

//   Future<void> _openGoogleMaps() async {
//     final startLat = widget.startPosition.latitude;
//     final startLng = widget.startPosition.longitude;
//     final endLat = widget.endPosition.latitude;
//     final endLng = widget.endPosition.longitude;

//     final googleMapsUrl =
//         'https://www.google.com/maps/dir/?api=1&origin=$startLat,$startLng&destination=$endLat,$endLng&travelmode=driving';

//     if (await canLaunch(googleMapsUrl)) {
//       await launch(googleMapsUrl);
//     } else {
//       throw 'Could not launch $googleMapsUrl';
//     }
//   }

//   void _startLocationUpdates() {
//     Geolocator.getPositionStream().listen((Position position) {
//       _sendLocationUpdateToSnackbar(position.latitude, position.longitude);
//       _updateUserMarker(position);
//       setState(() {
//         _currentPosition = position;
//       });
//     });
//   }

//   void _sendLocationUpdateToSnackbar(double latitude, double longitude) {
//     _showLocationUpdateSnackbar(
//       'Location Update',
//       'Latitude: $latitude, Longitude: $longitude',
//     );
//   }

//   void _showLocationUpdateSnackbar(String title, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 4),
//             Text(message),
//           ],
//         ),
//       ),
//     );
//   }

//   void _updateUserMarker(Position position) {
//     if (_userIcon != null && _boxIcon != null) {
//       setState(() {
//         _markers.clear(); // Clear all markers

//         // Add box.png marker at the end position
//         _addMarker('end', widget.endPosition, _boxIcon!);

//         // Add avatar.png marker at the start position
//         _addMarker('start', widget.startPosition, _userIcon!);

//         // Add user marker at the current position
//         _addMarker(
//             'user', LatLng(position.latitude, position.longitude), _userIcon!);

//         // Move the camera to the updated position
//         _controller.animateCamera(CameraUpdate.newLatLng(
//             LatLng(position.latitude, position.longitude)));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Screen'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: widget.startPosition,
//           zoom: 15,
//         ),
//         markers: _markers,
//         polylines: _polylines,
//         onMapCreated: (GoogleMapController controller) {
//           _controller = controller;
//           _mapController.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openGoogleMaps,
//         child: const Icon(Icons.directions),
//       ),
//     );
//   }
// }
