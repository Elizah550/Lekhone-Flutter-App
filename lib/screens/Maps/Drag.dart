import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsClonePage extends StatefulWidget {
  @override
  _GoogleMapsClonePageState createState() => _GoogleMapsClonePageState();
}

class _GoogleMapsClonePageState extends State<GoogleMapsClonePage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _driverLocation = LatLng(17.7447, 83.2319); // N.A.D Vizag
  LatLng _destinationLocation =
      LatLng(17.7480, 83.2179); // Sujatha Nagar Bus Stop Vizag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomGoogleMap(
            driverLocation: _driverLocation,
            destinationLocation: _destinationLocation,
            controller: _controller,
          ),
          CustomHeader(),
          DraggableScrollableSheet(
            initialChildSize: 0.30,
            minChildSize: 0.15,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: CustomScrollViewContent(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomGoogleMap extends StatefulWidget {
  final LatLng driverLocation;
  final LatLng destinationLocation;
  final Completer<GoogleMapController> controller;

  CustomGoogleMap({
    required this.driverLocation,
    required this.destinationLocation,
    required this.controller,
  });

  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late GoogleMapController _mapController;
  late Marker _driverMarker;
  late Marker _destinationMarker;

  @override
  void initState() {
    super.initState();
    _driverMarker = Marker(
      markerId: MarkerId('driverMarker'),
      position: widget.driverLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );
    _destinationMarker = Marker(
      markerId: MarkerId('destinationMarker'),
      position: widget.destinationLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        widget.controller.complete(controller);
      },
      initialCameraPosition: CameraPosition(
        target: widget.driverLocation,
        zoom: 12.0,
      ),
      markers: Set.of([_driverMarker, _destinationMarker]),
    );
  }
}

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomSearchCategories(),
      ],
    );
  }
}

class CustomSearchCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
    );
  }
}

class CustomScrollViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: CustomInnerContent(),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 12),
        CustomDraggingHandle(),
        SizedBox(height: 16),
        CustomExploreBerlin(),
        SizedBox(height: 16),
        OrderDetails(
          orderNumber: 542,
          recipientName: "John Doe",
          dateOfArrival: "January 10, 2024",
          pickupLocation: "N.A.D Vizag",
          dropLocation: "Sujatha Nagar Bus Stop Vizag",
          estimatedDeliveryTime: "2:00 PM",
          tripId: "TRP542",
        ),
        SizedBox(height: 24),
        CustomFeaturedListsText(),
        SizedBox(height: 16),
        CustomFeaturedItemsGrid(),
        SizedBox(height: 24),
        CustomRecentPhotosText(),
        SizedBox(height: 16),
        CustomRecentPhotoLarge(),
        SizedBox(height: 12),
        CustomRecentPhotosSmall(),
        SizedBox(height: 16),
      ],
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
    );
  }
}

class CustomExploreBerlin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Order Details",
            style: TextStyle(
                fontSize: 22, color: Colors.black45, fontFamily: 'Poppins')),
        SizedBox(width: 8),
      ],
    );
  }
}

class OrderDetails extends StatelessWidget {
  final int orderNumber;
  final String recipientName;
  final String dateOfArrival;
  final String pickupLocation;
  final String dropLocation;
  final String estimatedDeliveryTime;
  final String tripId;

  OrderDetails({
    required this.orderNumber,
    required this.recipientName,
    required this.dateOfArrival,
    required this.pickupLocation,
    required this.dropLocation,
    required this.estimatedDeliveryTime,
    required this.tripId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("N: $recipientName",
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
              Text("DOA: $dateOfArrival",
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("PU: $pickupLocation",
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
              Text("DL: $dropLocation",
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ESD: $estimatedDeliveryTime",
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
              Text("TI: $tripId",
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomFeaturedListsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          Text("Featured Lists",
              style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
        ],
      ),
    );
  }
}

class CustomFeaturedItemsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        children: <Widget>[
          CustomFeaturedItem(),
          CustomFeaturedItem(),
          CustomFeaturedItem(),
          CustomFeaturedItem(),
        ],
      ),
    );
  }
}

class CustomRecentPhotosText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          Text("Recent Photos",
              style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
        ],
      ),
    );
  }
}

class CustomRecentPhotoLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomFeaturedItem(),
    );
  }
}

class CustomRecentPhotosSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFeaturedItemsGrid();
  }
}

class CustomRestaurantCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class CustomFeaturedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
