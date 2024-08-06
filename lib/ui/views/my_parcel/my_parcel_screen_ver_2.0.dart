// import 'dart:convert';
// import 'package:Lekhone/screens/OrderDetails/single_order.dart';
// import 'package:Lekhone/ui/widgets/widgets.dart';
// import 'package:Lekhone/utils/image_utils.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class MyParcelScreen extends StatefulWidget {
//   const MyParcelScreen({Key? key}) : super(key: key);

//   @override
//   _MyParcelScreenState createState() => _MyParcelScreenState();
// }

// class _MyParcelScreenState extends State<MyParcelScreen> {
//   int tripIdLength = 0;
//   List<Map<String, String>> parcelDetailsList = [];
//   String userInput = "";
//   TextEditingController userInputController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchData1();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           title: Center(
//             child: Text(
//               'Track Parcel',
//               style: Theme.of(context).textTheme.displayLarge,
//             ),
//           ),
//           floating: true,
//           snap: false,
//           pinned: true,
//           titleSpacing: 0.0,
//           actions: [],
//           shadowColor: Colors.transparent,
//           expandedHeight: 316,
//           backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(16),
//               bottomLeft: Radius.circular(16),
//             ),
//           ),
//           flexibleSpace: FlexibleSpaceBar(
//             background: Column(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 40,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Enter parcel number or scan QR code',
//                           style: Theme.of(context).textTheme.headlineSmall,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             top: 7,
//                             bottom: 40,
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   height: 49,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .background,
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                   ),
//                                   child: TextField(
//                                     controller: userInputController,
//                                     style: TextStyle(color: Colors.black),
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: 'Tracking number',
//                                       focusedBorder: InputBorder.none,
//                                     ),
//                                     onChanged: (value) {
//                                       setState(() {
//                                         userInput = value;
//                                       });
//                                       if (value.isEmpty) {
//                                         fetchData1();
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Container(
//                                 height: 49,
//                                 width: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   color:
//                                       Theme.of(context).colorScheme.background,
//                                 ),
//                                 padding: const EdgeInsets.all(12),
//                                 child: GestureDetector(
//                                   child: Icon(
//                                     Icons.qr_code,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 48,
//                           width: double.infinity,
//                           child: TextButton(
//                             style: Theme.of(context).textButtonTheme.style,
//                             onPressed: () {
//                               trackParcel();
//                             },
//                             child: Text(
//                               'Track Parcel',
//                               style: Theme.of(context).textTheme.bodyLarge,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SliverPadding(
//           padding: EdgeInsets.only(top: 32),
//         ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               if (index < parcelDetailsList.length) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SingleOrder(
//                           parcelDetails: parcelDetailsList[index],
//                         ),
//                       ),
//                     );
//                   },
//                   child: MyParcelWidget(
//                     parcelDetails: parcelDetailsList[index],
//                   ),
//                 );
//               } else if (userInput.isNotEmpty && parcelDetailsList.isEmpty) {
//                 noData();
//                 return Container();
//               } else {
//                 return Container();
//               }
//             },
//             childCount: parcelDetailsList.length,
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> fetchData1() async {
//     final url =
//         'https://qx5v7wh8me.execute-api.ap-south-1.amazonaws.com/Trip_details';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         List<String> tripIds =
//             data.map((item) => item['Trip_id'].toString()).toList();

//         setState(() {
//           tripIdLength = tripIds.length;
//           parcelDetailsList = List<Map<String, String>>.from(data.map((item) {
//             Map<String, String> convertedItem = {};
//             item.forEach((key, value) {
//               convertedItem[key] = value.toString();
//             });
//             return convertedItem;
//           }));
//         });
//       } else {
//         print('Failed to load parcel details: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   Future<void> trackParcel() async {
//     if (parcelDetailsList.isEmpty) {
//       await fetchData1();
//     }

//     List<Map<String, String>> filteredList = parcelDetailsList
//         .where((parcel) =>
//             parcel['Trip_id']!.toUpperCase() == userInput.toUpperCase())
//         .toList();

//     setState(() {
//       if (userInput.isNotEmpty) {
//         tripIdLength = filteredList.length;
//         parcelDetailsList = List<Map<String, String>>.from(filteredList);
//         print(parcelDetailsList);
//       } else {
//         fetchData1();
//       }
//       if (userInput.isNotEmpty && filteredList.isEmpty) {
//         noData();
//       }
//     });
//   }

//   void noData() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             "No Data",
//             style: TextStyle(color: Colors.yellow, fontSize: 20),
//           ),
//           content: Text(
//             "No matching data found for the entered input.",
//             style: TextStyle(color: Colors.white, fontSize: 14),
//           ),
//           backgroundColor: Colors.black,
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 "OK",
//                 style: TextStyle(color: Colors.yellow),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
