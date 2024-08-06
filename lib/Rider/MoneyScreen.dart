import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:location/location.dart' as locationPackage;

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GooglePlace googlePlace;
  late TextEditingController destinationController;
  String apiKey = "YOUR_API_KEY"; // Replace with your Google Maps API key
  locationPackage.LocationData? currentLocation;
  locationPackage.Location location = locationPackage.Location();
  late LatLng sourceLocation;
  LatLng? destinationLocation;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(apiKey);
    destinationController = TextEditingController();
    getLocation();
  }

  @override
  void dispose() {
    destinationController.dispose();
    super.dispose();
  }

  void getLocation() async {
    locationPackage.LocationData locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
      sourceLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Source and Destination'),
      ),
      body: Column(
        children: [
          TextField(
            readOnly: true,
            controller: TextEditingController(
              text: 'Current Location',
            ),
            onTap: () {
              _navigateToMap(sourceLocation);
            },
          ),
          TextField(
            controller: destinationController,
            decoration: InputDecoration(
              labelText: 'Destination',
            ),
            onChanged: onSearchTextChanged,
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: sourceLocation,
                zoom: 14.0,
              ),
              markers: {
                if (currentLocation != null)
                  Marker(
                      markerId: MarkerId('source'), position: sourceLocation),
                if (destinationLocation != null)
                  Marker(
                      markerId: MarkerId('destination'),
                      position: destinationLocation!),
              },
              polylines: {
                if (destinationLocation != null)
                  Polyline(
                    polylineId: PolylineId('route'),
                    points: [sourceLocation, destinationLocation!],
                    color: Colors.blue,
                    width: 4,
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void onSearchTextChanged(String value) async {
    if (value.isNotEmpty) {
      // Import necessary classes for AutocompleteResponse and DetailsResponse
      AutocompleteResponse? response =
          await googlePlace.autocomplete.get(value);
      if (response != null &&
          response.predictions != null &&
          response.predictions!.isNotEmpty) {
        AutocompletePrediction prediction = response.predictions!.first;
        displayPrediction(prediction);
      }
    }
  }

  void displayPrediction(AutocompletePrediction prediction) async {
    DetailsResponse? detail =
        await googlePlace.details.get(prediction.placeId!);
    if (detail != null &&
        detail.result != null &&
        detail.result!.geometry != null &&
        detail.result!.geometry!.location != null) {
      setState(() {
        destinationLocation = LatLng(
          detail.result!.geometry!.location!.lat!,
          detail.result!.geometry!.location!.lng!,
        );
        _navigateToMap(destinationLocation!);
        destinationController.text = prediction.description ?? '';
      });
    }
  }

  void _navigateToMap(LatLng location) {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: location,
      zoom: 14.0,
    )));
  }
}
