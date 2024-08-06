import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  final LatLng startPosition;
  final LatLng endPosition;
  final String OrderId;
  const MapScreen({
    Key? key,
    required this.startPosition,
    required this.endPosition,
    required this.OrderId,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final PolylinePoints _polylinePoints = PolylinePoints();
  final List<LatLng> _polylineCoordinates = [];
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  BitmapDescriptor? _userIcon;
  BitmapDescriptor? _boxIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
    _getPolyline();
    _startLocationUpdates();
    _updateInitialLocationInDB(); // Add this line to update the initial location
  }

  void _loadCustomMarkers() async {
    _userIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/avatar.png');
    _boxIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/box_1.png');
  }

  void _addMarker(String markerId, LatLng position, BitmapDescriptor icon) {
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        icon: icon,
      ),
    );
  }

  Future<void> _getPolyline() async {
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg',
      PointLatLng(
          widget.startPosition.latitude, widget.startPosition.longitude),
      PointLatLng(widget.endPosition.latitude, widget.endPosition.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("poly"),
          color: Colors.black,
          points: _polylineCoordinates,
          width: 5,
        ),
      );
    });
  }

  void _startLocationUpdates() {
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      Geolocator.getCurrentPosition().then((position) {
        _updateUserMarker(position);
        _updateLocationInDB(position.latitude, position.longitude);
        _showLocationUpdateSnackbar(
          'Location Update',
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
        );
        if (_isCloseToDestination(position)) {
          timer.cancel(); // Stop the timer when close to the destination
        }
      });
    });

    // Show success snackbar only when status code is 200
    // Timer.periodic(Duration(seconds: 6), (Timer timer) {
    //   _showSuccessSnackbar();
    // });
  }

  bool _isCloseToDestination(Position position) {
    const double thresholdDistance = 20.0;
    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      widget.endPosition.latitude,
      widget.endPosition.longitude,
    );
    return distance <= thresholdDistance;
  }

  void _updateUserMarker(Position position) {
    if (_userIcon != null && _boxIcon != null) {
      setState(() {
        _markers.clear(); // Clear all markers

        // Add box.png marker at the end position
        _addMarker('end', widget.endPosition, _boxIcon!);

        // Add avatar.png marker at the start position
        _addMarker('start', widget.startPosition, _userIcon!);

        // Add user marker at the current position
        _addMarker(
            'user', LatLng(position.latitude, position.longitude), _userIcon!);

        // Move the camera to the updated position
        _controller.animateCamera(
          CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
        );
      });
    }
  }
  //Working maps screen code
  // Future<void> _updateLocationInDB(double latitude, double longitude) async {
  //   const apiUrl =
  //       'https://3go7iko8c1.execute-api.ap-south-1.amazonaws.com/Wh_Map_API';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: jsonEncode({
  //         'Latitude': "${widget.endPosition.latitude}",
  //         'Longitude': "${widget.endPosition.longitude}"
  //       }),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('Location updated in DynamoDB: $response');

  //       final responseBody = jsonDecode(response.body);
  //       print(
  //           'Map_id: ${responseBody['Map_id']}'); // Log the Map_id from Lambda

  //       _showSuccessSnackbarWithMapId(responseBody['Map_id']);
  //     } else {
  //       _showFailureSnackbar();
  //       print('Error updating location in DynamoDB: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     // _showFailureSnackbar();
  //     print('Error updating location in DynamoDB: $e');
  //   }
  // }
  // not working map screen code
  // Future<void> _updateLocationInDB(double latitude, double longitude) async {
  //   final apiUrl =
  //       'https://3go7iko8c1.execute-api.ap-south-1.amazonaws.com/Wh_Map_API';

  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     body: jsonEncode({
  //       'Latitude': latitude,
  //       'Longitude': longitude,
  //     }),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     print('Location updated in DynamoDB: $response');
  //     _showSuccessSnackbar();
  //   } else {
  //     _showFailureSnackbar();
  //     print('Error updating location in DynamoDB: ${response.statusCode}');
  //   }
  //   // catch (e) {
  //   //   print('Error updating location in DynamoDB: $e');
  //   // }
  // }
  //testing
  // Future<void> _updateLocationInDB(double latitude, double longitude) async {
  //   const apiUrl =
  //       'https://3go7iko8c1.execute-api.ap-south-1.amazonaws.com/Wh_Map_API';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: jsonEncode({
  //         'Started': {
  //           'Latitude': "${widget.startPosition.latitude}",
  //           'Longitude': "${widget.startPosition.longitude}",
  //           'PlaceName': startPlace,
  //         },
  //         'Ended': {
  //           'Latitude': "${widget.endPosition.latitude}",
  //           'Longitude': "${widget.endPosition.longitude}",
  //           'PlaceName': endPlace,
  //         },
  //         'Latitude': "${widget.endPosition.latitude}",
  //         'Longitude': "${widget.endPosition.longitude}",
  //         'Timestamp': _getCurrentTimestamp(),
  //       }),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('Location updated in DynamoDB: $response');

  //       final responseBody = jsonDecode(response.body);
  //       print(
  //           'Map_id: ${responseBody['Map_id']}'); // Log the Map_id from Lambda

  //       _showSuccessSnackbarWithMapId(responseBody['Map_id']);
  //     } else {
  //       _showFailureSnackbar();
  //       print('Error updating location in DynamoDB: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     // _showFailureSnackbar();
  //     print('Error updating location in DynamoDB: $e');
  //   }
  // }
  //Testing-2.0
  Future<void> _updateLocationInDB(double latitude, double longitude) async {
    final startApiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?'
        'latlng=${widget.startPosition.latitude},${widget.startPosition.longitude}'
        '&key=AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg';

    final endApiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?'
        'latlng=${widget.endPosition.latitude},${widget.endPosition.longitude}'
        '&key=AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg';

    try {
      final startResponse = await http.get(Uri.parse(startApiUrl));
      final endResponse = await http.get(Uri.parse(endApiUrl));

      if (startResponse.statusCode == 200 && endResponse.statusCode == 200) {
        final startDecodedData = jsonDecode(startResponse.body);
        final endDecodedData = jsonDecode(endResponse.body);

        final startResults = startDecodedData['results'] as List;
        final endResults = endDecodedData['results'] as List;

        if (startResults.isNotEmpty && endResults.isNotEmpty) {
          final startPlaceName = startResults[0]['formatted_address'];
          final endPlaceName = endResults[0]['formatted_address'];

          final apiUrl =
              'https://3go7iko8c1.execute-api.ap-south-1.amazonaws.com/Wh_Map_API';

          final response = await http.post(
            Uri.parse(apiUrl),
            body: jsonEncode({
              'Trip_id': widget.OrderId,
              'Started': {
                'Latitude': "${widget.startPosition.latitude}",
                'Longitude': "${widget.startPosition.longitude}",
                'PlaceName': startPlaceName,
              },
              'Ended': {
                'Latitude': "${widget.endPosition.latitude}",
                'Longitude': "${widget.endPosition.longitude}",
                'PlaceName': endPlaceName,
              },
              'Latitude': "${widget.endPosition.latitude}",
              'Longitude': "${widget.endPosition.longitude}",
              'Timestamp': _getCurrentTimestamp(),
            }),
            headers: {
              'Content-Type': 'application/json',
            },
          );

          if (response.statusCode == 200) {
            final responseBody = jsonDecode(response.body);
            print('Location updated in DynamoDB: $response');
            print('Map_id: ${responseBody['Map_id']}');

            // _showSuccessSnackbarWithMapIdAndPlaceNames(
            //   responseBody['Map_id'],
            //   startPlaceName,
            //   endPlaceName,
            // );
            _showSuccessSnackbarWithMapId(responseBody['Map_id']);
          } else {
            _showFailureSnackbar();
            print(
                'Error updating location in DynamoDB: ${response.statusCode}');
            print('Response body: ${response.body}');
          }
        } else {
          _showFailureSnackbar();
          print('Error: No results found for the given coordinates.');
        }
      } else {
        _showFailureSnackbar();
        print(
            'Error updating location in DynamoDB: ${startResponse.statusCode}');
        print('Response body: ${startResponse.body}');
      }
    } catch (e) {
      _showFailureSnackbar();
      print('Error updating location in DynamoDB: $e');
    }
  }

  String _getCurrentTimestamp() {
    final ist = DateTime.now().toUtc().add(Duration(hours: 5, minutes: 30));
    return '${ist.year}-${_twoDigits(ist.month)}-${_twoDigits(ist.day)} '
        '${_twoDigits(ist.hour)}:${_twoDigits(ist.minute)}:${_twoDigits(ist.second)} IST';
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  void _updateInitialLocationInDB() {
    // Update initial location in the database
    _updateLocationInDB(
      widget.startPosition.latitude,
      widget.startPosition.longitude,
    );
  }

  void _showLocationUpdateSnackbar(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(message),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackbarWithMapId(String mapId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'Data success Map_id: $mapId\nLatitude: ${widget.endPosition.latitude}, Longitude: ${widget.endPosition.longitude}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showSuccessSnackbar() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(
  //             Icons.check_circle,
  //             color: Colors.green,
  //           ),
  //           SizedBox(width: 8),
  //           Text(
  //             'Data uploaded successfully!',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Colors.green,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _showFailureSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.red,
            ),
            SizedBox(width: 8),
            Text(
              'Not triggered !',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openGoogleMaps() async {
    final startLat = widget.startPosition.latitude;
    final startLng = widget.startPosition.longitude;
    final endLat = widget.endPosition.latitude;
    final endLng = widget.endPosition.longitude;

    final googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$startLat,$startLng&destination=$endLat,$endLng&travelmode=driving';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.startPosition,
          zoom: 15,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          _mapController.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openGoogleMaps();
          _updateLocationInDB(
            widget.endPosition.latitude,
            widget.endPosition.longitude,
          );
        },
        child: const Icon(Icons.directions),
      ),
    );
  }
}
