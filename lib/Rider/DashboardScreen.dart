import 'dart:convert';
import 'package:Lekhone/screens/Mapsearchscreen/search_screen.dart';
import 'package:Lekhone/screens/Signup/Rider_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TripData {
  final String tripId;
  final String dropLocation;
  final String Name;

  TripData(
      {required this.tripId, required this.dropLocation, required this.Name});

  factory TripData.fromJson(Map<String, dynamic> json) {
    return TripData(
        tripId: json['Trip_id'] ?? '',
        dropLocation: json['Address'] ?? '',
        Name: json['customer_name'] ?? '');
  }
}

class RiderDashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<RiderDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<TripData> upcomingOrdersData = [];

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> upcomingOrders = [];
  List<String> upcomingnames = [];
  List<String> ongoingOrders = [];
  String getDropLocation(String orderId) {
    // Find the TripData instance with the matching orderId
    TripData? trip = upcomingOrdersData.firstWhere(
      (trip) => trip.tripId == orderId,
      orElse: () => TripData(
          tripId: orderId, dropLocation: 'Default Drop Location', Name: 'Name'),
    );
    print(
        'Drop location for Order ID: #$orderId is ${trip.dropLocation} and name is ${trip.Name}');
    // Use the dropLocation from the found TripData instance
    return trip.dropLocation;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    fetchData1();
  }

  Future<void> fetchData1() async {
    final url =
        'https://yu5fn8rwdl.execute-api.ap-south-1.amazonaws.com/WH_Trip_Get/Trip_API';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        upcomingOrdersData = List<TripData>.from(
            jsonData.map((data) => TripData.fromJson(data)));
        List<TripData> tripDataList = List<TripData>.from(
            jsonData.map((data) => TripData.fromJson(data)));

        setState(() {
          // upcomingOrders = tripDataList.map((trip) => trip.tripId).toList();
          upcomingOrders =
              upcomingOrdersData.map((trip) => trip.tripId).toList();
          upcomingnames = upcomingOrdersData.map((trip) => trip.Name).toList();
        });
        print("Here are the details of the trip-----------------------");
        print(upcomingOrders);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Color _getIndicatorColor(int tabIndex) {
    return _tabController.index == tabIndex ? Colors.black : Colors.transparent;
  }

  void _moveOrderToOngoing(String orderId) {
    setState(() {
      upcomingOrders.remove(orderId);
      ongoingOrders.add(orderId);
    });
  }

  void _removeOrderFromUpcoming(String orderId) {
    setState(() {
      upcomingOrders.remove(orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFFCE00),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Pavan',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Stack(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.blue,
                            size: 30,
                          ),
                          Positioned(
                            right: -2,
                            top: -6,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '${upcomingOrders.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      indicatorWeight: 1,
                      unselectedLabelColor: Colors.white,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              color: _getIndicatorColor(0),
                            ),
                            child: Center(child: Text('Ongoing')),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: _getIndicatorColor(1),
                            ),
                            child: Center(child: Text('Upcoming')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Ongoing Tab View
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    for (String orderId in ongoingOrders)
                      _buildDeliveryCard(
                          orderId,
                          'Order ID: #$orderId',
                          'Pickup: Laundry - A',
                          'Drop:${getDropLocation(orderId)}'),
                    _buildRecentOrdersCard(),
                  ],
                ),
                // Upcoming Tab View
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    for (String orderId in upcomingOrders)
                      _buildOrderOnlineCard(
                        'Order ID: #$orderId',
                        'Lekhone warehouse -> ${getDropLocation(orderId)}',
                        // 'Location A -> Location B',
                        onAccept: () {
                          _moveOrderToOngoing(orderId);
                        },
                        onCancel: () {
                          _removeOrderFromUpcoming(orderId);
                        },
                      ),
                    _buildStatsCardNew(
                        'Stats', '1564', 'pickupLocation', 'dropLocation'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(String orderId, String title, String pickupLocation,
      String dropLocation) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shadowColor: Colors.blue.withOpacity(0.5),
      elevation: 4,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(height: 5),
            Text(
              orderId,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(pickupLocation),
            Text(dropLocation),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            _showSnackBar(
                'Let\'s Go button pressed for Order #$orderId', Colors.blue);
            // Add functionality for "Let's Go" button press
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                    orderId: orderId, dropLocation: getDropLocation(orderId)),
              ),
            );
          },
          child: Text("Let's Go"),
        ),
      ),
    );
  }

  Widget _buildRecentOrdersCard() {
    List<String> recentOrders = [
      'Order ID: #78901 Pickup: Location M Drop: Location N',
      'Order ID: #78902 Pickup: Location X Drop: Location Y',
      'Order ID: #78903 Pickup: Location X Drop: Location Y',
      'Order ID: #78904 Pickup: Location X Drop: Location Y',
      // Add more recent order items as needed
    ];

    List<String> filteredOrders = recentOrders
        .where(
            (order) => order.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shadowColor: Colors.white.withOpacity(0.5),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'Recent Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            if (filteredOrders.isNotEmpty)
              Column(
                children: filteredOrders
                    .map((order) => _buildRecentOrderItem(order))
                    .toList(),
              )
            else
              Text('No orders found'),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrderItem(String orderDetails) {
    List<String> details = orderDetails.split(' ');
    String orderId = details[2]; // Extract Order ID
    String pickup = details
        .sublist(4, details.indexOf('Drop:'))
        .join(' '); // Extract Pickup
    String drop =
        details.sublist(details.indexOf('Drop:') + 2).join(' '); // Extract Drop

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.local_shipping),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: $orderId',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Pickup: $pickup'),
                  Text('Drop: $drop'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showSnackBar('Let\'s Go button pressed for Order #$orderId',
                    Colors.blue);
                // Add functionality for "Let's Go" button press
              },
              child: Text("Let's Go"),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildStatsCardNew(String title, String orderId, String pickupLocation,
      String dropLocation) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shadowColor: Colors.blue.withOpacity(0.5),
      elevation: 4,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(height: 5),
            Text(
              orderId,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(pickupLocation),
            Text(dropLocation),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderOnlineCard(
    String title,
    String route, {
    VoidCallback? onAccept,
    VoidCallback? onCancel,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shadowColor: Colors.white.withOpacity(0.5),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(route),
                      Text(
                        'Pickup -> Drop location',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (onAccept != null) {
                          onAccept();
                        }
                        _showSnackBar('Order has been accepted', Colors.green);
                      },
                      icon: Icon(Icons.check_circle),
                      color: Colors.green,
                    ),
                    IconButton(
                      onPressed: () {
                        if (onCancel != null) {
                          onCancel();
                        }
                        _showSnackBar('Order has been cancelled', Colors.red);
                      },
                      icon: Icon(Icons.cancel),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
      ),
    );
  }
}
