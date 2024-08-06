import 'package:Lekhone/ui/views/send_parcel/send_parcel_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Lekhone/src/locations.dart' as locations;
import 'package:Lekhone/ui/widgets/widgets.dart';
import 'package:Lekhone/utils/image_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParcelCenterScreen extends StatefulWidget {
  const ParcelCenterScreen({Key? key}) : super(key: key);

  @override
  State<ParcelCenterScreen> createState() => _ParcelCenterScreenState();
}

class _ParcelCenterScreenState extends State<ParcelCenterScreen> {
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();

    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(24, 24),
      ),
      ImageUtils.icMarker,
    );

    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          icon: customIcon,
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SendParcelScreen(),
              ),
            );
            // Navigator.pop(context);
          },
        ),
        title: Text(
          'Parcel center',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Parcel center',
                //   style: Theme.of(context).textTheme.displayLarge,
                // ),
                const SizedBox(height: 29),
                Container(
                  height: 221,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(0, 0),
                      zoom: 2,
                    ),
                    markers: _markers.values.toSet(),
                    myLocationButtonEnabled: false,
                    trafficEnabled: true,
                    gestureRecognizers: Set()
                      ..add(Factory<EagerGestureRecognizer>(
                          () => EagerGestureRecognizer())),
                  ),
                ),
                const SizedBox(height: 17),
                const ParcelOfficeWidget(
                  officeCode: 'NY0924',
                  officeName: '985 Meadow St.',
                  officeAddress: 'Staten Island, NY 10306',
                  officeStats: 'Fully occupied',
                  officeStatsNumber: 0.7,
                ),
                const ParcelOfficeWidget(
                  officeCode: 'NY0812',
                  officeName: '54 West Adams Court',
                  officeAddress: 'Rego Park, NY 11374',
                  officeStats: 'Lots of empty space',
                  officeStatsNumber: 0.3,
                ),
                const ParcelOfficeWidget(
                  officeCode: 'NY0924',
                  officeName: '985 Meadow St.',
                  officeAddress: 'Staten Island, NY 10306',
                  officeStats: 'Fully occupied',
                  officeStatsNumber: 0.9,
                ),
                const ParcelOfficeWidget(
                  officeCode: 'NY0812',
                  officeName: '54 West Adams Court',
                  officeAddress: 'Rego Park, NY 11374',
                  officeStats: 'Lots of empty space',
                  officeStatsNumber: 0.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
