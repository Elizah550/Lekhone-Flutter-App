import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update the UI when the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Color _getIndicatorColor(int tabIndex) {
    return _tabController.index == tabIndex ? Colors.white : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54.withOpacity(0.1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // Upper yellow part
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.yellow,
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
                    'Hello',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  //SizedBox(height: 10),
                  Text(
                    'Prathyusha',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    // Wrap the TabBar with a container to add border
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Set border color to black
                        width: 2, // Set border width
                      ),
                      borderRadius: BorderRadius.circular(20), // Set border radius to match tab border radius
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50), // Round the corners
                        color: Colors.black, // Change indicator color to black
                      ),
                      indicatorSize: TabBarIndicatorSize.tab, // Use tab size for indicator
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
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
                    _buildDeliveryCard('Delivery Number', 'Order ID: #12345', 'Pickup: Location A', 'Drop: Location B'),
                    _buildRecentOrdersCard(),
                  ],
                ),
                // Upcoming Tab View
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildStatsCardNew('Stats', '1564', 'pickupLocation', 'dropLocation'),
                    _buildOrderOnlineCard(
                      'Prathyusha',
                      'Location X -> Location Y',
                      // Add more parameters for order details as needed
                    ),
                    // Add more upcoming order cards here
                    _buildOrderOnlineCard(
                      'Another Name',
                      'Location A -> Location B',
                      // Add more parameters for order details as needed
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(String title, String orderId, String pickupLocation, String dropLocation) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white54,
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

  Widget _buildRecentOrdersCard() {
    List<String> recentOrders = [
      'Order ID: #78901 Pickup: Location M Drop: Location N',
      'Order ID: #78902 Pickup: Location X Drop: Location Y',
      'Order ID: #78902 Pickup: Location X Drop: Location Y',
      'Order ID: #78902 Pickup: Location X Drop: Location Y',
      // Add more recent order items as needed
    ];

    List<String> filteredOrders = recentOrders
        .where((order) => order.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white.withOpacity(1.0),
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
    String pickup = details.sublist(4, details.indexOf('Drop:')).join(' '); // Extract Pickup
    String drop = details.sublist(details.indexOf('Drop:') + 2).join(' '); // Extract Drop

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.local_shipping), // Shipping icon
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order ID: $orderId'),
                Text('Pickup: $pickup'),
                Text('Drop: $drop'),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Add functionality for button press
              },
              child: Text('Done'),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildStatsCardNew(String title, String orderId, String pickupLocation, String dropLocation) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white54,
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

  Widget _buildOrderOnlineCard(String name, String route) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white.withOpacity(1.0),
      shadowColor: Colors.white.withOpacity(0.5),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Online',
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
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        _showSnackBar('Order has been accepted', Colors.green);
                        // Add functionality for success icon press
                      },
                      icon: Icon(Icons.check_circle),
                      color: Colors.green,
                    ),
                    IconButton(
                      onPressed: () {
                        // Add functionality for cancel icon press
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
