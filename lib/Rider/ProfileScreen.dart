// import 'package:flutter/material.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Hi, User section
//             Text(
//               'Hi, User',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             // TabBar for ongoing/upcoming
//             TabBar(
//               controller: _tabController,
//               tabs: [
//                 Tab(text: 'Ongoing'),
//                 Tab(text: 'Upcoming'),
//               ],
//             ),
//             // TabBarView to switch between tabs
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   // DeliveryDetailsCard based on tab selection
//                   DeliveryDetailsCard(),
//                   // Another Widget for Upcoming section
//                   // Replace this with your upcoming orders section
//                   Placeholder(
//                     color: Colors.grey,
//                     fallbackHeight: 200,
//                     fallbackWidth: double.infinity,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             // RecentOrdersCard
//             RecentOrdersCard(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DeliveryDetailsCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Delivery Details',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
//             // Replace with your delivery details content
//             Text('Order Details: ...'),
//             Text('Pickup Location: ...'),
//             Text('Drop Location: ...'),
//             // Add more details as needed
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RecentOrdersCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Recent Orders',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 // Add your search bar widget here
//                 // Example: TextField(...)
//               ],
//             ),
//             SizedBox(height: 12),
//             // Replace with your order history content
//             Text('Previous Order 1: ...'),
//             Text('Previous Order 2: ...'),
//             Text('Previous Order 3: ...'),
//             // Add more orders as needed
//           ],
//         ),
//       ),
//     );
//   }
// }
