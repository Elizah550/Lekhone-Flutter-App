// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

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

//   @override
//   void initState() {
//     super.initState();
//     _addMarker('start', widget.startPosition);
//     _addMarker('end', widget.endPosition);
//     _getPolyline();
//   }

//   void _addMarker(String markerId, LatLng position) {
//     _markers.add(
//       Marker(
//         markerId: MarkerId(markerId),
//         position: position,
//         icon: BitmapDescriptor.defaultMarker,
//       ),
//     );
//   }

//   Future<void> _getPolyline() async {
//     PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg', // Replace with your Google Maps API key
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
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openGoogleMaps,
//         child: const Icon(Icons.directions),
//       ),
//     );
//   }
// }
