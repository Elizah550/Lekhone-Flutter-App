// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _HomePageState();
// }

// class _HomePageState extends State<MapPage> {
//   Completer<GoogleMapController> _googleMapController = Completer();
//   CameraPosition? _cameraPosition;
//   Location? _location;
//   LocationData? _currentLocation;
//   Set<Polyline> _polylines = {};

//   @override
//   void initState() {
//     _init();
//     super.initState();
//   }

//   _init() async {
//     _location = Location();
//     _cameraPosition = CameraPosition(
//       target: LatLng(17.7447, 83.2319), // Initial camera position
//       zoom: 15,
//     );
//     _initLocation();
//   }

//   // function to listen when we move position
//   _initLocation() {
//     if (_polylines.isEmpty) {
//       // Set the start and end positions for the polyline
//       LatLng startLatLng = LatLng(17.7447, 83.2319);
//       LatLng endLatLng = LatLng(17.7401, 83.2519);

//       // Add a polyline between start and end positions
//       Polyline polyline = Polyline(
//         polylineId: PolylineId("polyline"),
//         color: Colors.blue,
//         width: 5,
//         points: [startLatLng, endLatLng],
//       );

//       setState(() {
//         _polylines.add(polyline);
//       });

//       moveToPosition(startLatLng);
//       moveMarker(startLatLng, endLatLng);
//     }

//     // use this to go to the current location instead
//     _location?.getLocation().then((location) {
//       _currentLocation = location;
//     });

//     _location?.onLocationChanged.listen((newLocation) {
//       _currentLocation = newLocation;
//       print(
//           "Updated Location: ${_currentLocation?.latitude}, ${_currentLocation?.longitude}");
//     });
//   }

//   moveMarker(LatLng start, LatLng end) {
//     double distance = Geolocator.distanceBetween(
//       start.latitude,
//       start.longitude,
//       end.latitude,
//       end.longitude,
//     );

//     const duration = Duration(seconds: 5);
//     double speed = distance / duration.inMilliseconds;

//     Timer.periodic(Duration(milliseconds: 16), (timer) {
//       double t = timer.tick / (duration.inMilliseconds / 16);
//       if (t >= 1.0) {
//         timer.cancel();
//       }

//       double lat = lerpDouble(start.latitude, end.latitude, t)!;
//       double lng = lerpDouble(start.longitude, end.longitude, t)!;

//       moveToPosition(LatLng(lat, lng));
//     });
//   }

//   moveToPosition(LatLng latLng) async {
//     GoogleMapController mapController = await _googleMapController.future;
//     mapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: latLng, zoom: 15),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildBody(),
//     );
//   }

//   Widget _buildBody() {
//     return _getMap();
//   }

//   Widget _getMarker() {
//     return Container(
//       width: 40,
//       height: 40,
//       padding: EdgeInsets.all(2),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(100),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey,
//             offset: Offset(0, 3),
//             spreadRadius: 4,
//             blurRadius: 6,
//           )
//         ],
//       ),
//       child: ClipOval(child: Image.asset("assets/profile.jpg")),
//     );
//   }

//   Widget _getMap() {
//     return Stack(
//       children: [
//         GoogleMap(
//           initialCameraPosition: _cameraPosition!,
//           mapType: MapType.normal,
//           onMapCreated: (GoogleMapController controller) {
//             if (!_googleMapController.isCompleted) {
//               _googleMapController.complete(controller);
//             }
//           },
//           polylines: _polylines,
//         ),
//         Positioned.fill(
//           child: Align(alignment: Alignment.center, child: _getMarker()),
//         ),
//       ],
//     );
//   }
// }
