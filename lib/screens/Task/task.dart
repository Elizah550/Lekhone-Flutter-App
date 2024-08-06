// import 'package:flutter/material.dart';

// void main() {
//   runApp(Ticketapp());
// }

// class Ticketapp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TicketScreen(),
//       theme: ThemeData(
//         brightness: Brightness.dark, // Set the overall theme brightness to dark
//       ),
//     );
//   }
// }

// class TicketScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, // Set the Scaffold background to black
//       appBar: AppBar(
//         title: Text(
//           'Your tickets',
//           style: TextStyle(
//               color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: Row(
//               mainAxisSize:
//                   MainAxisSize.min, // Minimize the space the row takes up
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle upcoming tickets
//                   },
//                   child: Text(
//                     'Upcoming',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle ticket history
//                   },
//                   child: Text('History'),
//                   style: ElevatedButton.styleFrom(
//                     primary:
//                         Color(0xFFDF3554), // Change to match the background
//                     onPrimary: Colors.white, // Text color for outlined button
//                     // side: BorderSide(
//                     //   color: Color(0xFFDF3554), // Border color
//                     // ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 4, // Number of tickets
//               itemBuilder: (context, index) {
//                 return TicketCard();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TicketCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.grey[900], // Cards with a dark color
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: Icon(Icons.music_note, color: Colors.white), // Icon color
//         title: Text('Artist Name', style: TextStyle(color: Colors.white)),
//         subtitle: Text('Tour 2023', style: TextStyle(color: Colors.white)),
//         trailing: Text('Time and Date', style: TextStyle(color: Colors.white)),
//       ),
//     );
//   }
// }
