import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Warehouse/screens/map_screen.dart';
import 'package:google_place/google_place.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final double? latitude;
  final double? longitude;

  Location({this.latitude, this.longitude});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _endSearchFieldController = TextEditingController();
  Location? startPosition;
  Location? endPosition;
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey =
        'AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg'; // Replace with your Google Places API key
    googlePlace = GooglePlace(apiKey);
    // Request location permissions and fetch user's live location
    _initLocation();
  }

  @override
  void dispose() {
    super.dispose();
    _endSearchFieldController.dispose();
  }

  void _initLocation() async {
    // Request location permissions
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Location permission granted, fetch user's live location
      _fetchUserLocation();
    } else {
      // Handle when the user denies location permission
      print('Location permission denied by user.');
    }
  }

  void _fetchUserLocation() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        // Use the user's current location as the start position
        setState(() {
          startPosition = Location(
            latitude: position.latitude,
            longitude: position.longitude,
          );
        });
      } catch (e) {
        // Handle other location access errors here
        print(e.toString());
      }
    } else {
      // Handle when the user denies location permission
      print('Location permission denied by user.');
    }
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _endSearchFieldController,
              autofocus: false,
              style: const TextStyle(fontSize: 24),
              decoration: InputDecoration(
                hintText: 'End Point',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                suffixIcon: _endSearchFieldController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            predictions = [];
                            _endSearchFieldController.clear();
                          });
                        },
                        icon: const Icon(Icons.clear_outlined),
                      )
                    : null,
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    // Places API
                    autoCompleteSearch(value);
                  } else {
                    // Clear out the results
                    setState(() {
                      predictions = [];
                      endPosition = null;
                    });
                  }
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      predictions[index].description.toString(),
                    ),
                    onTap: () async {
                      final placeId = predictions[index].placeId!;
                      final details = await googlePlace.details.get(placeId);
                      if (details != null &&
                          details.result != null &&
                          details.result!.geometry != null &&
                          details.result!.geometry!.location != null &&
                          mounted) {
                        setState(() {
                          endPosition = Location(
                            latitude:
                                details.result!.geometry!.location!.lat ?? 0.0,
                            longitude:
                                details.result!.geometry!.location!.lng ?? 0.0,
                          );
                          _endSearchFieldController.text =
                              details.result!.name!;
                          predictions = [];
                        });
                      }

                      if (startPosition != null && endPosition != null) {
                        print('navigate');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              startPosition: LatLng(
                                startPosition!.latitude ?? 0.0,
                                startPosition!.longitude ?? 0.0,
                              ),
                              endPosition: LatLng(
                                endPosition!.latitude ?? 0.0,
                                endPosition!.longitude ?? 0.0,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
