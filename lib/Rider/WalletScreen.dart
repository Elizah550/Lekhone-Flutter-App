import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hi, User section
            Text(
              'Hi, User',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // TabBar for ongoing/upcoming
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Ongoing'),
                Tab(text: 'Upcoming'),
              ],
            ),
            // TabBarView to switch between tabs
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // DeliveryDetailsCard based on tab selection
                  DeliveryDetailsCard(),
                  // Another Widget for Upcoming section
                  // Replace this with your upcoming orders section
                  Placeholder(
                    color: Colors.grey,
                    fallbackHeight: 200,
                    fallbackWidth: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // RecentOrdersCard
            RecentOrdersCard(),
          ],
        ),
      ),
    );
  }
}

class DeliveryDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            // Replace with your delivery details content
            Text('Order Details: ...'),
            Text('Pickup Location: ...'),
            Text('Drop Location: ...'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

class RecentOrdersCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Orders',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Add your search bar widget here
                // Example: TextField(...)
              ],
            ),
            SizedBox(height: 12),
            // Replace with your order history content
            Text('Previous Order 1: ...'),
            Text('Previous Order 2: ...'),
            Text('Previous Order 3: ...'),
            // Add more orders as needed
          ],
        ),
      ),
    );
  }
}






// class MapScreen extends StatefulWidget {
//   final LocationResult? source;
//   final LocationResult? destination;
//
//   MapScreen({this.source, this.destination});
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   late Set<Polyline> polylines;
//   LatLng? userLocation;
//
//   @override
//   void initState() {
//     super.initState();
//     polylines = Set();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: widget.source?.geometry?.location ?? LatLng(0.0, 0.0),
//           zoom: 14.0,
//         ),
//         polylines: polylines,
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//       ),
//     );
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//       _showRoute();
//     });
//   }
//
//   void _showRoute() {
//     if (widget.source != null && widget.destination != null) {
//       List<LatLng> points = [
//         widget.source!.geometry!.location!,
//         widget.destination!.geometry!.location!,
//       ];
//
//       setState(() {
//         polylines.add(Polyline(
//           polylineId: PolylineId('route'),
//           points: points,
//           color: Colors.blue,
//           width: 4,
//         ));
//       });
//
//       // Adjust camera position to show both source and destination
//       LatLngBounds bounds = LatLngBounds(southwest: points[0], northeast: points[1]);
//       mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
//     }
//   }
// }


