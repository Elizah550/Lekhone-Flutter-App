import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:Lekhone/core/utils/color_constant.dart';
import 'package:Lekhone/core/utils/image_constant.dart';
import 'package:Lekhone/core/utils/size_utils.dart';
import 'package:Lekhone/screens/tracking_details_screen/widgets/custom_image_view.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:Lekhone/screens/live_tracking_screen/live_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTrackingOneScreen extends StatefulWidget {
  const LiveTrackingOneScreen({Key? key}) : super(key: key);

  @override
  State<LiveTrackingOneScreen> createState() => _LiveTrackingOneScreenState();
}

class _LiveTrackingOneScreenState extends State<LiveTrackingOneScreen> {
  late GoogleMapController _controller;

  final LatLng startLocation = LatLng(17.7447, 83.2319);
  final LatLng endLocation = LatLng(17.7986, 83.2145);

  Set<Marker> _markers = {};
  List<LatLng> _polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
    _setPolylineCoordinates();
  }

  Future<void> _loadMarkers() async {
    _markers.add(
      await _createMarker(
        startLocation,
        'Start',
        'assets/images/bike.png',
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ),
    );
    _markers.add(
      await _createMarker(
        endLocation,
        'End',
        'assets/images/box.png',
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      ),
    );
  }

  Future<Marker> _createMarker(LatLng position, String markerId,
      String assetName, BitmapDescriptor descriptor) async {
    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      icon: descriptor,
    );
  }

  void _setPolylineCoordinates() {
    _polylineCoordinates.add(startLocation);
    _polylineCoordinates.add(endLocation);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: ColorfulSafeArea(
        color: ColorConstant.whiteA700,
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: ColorConstant.whiteA700,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: onTapArrowLeft,
            ),
            title: Text('Live tracking'),
          ),
          body: Stack(
            children: [
              GoogleMap(
                markers: _markers,
                polylines: {
                  Polyline(
                    polylineId: PolylineId('path'),
                    color: Colors.black,
                    points: _polylineCoordinates,
                    width: 3,
                  ),
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(17.7720, 83.2227),
                  zoom: 15, // Adjust the zoom level
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  _controller.moveCamera(
                    CameraUpdate.newLatLngBounds(
                      LatLngBounds(
                        southwest: LatLng(17.7447, 83.2319),
                        northeast: LatLng(17.7986, 83.2145),
                      ),
                      30.0, // padding
                    ),
                  );
                  _controller.setMapStyle(_mapStyle);
                },
                gestureRecognizers: Set(),
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                mapType: MapType.normal,
              ),
              Padding(
                padding: EdgeInsets.only(right: 30, bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(), // Pushes the buttons to the bottom
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return LiveTrackingScreen();
                          },
                        );
                      },
                      child: Container(
                        width: getSize(60),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(getHorizontalSize(8)),
                          color: ColorConstant.whiteA700,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: CustomImageView(
                            svgPath: ImageConstant.trackingLocationIcon,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getVerticalSize(16),
                    ),
                    Container(
                      width: getSize(60),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(getHorizontalSize(8)),
                        color: ColorConstant.whiteA700,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 18, bottom: 18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgMinusIcon,
                            ),
                            SizedBox(
                              height: getVerticalSize(9),
                            ),
                            Divider(
                              color: ColorConstant.gray300,
                            ),
                            SizedBox(
                              height: getVerticalSize(9),
                            ),
                            CustomImageView(
                              svgPath: ImageConstant.imgAddIcon,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: getVerticalSize(16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapArrowLeft() {
    Navigator.pop(context);
  }

  final String _mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#242f3e"
        }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#746855"
        }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#242f3e"
        }
      ]
    },
    {
      "featureType": "administrative.locality",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#d59563"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#d59563"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#263c3f"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#6b9a76"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#38414e"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry.stroke",
      "stylers": [
        {
          "color": "#212a37"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9ca5b3"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#746855"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry.stroke",
      "stylers": [
        {
          "color": "#1f2835"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#f3d19c"
        }
      ]
    },
    {
      "featureType": "transit",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#2f3948"
        }
      ]
    },
    {
      "featureType": "transit.station",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#d59563"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#17263c"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#515c6d"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#17263c"
        }
      ]
    }
  ]
  ''';
}
