// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Order Progress'),
//         ),
//         body: OrderProgress(),
//       ),
//     );
//   }
// }

// class OrderProgress extends StatefulWidget {
//   @override
//   OrderProgressState createState() => OrderProgressState();
// }

// class OrderProgressState extends State<OrderProgress> {
//   List<String> orderStages = [
//     'Order Processing',
//     'Order Shipped',
//     'Order Delivered',
//   ];

//   Map<String, List<String>>? orderDetails = {
//     'Order Processing': ['Item 1 details', 'Item 2 details'],
//     'Order Shipped': ['Item 1 details', 'Item 2 details'],
//     'Order Delivered': ['Item 1 details', 'Item 2 details'],
//   };

//   String currentStage = 'Order Processing';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         LinearProgressIndicator(
//           value: orderStages.indexOf(currentStage) / (orderStages.length - 1),
//           minHeight: 20.0,
//           backgroundColor: Colors.grey[300],
//           valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//         ),
//         SizedBox(height: 20.0),
//         Expanded(
//           child: ListView.builder(
//             itemCount: orderStages.length,
//             itemBuilder: (context, index) {
//               return ExpansionTile(
//                 title: Text(orderStages[index]),
//                 initiallyExpanded: orderStages[index] == currentStage,
//                 children: orderDetails?[orderStages[index]]
//                         ?.map((detail) => ListTile(
//                               title: Text(detail),
//                             ))
//                         .toList() ??
//                     [], // Null-aware check for order details
//                 onExpansionChanged: (expanded) {
//                   setState(() {
//                     if (expanded) {
//                       currentStage = orderStages[index];
//                     } else {
//                       currentStage = ''; // Close dropdown on cancel
//                     }
//                   });
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }