import 'dart:async';
import 'dart:ui' as ui;
import 'package:Lekhone/screens/global.dart';
import 'package:Lekhone/screens/tracking_details_screen/tracking_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final String tripId;
  final String startLatitude;
  final String startLongitude;
  final String endLatitude;
  final String endLongitude;
  final String currentLatitude;
  final String currentLongitude;

  const MapPage({
    Key? key,
    required this.startLatitude,
    required this.startLongitude,
    required this.endLatitude,
    required this.endLongitude,
    required this.currentLatitude,
    required this.currentLongitude,
    required this.tripId,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _HomePageState();
}

class _HomePageState extends State<MapPage> {
  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  Location? _location;
  LocationData? _currentLocation;
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    _location = Location();
    _cameraPosition = CameraPosition(
      target: LatLng(
        double.tryParse(widget.startLatitude) ?? 0.0,
        double.tryParse(widget.startLongitude) ?? 0.0,
      ),
      zoom: 15,
    );
    _initLocation();
  }

  _initLocation() {
    if (_polylines.isEmpty) {
      LatLng startLatLng = LatLng(
        double.tryParse(widget.startLatitude) ?? 0.0,
        double.tryParse(widget.startLongitude) ?? 0.0,
      );
      LatLng endLatLng = LatLng(
        double.tryParse(widget.endLatitude) ?? 0.0,
        double.tryParse(widget.endLongitude) ?? 0.0,
      );

      Polyline polyline = Polyline(
        polylineId: PolylineId("polyline"),
        color: Colors.black,
        width: 5,
        points: [startLatLng, endLatLng],
      );

      setState(() {
        _polylines.add(polyline);
      });

      moveToPosition(startLatLng);
      moveMarker(startLatLng, endLatLng);
    }

    _location?.getLocation().then((location) {
      _currentLocation = location;
      moveToPosition(LatLng(
        double.tryParse(widget.currentLatitude) ?? 0.0,
        double.tryParse(widget.currentLongitude) ?? 0.0,
      ));
    });

    _location?.onLocationChanged.listen((newLocation) {
      _currentLocation = newLocation;
      print(
          "Updated Location: ${_currentLocation?.latitude}, ${_currentLocation?.longitude}");
      moveToPosition(LatLng(
        double.tryParse(widget.currentLatitude) ?? 0.0,
        double.tryParse(widget.currentLongitude) ?? 0.0,
      ));

      // Check if the current location reaches the end location
      if (_currentLocation!.latitude == double.tryParse(widget.endLatitude) &&
          _currentLocation!.longitude == double.tryParse(widget.endLongitude)) {
        // Display a button with "Send OTP" on a black background
        _displaySendOTPButton();
      }
    });
  }

  _displaySendOTPButton() {
    // Show a button with "Send OTP" on a black background
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: Text(
            'Send OTP',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Implement the functionality for sending OTP
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  moveMarker(LatLng start, LatLng end) {
    double distance = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );

    const duration = Duration(seconds: 5);
    double speed = distance / duration.inMilliseconds;

    Timer.periodic(Duration(milliseconds: 16), (timer) {
      double t = timer.tick / (duration.inMilliseconds / 16);
      if (t >= 1.0) {
        timer.cancel();
      }

      double lat = ui.lerpDouble(start.latitude, end.latitude, t)!;
      double lng = ui.lerpDouble(start.longitude, end.longitude, t)!;

      moveToPosition(LatLng(lat, lng));
    });
  }

  moveToPosition(LatLng latLng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrackingDetailsScreen(
                  tripId: '',
                ),
              ),
            );
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _cameraPosition!,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            if (!_googleMapController.isCompleted) {
              _googleMapController.complete(controller);
            }
          },
          polylines: _polylines,
          markers: {
            Marker(
              markerId: MarkerId('startMarker'),
              position: LatLng(
                double.tryParse(widget.startLatitude) ?? 0.0,
                double.tryParse(widget.startLongitude) ?? 0.0,
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(title: 'Start Point'),
            ),
            Marker(
              markerId: MarkerId('endMarker'),
              position: LatLng(
                double.tryParse(widget.endLatitude) ?? 0.0,
                double.tryParse(widget.endLongitude) ?? 0.0,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              infoWindow: InfoWindow(title: 'End Point'),
            ),
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {
                onTapMapPage(); // Reload the map or perform any action
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 3),
                  spreadRadius: 4,
                  blurRadius: 6,
                )
              ],
            ),
            child: ClipOval(child: Image.asset("assets/profile.jpg")),
          ),
        ),
      ],
    );
  }

  void onTapMapPage() async {
    try {
      Map<String, dynamic>? data = await Mapfetch(Map_id: widget.tripId);

      if (data != null) {
        Map<String, dynamic> responseData = data;
        print("Received data: $data");

        if (responseData['body'] != null &&
            responseData['body']['Started'] != null &&
            responseData['body']['Started']['Longitude'] != null) {
          dynamic longitudeValue = responseData['body']['Started']['Longitude'];

          if (longitudeValue is String) {
            // Check if the value is a valid double
            try {
              double startedLongitudeNumeric = double.parse(longitudeValue);
              print('Started Longitude: $startedLongitudeNumeric');
              print("Here--for--testing");
              print(responseData['body']['Started']['Latitude']);
              var startlat = responseData['body']['Started']['Latitude'];
              print(startlat);
              var startlong = responseData['body']['Started']['Longitude'];
              print(startlong);
              var endlat = responseData['body']['Ended']['Latitude'];
              var endlong = responseData['body']['Ended']['Longitude'];
              var currentlat = responseData['body']['Latitude'];
              var currentlong = responseData['body']['Longitude'];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(
                    tripId: widget.tripId,
                    startLatitude: startlat,
                    startLongitude: startlong,
                    endLatitude: endlat,
                    endLongitude: endlong,
                    currentLatitude: currentlat,
                    currentLongitude: currentlong,
                  ),
                ),
              );
            } catch (e) {
              print('Error parsing longitude as double: $e');
            }
          } else {
            print('Error: Longitude is not a String');
          }
        } else {
          print('Error: Longitude not found in the response');
        }
      } else {
        print("Error: Mapfetch returned null");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
